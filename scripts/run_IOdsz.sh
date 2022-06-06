hroot=/sim/faccenda/hemps_OSZ

scripts=$hroot/scripts
testcases=$hroot/testcases/IOdsz
logs=$testcases/logs

rm -f $logs/*

cd $testcases/
for appIOdsz in aesIOdsz dijkstraIOdsz dtwIOdsz fixeIOdsz mpegIOdsz mpeg4IOdsz syntheticIOdsz vopdIOdsz wmdIOdsz
do
    rm -fr $testcases/$appIOdsz
    nohup hemps-run $testcases/$appIOdsz.yaml 30 > $logs/$appIOdsz.txt &
done