hroot=/sim/faccenda/hemps_OSZ

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

cd $testcases/IOdwo
for appIOdwo in aesIOdwo dijkstraIOdwo dtwIOdwo fixeIOdwo mpegIOdwo mpeg4IOdwo syntheticIOdwo vopdIOdwo wmdIOdwo
do
    echo "$appIOdwo:" >> $scripts/runAll_pids.txt
    rm -fr $testcases/IOdwo/$appIOdwo
    nohup hemps-run $testcases/IOdwo/$appIO.yaml 100 &>> $scripts/logs/$appIOdwo.txt & echo $! >> $scripts/runAll_pids.txt
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

nohup hemps-run dijkstraIOdwo.yaml 10 &>> dijkstraIOdwo.txt&
nohup hemps-run fixeIOdwo.yaml 10 &>> fixeIOdwo.txt&
nohup hemps-run dtwIOdwo.yaml 10 &>> dtwIOdwo.txt&
nohup hemps-run mpeg4IOdwo.yaml 30 &>> mpeg4IOdwo.txt&
nohup hemps-run syntheticIOdwo.yaml 10 &>> syntheticIOdwo.txt&
nohup hemps-run aesIOdwo.yaml 10 &>> aesIOdwo.txt&
nohup hemps-run mpegIOdwo.yaml 10 &>> mpegIOdwo.txt&
nohup hemps-run vopdIOdwo.yaml 10 &>> vopdIOdwo.txt&
nohup hemps-run wmdIOdwo.yaml 10 &>> wmdIOdwo.txt&

nohup hemps-run scen1.yaml 20 &>> scen1.txt&
nohup hemps-run scen1_noMask.yaml 20 &>> scen1_noMask.txt&
nohup hemps-run scen1_noIO.yaml 20 &>> scen1_noIO.txt&
nohup hemps-run scen1_semap.yaml 20 &>> scen1_semap.txt&

nohup hemps-gen scen1.yaml 20 &>> scen1.txt&
nohup hemps-gen scen1_noMask.yaml 20 &>> scen1_noMask.txt&
nohup hemps-gen scen1_noIO.yaml 20 &>> scen1_noIO.txt&
nohup hemps-gen scen1_semap.yaml 20 &>> scen1_semap.txt&



