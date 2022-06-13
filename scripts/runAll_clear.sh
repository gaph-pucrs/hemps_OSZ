hroot=/sim/hemps_OSZ

scripts=$hroot/scripts
testcases=$hroot/testcases

rm -f $scripts/runAll_pids.txt
rm -f $scripts/logs/*

cd $testcases/noIO
for app in aes dijkstra dtw fixe mpeg mpeg4 synthetic vopd wmd
do
    rm -fr $testcases/noIO/$app
done

cd $testcases/IO
for appIO in aesIO dijkstraIO dtwIO fixeIO mpegIO mpeg4IO syntheticIO vopdIO wmdIO
do
    rm -fr $testcases/IO/$appIO
done
