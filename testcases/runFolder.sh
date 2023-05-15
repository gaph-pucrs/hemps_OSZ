#-------------------------------------------------------------------------------------------------------#
#  How to use:                                                                                          #
#    1. Copy this script to hemps_osz/sandbox                                                           #
#    2. Edit line 12 to match the path to the hemps_osz root folder                                     #
#    3. Call the script using 'sh runFolder.sh <folderName> <simulationTime>'                           #
#                                                                                                       #
#  Example:                                                                                             #
#    sh runFolder.sh nonsecureIO 10                                                                     #
#    Runs all testcases in the nonsecureIO folder for 10 ms, results are placed in sandbox/nonsecureIO  #
#-------------------------------------------------------------------------------------------------------#

hemps_folder=/path/to/hemps_OSZ

folder=$1
simtime=$2

rm -rf ${hemps_folder}/sandbox/${folder}
cp -R ${hemps_folder}/testcases/${folder} ${hemps_folder}/sandbox/${folder}

cd ${hemps_folder}/sandbox/${folder}
for file in *.yaml
do  
    nohup hemps-run ${file} $simtime &>> ${file}.txt &
done
