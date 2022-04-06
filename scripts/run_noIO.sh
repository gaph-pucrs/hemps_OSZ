hroot=/sim/faccenda/hemps_OSZ

scripts=$hroot/scripts
testcases=$hroot/testcases

rm -f $scripts/logs/*

cd $testcases/noIO
for app in aes dijkstra dtw fixe mpeg mpeg4 synthetic vopd wmd
do
    echo "$app:" >> $scripts/runAll_pids.txt
    rm -fr $testcases/noIO/$app
    nohup hemps-run $testcases/noIO/$app.yaml 100 &>> $scripts/logs/$app.txt & echo $! >> $scripts/runAll_pids.txt
    echo "" >> $scripts/runAll_pids.txt
done
