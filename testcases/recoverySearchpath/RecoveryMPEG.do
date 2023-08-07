vsim -t ps +notimingchecks -voptargs=+acc hardware/work.test_bench

do wave.do
onerror {resume}
radix hex
set NumericStdNoWarnings 1
set StdArithNoWarnings 1


when -label end_of_simulation { HeMPS/local0x0/end_sim_reg == x"00000000" } {echo "End of simulation" ; quit ;}
run 1ms

force -freeze /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC_AP/coreRouter/tx 2#000000000 @ 3650us
force -freeze /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC_AP/coreRouter/rx 2#000000000 @ 3650us
run 30 ms

exit
