import os
from itertools import product

# Define static YAML content
static_yaml_content = """hw:
  page_size_KB: 128
  tasks_per_PE: 1
  repository_size_MB: 1
  physical_channels: 2
  model_description: hybrid
  noc_buffer_size: 8
  mpsoc_dimension: [5,5]
  cluster_dimension: [5,5]
  master_location: LT
  session: yes
  gray_area:
    rows: [0,1,2,3,4]
    cols: [0,1,2,3,4]
  open_port:
    - port: [Injector,90,0,4,N,0,2,W]
  ht: # e0 e1 w0 w1 n0 n1 s0 s1 l0 l1
    - router: [4,4,\"xxxxxx{marker}xx\"] # marker = drop packets start @ 2 ms
apps:
  - name: dtw
    start_time_ms: 0
    secure: no
    static_mapping:
      bank: [4,1]
      p1: [1,4]
      p2: [2,4]
      p3: [3,4]
      p4: [4,4]
      recognizer: [4,0]
"""

# Define static header content template
header_template = """#define BATCH_SIZE {batch_size}
#define BATCH_DELAY {batch_delay}
#define PROBE_PACKET_SIZE {probe_packet_size}
"""

# Variations for parameters
batch_sizes = [3, 5, 10]
batch_delays = [3, 5, 10]
probe_packet_sizes = [0, 50, 200]
markers = {"bh_intermittent": "II", "cb_intermittent": "ii"}

# Create all combinations of parameters
combinations = list(product(batch_sizes, batch_delays, probe_packet_sizes))

# Generate files
for marker_name, marker in markers.items():
    for batch_size, batch_delay, probe_packet_size in combinations:
        # File naming
        file_name = f"{marker_name}_size_{batch_size}_delay_{batch_delay}_payload_{probe_packet_size}"
        yaml_file = f"{file_name}.yaml"
        header_file = f"{file_name}.h"

        # Generate YAML content
        yaml_content = static_yaml_content.replace("{marker}", marker)

        # Generate header content
        header_content = header_template.format(
            batch_size=batch_size,
            batch_delay=batch_delay,
            probe_packet_size=probe_packet_size
        )

        # Write YAML file
        with open(yaml_file, "w") as yf:
            yf.write(yaml_content)

        # Write Header file
        with open(header_file, "w") as hf:
            hf.write(header_content)

print("File generation complete.")
