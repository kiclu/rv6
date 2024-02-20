import os
import re

def find_asm(log):
    return "/opt/riscv/target/share/riscv-tests/isa/" + log.split('.')[0] + ".dump"

def dasm(trace, m, f):
    for ln in trace:
        regex_res = re.search("(^\d \d 0{8}([\da-f]{8}) [\da-f]{8}.*)DASM.*", ln)
        if regex_res:
            if regex_res.group(2) in m:
                print(regex_res.group(1), m[regex_res.group(2)], file=f)
            else:
                print(regex_res.group(1).strip(), file=f)
        else:
            print(ln, end='', file=f)

def get_insn_map(asm):
    m = {}
    for ln in asm:
        regex_res = re.search("\s*([\da-f]{8}):\s*[\da-f]{4,8}\s*(.*)\n", ln)
        if regex_res != None:
            m[regex_res.group(1)] = regex_res.group(2)
    return m


if not os.path.exists("../../simulation/dromajo/"):
    os.mkdir("../../simulation/dromajo/")

if not os.path.exists("dasm/"):
    os.mkdir("dasm/")

dromajo_logs = os.listdir("../../simulation/dromajo/")
for filename in dromajo_logs:
    if not os.path.isfile("../../simulation/dromajo/" + filename):
        continue
    try:
        f_trace = open("../../simulation/dromajo/" + filename, "r")
        f_asm = open(find_asm(filename), "r")
        f = open("../../simulation/dromajo/dasm/" + filename + ".asm", "w")
        m = get_insn_map(f_asm)
        dasm(f_trace, m, f)
    except:
        print("Couldn't open " + filename)
