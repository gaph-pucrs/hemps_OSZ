hempsroot=/home/gustavo.comaru/hemps_OSZ

simdir=$hempsroot/testcases/iscas_simulations
iscasdir=$hempsroot/iscas

cp $iscasdir/$1.h $hempsroot/hardware/sc/peripherals/IO_peripheral/sabotage_param.h

rm -f $simdir/$1.yaml
rm -rf $simdir/$1
rm -f $simdir/$1.txt

cp $iscasdir/$1.yaml $simdir/$1.yaml
cd $simdir
hemps-gen $1.yaml
