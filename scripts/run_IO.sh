hroot=~/hemps_OSZ

scripts=$hroot/scripts
testcases=$hroot/testcases/IOsemap
logs=$testcases/logs

rm -f $logs/*

cd $testcases
for appIO in aesIO dijkstraIO dtwIO fixeIO mpegIO syntheticIO vopdIO wmdIO
# for appIO in vopdIO wmdIO
do
    rm -fr $testcases/$appIO
    nohup hemps-run $testcases/$appIO.yaml 30 > $logs/$appIO.txt &
done
