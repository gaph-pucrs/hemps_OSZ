source ./config.sh

n=0
while read p; do
    if [ $n -eq 1 ]; then
        kill $p
    fi
    let "n += 1"
    let "n %= 3"
done < $iscasdir/scripts/runall_pids.txt
