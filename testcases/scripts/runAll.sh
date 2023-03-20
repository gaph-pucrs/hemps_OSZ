hroot=/sim/faccenda/hemps_OSZ

scripts=$hroot/scripts
testcases=$hroot/testcases

rm -f $scripts/runAll_pids.txt
rm -f $scripts/logs/*

cd $testcases/examples
for app in aes dijkstra dtw fixe mpeg mpeg4 synthetic vopd wmd
do
    rm -fr $testcases/noIO/$app
    nohup hemps-run $testcases/examples/$app.yaml 100 &>>  $testcases/logsAll/$app.txt &
    echo "" >> $scripts/runAll_pids.txt
done
