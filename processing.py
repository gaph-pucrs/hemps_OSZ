import re
import os
from glob import glob
from dataclasses import dataclass, field
from typing import Dict, List, Optional

@dataclass
class Probe:
    batch_id: int = None
    batch_config: str = None
    probe_id: int = None
    source: str = None
    target: str = None
    release_time: int = None
    arrive_time: int = None
    config_time: int = None
    result_time: int = None
    config_period: int = None
    effective_period: int = None
    net_period: int = None
    payload_size: int = None
    probe_type: str = None
    path: str = None
    status: str = None
    result: str = None
    file_sources: List[str] = field(default_factory=list)  # Lista de arquivos fonte

def parse_send_probe_message(line: str) -> Optional[Probe]:
    pattern = (
        r"\[HT\] SEND PROBE MESSAGE -- probe #(\d+) "
        r"from batch #(\d+) "
        r"src: (\S+) "
        r"tgt: (\S+) "
        r"path: (\S+) "
        r"payload_size: (\d+) "
        r"config_period: (\d+) "
        r"probe_type: (\S+) "
        r"release_time: @(\d+)"
    )
    match = re.match(pattern, line)
    if match:
        return Probe(
            probe_id=int(match.group(1)),
            batch_id=int(match.group(2)),
            source=match.group(3),
            target=match.group(4),
            path=match.group(5),
            payload_size=int(match.group(6)),
            config_period=int(match.group(7)),
            probe_type=match.group(8),
            release_time=int(match.group(9))
        )
    return None

def parse_recv_probe_message(line: str) -> Optional[Probe]:
    pattern = (
        r"\[HT\] RECV PROBE MESSAGE -- probe #(\d+) "
        r"src: (\S+) "
        r"tgt: (\S+) "
        r"arrive_time: @(\d+)"
    )
    match = re.match(pattern, line)
    if match:
        return Probe(
            probe_id=int(match.group(1)),
            source=match.group(2),
            target=match.group(3),
            arrive_time=int(match.group(4))
        )
    return None

def parse_probe_request_message(line: str) -> Optional[Probe]:
    pattern = (
        r"\[HT\] PROBE REQUEST -- probe #(\d+) "
        r"src: (\S+) "
        r"tgt: (\S+) "
        r"path: (\S+) "
        r"batch_cfg: (\S+) "
        r"time: @(\d+) "
        r"payload_size: (\d+) "
        r"config_period: (\d+)"
    )
    match = re.match(pattern, line)
    if match:
        return Probe(
            probe_id=int(match.group(1)),
            source=match.group(2),
            target=match.group(3),
            path=match.group(4),
            batch_config=match.group(5),
            config_time=int(match.group(6)),
            payload_size=int(match.group(7)),
            config_period=int(match.group(8))
        )
    return None

def parse_probe_results_message(line: str) -> Optional[Probe]:
    pattern = (
        r"\[HT\] PROBE RESULTS -- probe #(\d+) "
        r"src: (\S+) "
        r"tgt: (\S+) "
        r"result: (\S+) "
        r"time: @(\d+)"
    )
    match = re.match(pattern, line)
    if match:
        return Probe(
            probe_id=int(match.group(1)),
            source=match.group(2),
            target=match.group(3),
            result=match.group(4),
            result_time=int(match.group(5))
        )
    return None

def calculate_effective_and_net_periods(probes: List[Probe]):
    # Group probes by batch_id
    batches = {}
    for probe in probes:
        if probe.batch_id is not None:
            if probe.batch_id not in batches:
                batches[probe.batch_id] = []
            batches[probe.batch_id].append(probe)

    for batch_id, batch_probes in batches.items():
        # Sort batch probes by release_time
        batch_probes.sort(key=lambda p: p.release_time)
        effective_periods = []

        # Check if the first probe in the batch is successful
        batch_success = batch_probes[0].result == "SUCCESS" if batch_probes else False

        for i in range(len(batch_probes)):
            current_probe = batch_probes[i]

            # Propagate success if the batch is marked as successful
            if batch_success:
                current_probe.result = "SUCCESS"

            # Calculate net period for all probes
            if current_probe.release_time is not None and current_probe.arrive_time is not None:
                current_probe.net_period = current_probe.arrive_time - current_probe.release_time

            # Calculate effective period if there is a next probe
            if i < len(batch_probes) - 1:
                next_probe = batch_probes[i + 1]
                if current_probe.release_time is not None and next_probe.release_time is not None:
                    current_probe.effective_period = next_probe.release_time - current_probe.release_time
                    effective_periods.append(current_probe.effective_period)

        # For the last probe in the batch, calculate effective period as the average
        if effective_periods:
            last_probe = batch_probes[-1]
            if last_probe.release_time is not None:
                last_probe.effective_period = sum(effective_periods) // len(effective_periods)

