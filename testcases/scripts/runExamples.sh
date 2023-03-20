hroot=/sim/faccenda/hemps_OSZ

scripts=$hroot/scripts
testcases=$hroot/testcases

rm -f $testcases/examples/logsAll/*

cd $testcases/examples
for app in Asymetric CrossingSZ DynamicMapping DynamicMapping2 Example TaskMigration TaskMigration2
do
    rm -fr $testcases/examples/$app
    nohup hemps-run $testcases/examples/$app.yaml 30 >> $testcases/examples/logsAll/$app.txt &
done
