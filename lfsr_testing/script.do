vlib work
vcom -2008 ./hemps_pkg.vhd
vcom -2008 ../hardware/vhdl/standards.vhd
vcom -2008 ../hardware/vhdl/pe/router/seek/seek_pkg.vhd
vcom -2008 ../hardware/vhdl/snip/snip_pkg.vhd
vcom -2008 ../hardware/vhdl/snip/snip_lfsr.vhd
vcom -2008 ../hardware/vhdl/snip/snip_key_generator.vhd
vcom -2008 ./lfsr_testbench.vhd
vsim -voptargs="+acc" work.testbench
add wave sim:/testbench/KeyGenerator/*
add wave sim:/testbench/keyGenerator/SnipLFSR/*
run 100 us
