import os
import sys
import time
import subprocess
import random
import yaml

def intToXY(num):
    x=int(num) >> 8
    y=int(num) & 0xFF
    return (x,y)

def clear_file(file_path):
    with open(file_path, 'w'):
        pass

# Example usage:
# x_limit = 3  # Replace this with your desired x-coordinate limit
# y_limit = 3   # Replace this with your desired y-coordinate limit
# num_coordinates = 3  # Replace this with the number of unique coordinates you want
# excluded_x_values = [0]  # Replace this with a list of x values to exclude
# excluded_y_values = [3]  # Replace this with a list of y values to exclude
def get_unique_random_coordinates(x_limit, y_limit, num_coordinates, excluded_x_values, excluded_y_values):
    random.seed(333)
    all_coordinates = [(x, y) for x in range(x_limit) for y in range(y_limit)
                       if x not in excluded_x_values and y not in excluded_y_values]
    return random.sample(all_coordinates, min(num_coordinates, len(all_coordinates)))

def process_new_lines(file_path, values):
    # Check if the file exists
    if not os.path.exists(file_path):
        print("Error: File does not exist.")
        return

    # Get the initial size of the file
    file_size = os.path.getsize(file_path)
    d = values["pes"]
    try:
        # Process existing lines in the file upon the first access
        with open(file_path, 'r') as file:
            lines = file.readlines()
            for line in lines:
                if "END" in line:
                    print(line)
                    return
                l = line.split()
                k = intToXY(l[1])
                try:
                    d[k] = d[k] + 1
                except KeyError:
                    pass

            # Move the file pointer to the end to start monitoring new lines
            file.seek(0, os.SEEK_END)
            for key, value in d.items():
                    if value > 30:
                        print(f"Key: {key}, Value: {value}")
        # print(d)
        clear_file("../signals")
        sleepcont = 0
        while True:
            # Check if the file size has changed
            current_size = os.path.getsize(file_path)
            if current_size > file_size :
                with open(file_path, 'r') as file:
                    sleepcont = 0
                    # Move the file pointer to the last position
                    file.seek(file_size)
                    # Read and process new lines
                    new_lines = file.readlines()
                    for line in new_lines:
                        if "END" in line:
                            print(line)
                            return
                        l = line.split()
                        k = intToXY(l[1])
                        try:
                            d[k] = d[k] + 1
                        except KeyError:
                            pass
                            # d[str(l[1])] = 1
                    # print(d)

                file_size = current_size  # Update the file size
                lastTime = round((int(l[0])*10)/1000) #last line time in ticks * 10 ns / 1000 = us
                sigs = open("../signals" , "a")
                # sigs.seek(0,2)
                for key, value in d.items():
                    if value > 30:
                        # keyXY = intToXY(key)
                        print(f"Key: {key}, Value: {value}")
                        sigs.write("/test_bench/HeMPS/slave"+str(key[0])+"x"+str(key[1])+"/RouterCCwrapped/RouterCC_AP/coreRouter/tx 0 "+ str(lastTime+100) +" us "+str(lastTime+600)+" us\n")              
                        d[key] = value - values["trigger_value"]
                sigs.close()
            sleepcont = sleepcont+1
            if sleepcont > 30:
                print("No more inputs in traffic file, exiting\n")
                return
            # Check if the file has been modified within the last 30 seconds
            time.sleep(values["scan_time"])  # Adjust the interval (in seconds) between checks

    except KeyboardInterrupt:
        print("\nExiting...")

def find_yaml_file_in_directory(directory):
    for filename in os.listdir(directory):
        if filename.endswith(".yaml"):
            return os.path.join(directory, filename)
    return None


def convert_to_dictionary(coordinates_list):
    dictionary = {}
    for coord in coordinates_list:
        dictionary[tuple(coord)] = 0
    return dictionary

def read_values_from_yaml(file_path):
    if not os.path.exists(file_path):
        print(f"Error: File '{file_path}' does not exist.")
        return None

    with open(file_path, 'r') as file:
        data = yaml.safe_load(file)

        # Access fields with default values in case of missing keys
        mpsoc_dimension = data["hw"].get("mpsoc_dimension", [4, 4])
        infection_rate = data["hw"]["faults"].get("infection_rate", 10)
        pes = data["hw"]["faults"].get("pes", "random")
        time_step = data["hw"]["faults"].get("time_step", 100)
        scan_time = data["hw"]["faults"].get("scan_time", 1)
        trigger_value = data["hw"]["faults"].get("trigger_value", 10)
        gray_area_rows = data["hw"]["gray_area"].get("rows", [3])
        gray_area_cols = data["hw"]["gray_area"].get("cols", [0])

        infected_pes = round(mpsoc_dimension[0] * mpsoc_dimension[1] * infection_rate/100)

        # Process the "pes" field differently based on its value
        if isinstance(pes, list):
            pes_dict = convert_to_dictionary(pes)
        elif pes == "random":
            random_coordinates = get_unique_random_coordinates(mpsoc_dimension[0], mpsoc_dimension[1], infected_pes, gray_area_rows, gray_area_cols)
            pes_dict = {coord: 0 for coord in random_coordinates}
        else:
            pes_dict = None

        print(pes_dict)
        # Put the information into one structure (dictionary)
        info_structure = {
            "pes": pes_dict,
            "time_step": time_step,
            "scan_time": scan_time,
            "trigger_value": trigger_value
        }
        # print(info_structure)

        return info_structure

if __name__ == "__main__":

    yaml_file_path = find_yaml_file_in_directory("../")
    values = read_values_from_yaml(yaml_file_path)
    print(values)
    file_path = "traffic_router.txt"
    process_new_lines(file_path,values)

