hroot=/sim/faccenda/hemps_OSZ

scripts=$hroot/scripts
testcases=$hroot/testcases/IOsemap
logs=$testcases/logs

rm -f $logs/*

cd $testcases
for appIO in aesIO dijkstraIO dtwIO fixeIO mpegIO mpeg4IO syntheticIO vopdIO wmdIO
do
    rm -fr $testcases/$appIO
    nohup hemps-run $testcases/$appIO.yaml 30 > $logs/$appIO.txt &
done
