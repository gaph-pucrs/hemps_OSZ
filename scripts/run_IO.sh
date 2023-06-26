hroot=~/hemps_OSZ

scripts=$hroot/scripts
testcases=$hroot/testcases/IOsemap
logs=$testcases/logs

rm -f $logs/*

cd $testcases
# for appIO in aesIO dijkstraIO dtwIO fixeIO mpegIO syntheticIO vopdIO wmdIO
for appIO in dtwIO mpegIO syntheticIO wmdIO
# for appIO in mpeg4IO
do
    rm -fr $testcases/$appIO
    nohup hemps-run $testcases/$appIO.yaml 30 > $logs/$appIO.txt &
done
