hroot=/sim/hemps_OSZ

scripts=$hroot/scripts
testcases=$hroot/testcases

rm -f $scripts/runAll_pids.txt
rm -f $scripts/logs/*

cd $testcases/noIO
for app in aes dijkstra dtw fixe mpeg mpeg4 synthetic vopd wmd
do
    echo "$app:" >> $scripts/runAll_pids.txt
    rm -fr $testcases/noIO/$app
    nohup hemps-run $testcases/noIO/$app.yaml 100 &>> $scripts/logs/$app.txt & echo $! >> $scripts/runAll_pids.txt
    echo "" >> $scripts/runAll_pids.txt
done

cd $testcases/IO
for appIO in aesIO dijkstraIO dtwIO fixeIO mpegIO mpeg4IO syntheticIO vopdIO wmdIO
do
    echo "$appIO:" >> $scripts/runAll_pids.txt
    rm -fr $testcases/IO/$appIO
    nohup hemps-run $testcases/IO/$appIO.yaml 100 &>> $scripts/logs/$appIO.txt & echo $! >> $scripts/runAll_pids.txt
    echo "" >> $scripts/runAll_pids.txt
done
