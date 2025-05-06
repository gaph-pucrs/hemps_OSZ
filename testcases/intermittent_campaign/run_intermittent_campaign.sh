hemps_folder=/home/gustavo.comaru/hemps_OSZ

sim_folder=intermittent_campaign

cd ${hemps_folder}/sandbox/${sim_folder}
for file in *.yaml
do  
    cd ${file%.*}
    nohup vsim -do sim.do &>> ../${file%.*}.txt &
    cd ..
done