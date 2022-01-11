import sys
import os
import json
import yaml

# log files exceptions
class LOG_FOLDER_NOT_FOUND (Exception):
    '"Routers log folder not found"'
    def __init__(self, msg="Folder not found"):
        self.msg = msg
        super().__init__(self.msg)

class LOG_FOLDER_IS_EMPTY (Exception):
    '"Routers log folder is empty"'
    def __init__(self, msg="Folder is empty"):
        self.msg = msg
        super().__init__(self.msg)

class ROUTER_LOG_EXCEPTION (Exception):
    '"Json file not present"'
    def __init__(self, msg="Json file not present"):
        self.msg = msg
        super().__init__(self.msg)
# testcases files exceptions
class TESTCASE_NOT_FOUND_EXCEPTION (Exception):
    '"Yaml file not present!"'
    def __init__(self, msg="Yaml file not present!!"):
        self.msg = msg
        super().__init__(self.msg)
class TESTCASE_EXCEPTION (Exception):
    '"Yaml file inconsistent"'
    def __init__(self, msg="Yaml file inconsistent"):
        self.msg = msg
        super().__init__(self.msg)


HEMPS_PATH = os.environ.get('HEMPS_PATH')

def load_json(json_files,log_folder):
    logs=dict()
    for f in json_files:
        k = tuple([int(i) for i in f.replace(".json",'').replace("wrapper_",'').split('x')])
        print(f)
        print ("File: {} Keys: {}".format(f,k))
        try:
            logs.update({k:json.load(open(log_folder+f))}) # caso o arquivo venha consistente
        except :
            logs.update({k:json.loads(open(log_folder+f).read()+"]}")})
    return logs

def load_files(project_yaml:str):#-> tuple((int,int),dict):
    # Ler YAML
    TESTS_PATH = HEMPS_PATH+"/testcases/examples/"
    DEBUG_FDR = "/debug/router_seek/"
    try:
        print("Trying from this folder:"+TESTS_PATH)
        yaml_file = open(TESTS_PATH+project_yaml)
    except (Exception,FileNotFoundError):
        try:
            TESTS_PATH=os.environ.get("PWD")+'/'
            print("Trying from this folder:"+TESTS_PATH,file=sys.stderr)
            yaml_file = open(TESTS_PATH+project_yaml)
        except (Exception,FileNotFoundError):
            try:
                TESTS_PATH='../../testcases/examples'
                print("Trying from this folder:"+TESTS_PATH,file=sys.stderr)
                yaml_file = open(TESTS_PATH+project_yaml)
            except (Exception,FileNotFoundError):
                raise TESTCASE_NOT_FOUND_EXCEPTION
    TESTS_PATH=TESTS_PATH

    # Ler atributos YAML
    try:
        obj_yaml = yaml.safe_load(yaml_file)
        dim = obj_yaml['hw']['mpsoc_dimension']
    except Exception:
        raise TESTCASE_EXCEPTION
    
    # List folder
    
    log_folder = TESTS_PATH+project_yaml[:project_yaml.rfind('.')]+DEBUG_FDR
    try:
        json_wrappers=[a for a in os.listdir(log_folder) if 'wrapper_' in a] 
        json_files=[b for b in os.listdir(log_folder) if b not in json_wrappers]
        # json_files = os.listdir(log_folder)
    except Exception:
        raise LOG_FOLDER_NOT_FOUND
    
    logs=load_json(json_files,log_folder)
    # logs_wrappers=load_json(json_wrappers,log_folder)
    if len (logs) == 0:
        raise LOG_FOLDER_IS_EMPTY
    
    print(logs.keys())
    return (dim,logs)

# def __init__(self, *, object_hook=None, parse_float=None,
#             parse_int=None, parse_constant=None, strict=True,
#             object_pairs_hook=None):
# sys.

def main():
    project = sys.argv[1]
    print("project file:"+project)
    # print(load_values())
    try:
        load_files(project)
    except LOG_FOLDER_NOT_FOUND as lfnf:
        print(lfnf)
    except ROUTER_LOG_EXCEPTION as rle:
        print(rle)        
    except TESTCASE_NOT_FOUND_EXCEPTION as tnfe:
        print(tnfe)  
    except TESTCASE_EXCEPTION as te:
        print(te)  
        
    # Ler atributos YAML
  
    # f = open("Asymetric.yaml")
    # text = f.read()
    # obj = yaml.safe_load(text)
    # dim = obj['hw']['mpsoc_dimension']
    # dimension = obj['mpsoc_dimension']
    # print(dim)
    # print(text)



if __name__ == "__main__":
    main ()