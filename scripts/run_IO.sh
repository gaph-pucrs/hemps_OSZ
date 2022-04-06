hroot=/sim/faccenda/hemps_OSZ

scripts=$hroot/scripts
testcases=$hroot/testcases

rm -f $scripts/logs/*

cd $testcases/IO
for appIO in aesIO dijkstraIO dtwIO fixeIO mpegIO mpeg4IO syntheticIO vopdIO wmdIO
do
    echo "$appIO:" >> $scripts/runAll_pids.txt
    rm -fr $testcases/IO/$appIO
    nohup hemps-run $testcases/IO/$appIO.yaml 100 &>> $scripts/logs/$appIO.txt & echo $! >> $scripts/runAll_pids.txt
    echo "" >> $scripts/runAll_pids.txt
done
