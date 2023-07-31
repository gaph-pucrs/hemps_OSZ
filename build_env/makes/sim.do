vsim -t ps +notimingchecks -voptargs=+acc hardware/work.test_bench

do wave.do
onerror {resume}
onbreak {quit}
radix hex
set NumericStdNoWarnings 1
set StdArithNoWarnings 1

