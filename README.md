# hemps_OSZ - Gold 1.0

Versão da HeMPS com mecanismos de segurança:
* Opaque Secure Zones (OSZ)
* Session Manager
* Gray Area + Access Point (*alfa version*)
* Dynamic SZ
* _brNoC debugger_ (Artur) 

## Usage

Create a testcase based on [this Example](https://github.com/gaph-pucrs/hemps_OSZ/blob/SessionManager/testcases/examples/Example.yaml)

Enable the **Session Manager**:
```yaml
hw:
    session: yes
```

Enable the **Gray Area**:
```yaml
hw:
  gray_area:
    rows: [3]
    cols: [0]
```
***OBS: caso não for habilitada a GA, será automaticamente utilizada DSZ***

***OBS2: DSZ não tem limitação de mapeamento, recomenda-se mapeamento estático***

Run using
```bash
hemps-run Example.yaml <time_in_ms>
```
When done, open *brNoC Debugger*:
```bash
brnoc-debugger Example.yaml
```
## Dependências (máquinas do GAPH)
* Python 3.6 ou superior
```bash
yum install python36
```
* Tkinter
```bash
yum install python3-tkinter
```
* OOBTree
```bash
yum install python3-BTrees
```
* Java SDK
* SystemC Library
* Mips Compiler
