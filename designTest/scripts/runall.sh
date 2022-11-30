source ./config.sh

rm -f $iscasdir/scripts/runall_pids.txt

for scen in baseline scen2_common scen2_sec niflood_common niflood_sec
do
    echo "$scen:" >> $iscasdir/scripts/runall_pids.txt
    sh $iscasdir/scripts/build.sh $scen

    cd $simdir
    nohup hemps-run $simdir/$scen.yaml $runtime &>> $simdir/$scen.txt & echo $! >> $iscasdir/scripts/runall_pids.txt
    cd $iscasdir/scripts

    echo "" >> $iscasdir/scripts/runall_pids.txt
done
