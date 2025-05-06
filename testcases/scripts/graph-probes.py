import matplotlib.pyplot as plt
from typing import List, Dict, Any, Tuple
import matplotlib.cm as cm
import numpy as np

def read_probe_data(file_path: str) -> List[Dict[str, Any]]:
    """Read probe data from file."""
    with open(file_path, "r") as file:
        data = file.read()
    
    probes = []
    for block in data.split("--- Probe")[1:]:
        probe = {}
        for line in block.splitlines():
            if ":" in line:
                key, value = map(str.strip, line.split(":", 1))
                probe[key] = value
        probes.append(probe)
    return probes

def parse_ht_times(file_path: str) -> List[Tuple[float, float]]:
    """Parse HT enable/disable times from file."""
    with open(file_path, "r") as file:
        data = file.read()
    
    times = []
    current_status = None
    last_time = None
    
    for line in data.splitlines():
        if "Time:" in line and "Status:" in line:
            time_ns = float(line.split("Time:")[1].split("ns")[0].strip())
            time_ms = time_ns / 1_000_000
            status = line.split("Status:")[1].strip().lower()
            
            if status == "enabled" and current_status != "enabled":
                last_time = time_ms
                current_status = "enabled"
            elif status == "disabled" and current_status == "enabled":
                times.append((last_time, time_ms))
                current_status = "disabled"
    
    return times

def filter_probes(probes: List[Dict[str, Any]], ht_pos: str, ht_dir: str = None) -> List[Dict[str, Any]]:
    """Filter probes by position and direction.
    Args:
        ht_pos: "all" or specific address like "0x00000104"
        ht_dir: None or one of ["N", "S", "E", "W"]
    """
    filtered = probes
    
    # Position filter
    if ht_pos.lower() != "all":
        filtered = [p for p in filtered if p.get("source") == ht_pos or p.get("target") == ht_pos]
    
    # Direction filter
    if ht_dir and ht_dir.upper() in ['N', 'S', 'E', 'W']:
        filtered = [p for p in filtered if p.get("path", "").upper() == ht_dir.upper()]
    
    return filtered

def plot_gantt_chart(probes: List[Dict[str, Any]], ht_periods: List[Tuple[float, float]]) -> None:
    """Plot Gantt chart with probes and HT uptime."""
    if not probes and not ht_periods:
        print("No data to plot!")
        return

    fig, (ax, ht_ax) = plt.subplots(
        nrows=2,
        figsize=(12, 6),
        gridspec_kw={"height_ratios": [0.85, 0.15]},
        sharex=True
    )
    
    # Plot probes and track active periods
    probe_active_periods = []
    if probes:
        batch_ids = list({p.get("batch_id", "0") for p in probes})
        colors = cm.rainbow(np.linspace(0, 1, len(batch_ids)))
        batch_color_map = {bid: color for bid, color in zip(batch_ids, colors)}
        
        valid_probe_times = []
        for i, probe in enumerate(probes):
            release = int(probe.get("release_time", 0)) / 100_000  # Probe times divided by 100,000
            arrive_str = probe.get("arrive_time", "None").strip()
            
            if arrive_str.lower() == "none":
                ax.barh(
                    y=i,
                    width=0.1,
                    left=release,
                    height=0.8,
                    color=batch_color_map[probe.get("batch_id", "0")],
                    alpha=0.5
                )
            else:
                arrive = int(arrive_str) / 100_000  # Probe times divided by 100,000
                valid_probe_times.append(arrive)
                ax.barh(
                    y=i,
                    width=arrive-release,
                    left=release,
                    height=0.8,
                    color=batch_color_map[probe.get("batch_id", "0")]
                )
                probe_active_periods.append((release, arrive))
        
        ax.set_ylabel("Probe Index")
        ax.set_yticks(range(len(probes)))
        ax.set_yticklabels([f"ID:{p.get('probe_id', 'N/A')}" for p in probes])
        ax.grid(True, linestyle="--", alpha=0.6)
        last_probe_time = max(valid_probe_times) if valid_probe_times else 0

    # Plot HT uptime and find overlaps (using raw HT times)
    if ht_periods:
        for start, end in ht_periods:
            ht_ax.barh(
                y=0,
                width=end-start,  # Using raw HT times
                left=start,       # Using raw HT times
                height=0.5,
                color="green",
                edgecolor="black"
            )
            
            # Check for overlaps with probes (convert HT times to match probe scale)
            for p_start, p_end in probe_active_periods:
                overlap_start = max(start, p_start)
                overlap_end = min(end, p_end)
                if overlap_start < overlap_end:
                    ax.axvline(x=overlap_start, color='red', linestyle='--', alpha=0.7, linewidth=1)
                    ax.axvline(x=overlap_end, color='red', linestyle='--', alpha=0.7, linewidth=1)
        
        ht_ax.set_yticks([0])
        ht_ax.set_yticklabels(["HT Status"])

    # Set X-axis limits based on probe times only
    max_time = last_probe_time * 1.05 if last_probe_time > 0 else 1
    ax.set_xlim(0, max_time)
    ax.set_xlabel("Time (ms)")
    ax.set_title(f"Probe Execution with HT Overlaps (N={len(probes)})")
    
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    # Load data
    probes = read_probe_data("simulation_data/size_5_delay_5_payload_0_probes.txt")
    ht_periods = parse_ht_times("simulation_data/size_5_delay_5_payload_0_hts.txt")
    
    # Apply filters
    ht_pos = "0x00000403"  # Example: filter by specific position
    ht_dir = "S"           # Example: filter by East direction
    # ht_pos = "all"  # Example: filter by specific position
    # ht_dir = None           # Example: filter by East direction
    filtered_probes = filter_probes(probes, ht_pos, ht_dir)
    
    # Plot
    plot_gantt_chart(filtered_probes, ht_periods)