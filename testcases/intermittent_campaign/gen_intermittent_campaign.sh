hemps_folder=/home/gustavo.comaru/hemps_OSZ

sim_folder=intermittent_campaign

rm -rf ${hemps_folder}/sandbox/${sim_folder}
cp -R ${hemps_folder}/testcases/${sim_folder} ${hemps_folder}/sandbox/${sim_folder}

cd ${hemps_folder}/sandbox/${sim_folder}
for file in *.yaml
do  
    cp ./${file%.*}.h ${hemps_folder}/software/modules/probe_defines.h
    hemps-gen ${file}
    cd ${file%.*}
    make all
    cd ..
done