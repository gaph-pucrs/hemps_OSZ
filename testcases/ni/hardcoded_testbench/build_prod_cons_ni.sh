hemps_root=/home/gustavo.comaru/hemps_OSZ

testcase_name=prod_cons_ni
testcases=$hemps_root/testcases/ni/hardcoded_testbench

cd $testcases
rm -rf $testcases/$testcase_name
hemps-gen $testcase_name.yaml

cd $testcases/$testcase_name
make all

cp $testcases/${testcase_name}_tb.h $testcases/$testcase_name/hardware/sc/test_bench.h
cd $testcases/$testcase_name/hardware
make
