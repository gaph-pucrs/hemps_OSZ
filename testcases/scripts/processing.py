import re
import os
from glob import glob
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Tuple

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


@dataclass
class HTStatus:
    """
    Representa o estado de um HT em um momento específico.
    """
    time: float  # Tempo em que o estado foi registrado (em ns)
    status: str  # Estado: 'enabled' ou 'disabled'

@dataclass
class HT:
    """
    Representa um HT (Host Terminal).
    """
    address: str  # Endereço do HT
    port: int  # Porta do HT
    type: str  # Tipo do HT
    status_history: List[HTStatus] = field(default_factory=list)  # Histórico de estados

    def update_status(self, time: float, status: str):
        """
        Atualiza o estado do HT no tempo especificado.
        """
        self.status_history.append(HTStatus(time, status))

    def calculate_disabled_period_mean(self) -> float:
        """
        Calcula a média dos períodos desabilitados.
        """
        disabled_periods = []
        sorted_history = sorted(self.status_history, key=lambda x: x.time)

        for i in range(len(sorted_history) - 1):
            if sorted_history[i].status == "disabled":
                duration = sorted_history[i + 1].time - sorted_history[i].time
                disabled_periods.append(duration)

        return sum(disabled_periods) / len(disabled_periods) if disabled_periods else 0

class HTManager:
    """
    Gerencia os HTs registrados.
    """
    def __init__(self):
        self.hts: Dict[Tuple[str, int], HT] = {}

    def process_line(self, line: str):
        """
        Processa uma linha do arquivo transcript para capturar informações de HTs.
        """
        pattern = (
            r"HT TYPE: (\S+) \| ADDRESS: (\S+) \| HT_PORT: (\d+) \| STATUS: (\S+) \| TIME: (\d+) ps"
        )
        match = re.search(pattern, line)
        if match:
            ht_type = match.group(1)
            address = match.group(2)
            port = int(match.group(3))
            status = match.group(4)
            time_ps = int(match.group(5))  # Tempo em ps
            time_ns = time_ps / 1_000  # Converte para ns

            key = (address, port)
            if key not in self.hts:
                # Cria um novo HT
                self.hts[key] = HT(address=address, port=port, type=ht_type)

            # Atualiza o status do HT
            self.hts[key].update_status(time_ns, status)

    def process_file(self, file_path: str):
        """
        Processa todas as linhas de um arquivo e registra os HTs e seus estados.
        """
        with open(file_path, 'r', encoding='utf-8') as file:
            for line in file:
                self.process_line(line)

    def list_all_hts(self) -> List[HT]:
        """
        Retorna a lista de todos os HTs registrados.
        """
        return list(self.hts.values())


import os

import os


def process_directory(size, delay, payload):
    # Input directory
    input_dir = f"sandbox/paper_gustavo/bh_intermittent_size_{size}_delay_{delay}_payload_{payload}/"
    transcript_file = os.path.join(input_dir, "transcript")
    logs_folder = os.path.join(input_dir, "log/")
    
    # Create output directory if it doesn't exist
    os.makedirs("simulation_data", exist_ok=True)
    
    # Output file names with parameters
    base_name = f"size_{size}_delay_{delay}_payload_{payload}"
    probe_output_file = os.path.join("simulation_data", f"{base_name}_probes.txt")
    ht_output_file = os.path.join("simulation_data", f"{base_name}_hts.txt")

    try:
        # Process log files to extract all probes
        all_probes = process_all_log_files(logs_folder)
        
        # Write processed probes to a file
        with open(probe_output_file, "w") as file:
            file.write(f"[PARAMETERS] size={size}, delay={delay}, payload={payload}\n\n")
            file.write("[INFO] Processed Probes:\n\n")
            for i, probe in enumerate(all_probes, start=1):
                file.write(f"--- Probe {i} ---\n")
                for field, value in vars(probe).items():
                    if field == "file_sources":
                        file.write(f"{field}: {', '.join(value)}\n")
                    else:
                        file.write(f"{field}: {value}\n")
                file.write("-" * 40 + "\n")
        print(f"✓ Probes saved to {probe_output_file}")

        # Process transcript file
        manager = HTManager()
        manager.process_file(transcript_file)
        
        # Write HT information to file
        with open(ht_output_file, 'w') as f:
            f.write(f"[PARAMETERS] size={size}, delay={delay}, payload={payload}\n\n")
            f.write("[INFO] Processed HTs:\n\n")
            for ht in manager.list_all_hts():
                f.write(f"HT Address: {ht.address}, Port: {ht.port}, Type: {ht.type}\n")
                for status in ht.status_history:
                    f.write(f"  Time: {status.time:.2f} ns, Status: {status.status}\n")
                f.write("-" * 40 + "\n")
        print(f"✓ HTs saved to {ht_output_file}\n")

    except FileNotFoundError:
        print(f"× Directory not found: {input_dir}")
    except Exception as e:
        print(f"× Processing failed for {input_dir}: {str(e)}")

if __name__ == "__main__":
    # Create main output directory
    os.makedirs("simulation_data", exist_ok=True)
    
    # Define parameter ranges
    sizes = [3, 5, 10]       # Example sizes
    delays = [1, 3, 5, 10]     # Example delays
    payloads = [0, 50, 200]    # Example payloads

    # Process all combinations
    for size in sizes:
        for delay in delays:
            for payload in payloads:
                print(f"\nProcessing size={size}, delay={delay}, payload={payload}")
                process_directory(size, delay, payload)
    
    print("\nAll simulations processed. Results saved in simulation_data folder.")