rm -f runall_pids.txt

for app in nonsec_prodcons nonsec_mpegs
do
    echo "$app:" >> runall_pids.txt
    
    rm -rf ./${app}/
    rm -f ./${app}.txt

    nohup hemps-run ${app}.yaml 30 &>> ./${app}.txt & echo $! >> runall_pids.txt

    echo "" >> runall_pids.txt
done
