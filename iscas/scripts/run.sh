source ./config.sh

sh build.sh $1

cd $simdir
hemps-run $simdir/$1.yaml $2
cd $iscasdir/scripts