def process_log_file(file_path: str, probes: Dict[int, Probe], batch_success: Dict[int, bool]):
    with open(file_path, 'r', encoding='utf-8') as file:
        for line in file:
            line = line.strip()

            # Processa como SEND PROBE MESSAGE
            probe = parse_send_probe_message(line)
            if probe:
                if probe.probe_id in probes:
                    existing_probe = probes[probe.probe_id]
                    existing_probe.batch_id = probe.batch_id
                    existing_probe.source = probe.source
                    existing_probe.target = probe.target
                    existing_probe.path = probe.path
                    existing_probe.payload_size = probe.payload_size
                    existing_probe.config_period = probe.config_period
                    existing_probe.probe_type = probe.probe_type
                    existing_probe.release_time = probe.release_time
                else:
                    probes[probe.probe_id] = probe

                if file_path not in probes[probe.probe_id].file_sources:
                    probes[probe.probe_id].file_sources.append(file_path)
                continue

            # Processa como RECV PROBE MESSAGE
            probe = parse_recv_probe_message(line)
            if probe:
                if probe.probe_id in probes:
                    existing_probe = probes[probe.probe_id]
                    existing_probe.arrive_time = probe.arrive_time
                    existing_probe.source = probe.source
                    existing_probe.target = probe.target
                else:
                    probes[probe.probe_id] = probe

                if file_path not in probes[probe.probe_id].file_sources:
                    probes[probe.probe_id].file_sources.append(file_path)
                continue

            # Processa como PROBE REQUEST
            probe = parse_probe_request_message(line)
            if probe:
                if probe.probe_id in probes:
                    existing_probe = probes[probe.probe_id]
                    existing_probe.batch_config = probe.batch_config
                    existing_probe.config_time = probe.config_time
                    existing_probe.payload_size = probe.payload_size
                    existing_probe.config_period = probe.config_period
                else:
                    probes[probe.probe_id] = probe

                if file_path not in probes[probe.probe_id].file_sources:
                    probes[probe.probe_id].file_sources.append(file_path)
                continue

            # Processa como PROBE RESULTS
            probe = parse_probe_results_message(line)
            if probe:
                if probe.probe_id in probes:
                    existing_probe = probes[probe.probe_id]
                    existing_probe.result = probe.result
                    existing_probe.result_time = probe.result_time
                    existing_probe.source = probe.source
                    existing_probe.target = probe.target

                    if probe.result == "SUCCESS":
                        batch_success[existing_probe.batch_id] = True

                        # Calculate effective period
                        if existing_probe.result_time is not None and existing_probe.release_time is not None:
                            existing_probe.effective_period = existing_probe.result_time - existing_probe.release_time
                else:
                    probes[probe.probe_id] = probe

                if file_path not in probes[probe.probe_id].file_sources:
                    probes[probe.probe_id].file_sources.append(file_path)

def process_all_log_files(directory_path: str) -> List[Probe]:
    probes = {}
    batch_success = {}  # Tracks batch success

    log_files = glob(os.path.join(directory_path, "log*.txt"))
    for log_file in log_files:
        process_log_file(log_file, probes, batch_success)

    # Propagate success status to all probes in successful batches
    for probe in probes.values():
        if probe.batch_id in batch_success and batch_success[probe.batch_id]:
            probe.result = "SUCCESS"

    # Calculate effective and net periods
    calculate_effective_and_net_periods(list(probes.values()))

    # Return probes sorted by their IDs
    return sorted(probes.values(), key=lambda x: x.probe_id)

if __name__ == "__main__":
    directory_path = "sandbox/paper_gustavo_baseline/baseline_bh/log"

    # Process log files to extract all probes
    all_probes = process_all_log_files(directory_path)

    # Define the output file name
    output_file = "processed_probes.txt"

    # Write processed probes to a file
    with open(output_file, "w") as file:
        file.write("[INFO] Probes Processadas:\n\n")
        for i, probe in enumerate(all_probes, start=1):
            file.write(f"--- Probe {i} ---\n")
            for field, value in vars(probe).items():
                if field == "file_sources":
                    # Exibe a lista de arquivos como uma string
                    file.write(f"{field}: {', '.join(value)}\n")
                else:
                    file.write(f"{field}: {value}\n")
            file.write("-" * 40 + "\n")

    print(f"[INFO] Processed probes have been written to '{output_file}'")
    