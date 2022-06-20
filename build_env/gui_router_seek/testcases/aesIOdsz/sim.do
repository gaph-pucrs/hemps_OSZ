vsim -t ps +notimingchecks hardware/work.test_bench

do wave.do
onerror {resume}
radix hex
set NumericStdNoWarnings 1
set StdArithNoWarnings 1


when -label end_of_simulation { HeMPS/local0x0/end_sim_reg == x"00000000" } {echo "End of simulation" ; quit ;}
run 30ms
exit