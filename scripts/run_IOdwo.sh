hroot=/sim/faccenda/hemps_OSZ

scripts=$hroot/scripts
testcases=$hroot/testcases

rm -f $scripts/logs/*

cd $testcases/IOdwo
for appIOdwo in aesIOdwo dijkstraIOdwo dtwIOdwo fixeIOdwo mpegIOdwo mpeg4IOdwo syntheticIOdwo vopdIOdwo wmdIOdwo
do
    echo "$appIOdwo:" >> $scripts/runAll_pids.txt
    rm -fr $testcases/IOdwo/$appIOdwo
    nohup hemps-run $testcases/IOdwo/$appIOdwo.yaml 100 &>> $scripts/logs/$appIOdwo.txt & echo $! >> $scripts/runAll_pids.txt
    echo "" >> $scripts/runAll_pids.txt
done
