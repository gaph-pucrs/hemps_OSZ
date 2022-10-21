hempsroot=/home/gustavo.comaru/hemps_OSZ

simdir=$hempsroot/testcases/iscas_simulations

sh build.sh $1
cd $simdir
hemps-run $1.yaml $2
