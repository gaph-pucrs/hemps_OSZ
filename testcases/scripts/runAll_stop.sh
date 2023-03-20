hroot=/sim/hemps_OSZ

scripts=$hroot/scripts
testcases=$hroot/testcases

n=0
while read p; do
    if [ $n -eq 1 ]; then
        kill $p
    fi
    let "n += 1"
    let "n %= 3"
done < $scripts/runAll_pids.txt
