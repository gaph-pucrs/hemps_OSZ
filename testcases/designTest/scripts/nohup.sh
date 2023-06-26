source ./config.sh

sh build.sh $1

cd $simdir
nohup hemps-run $simdir/$1.yaml $2 &>> $simdir/$1.txt & echo $!
cd $iscasdir/scripts
