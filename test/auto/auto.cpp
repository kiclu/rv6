#include <algorithm>
#include <fstream>
#include <iostream>
#include <sstream>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <vector>
#include <deque>

const std::string MPF_REL_PATH = "../../simulation/";
const std::string TB_PATH = "../test/";
const std::string PROJECT = "rv6";

class Assertion {
public:
    Assertion(const std::string& var, const std::string& exp_val) :
        _var(var), _exp_val(exp_val) {}

    bool run(const std::vector<std::string>& command_output) {
        bool passed = 0;

        for(auto& i : command_output) {
            std::string::size_type sp;
            if((sp = i.find(_var)) != std::string::npos) {
                _val = i.substr(sp+_var.length()+1);
                _val.erase(_val.find_last_not_of("\t\n\r\f\v ") + 1);
                _val.erase(0, _val.find_first_not_of("\t\n\r\f\v "));
                passed = _val == _exp_val;
            }
        }

        return passed;
    }

    std::string get_var() const { return _var; }
    std::string get_exp_val() const { return _exp_val; }
    std::string get_val() const { return _val; }

private:
    std::string _var;
    std::string _exp_val;
    std::string _val = "ERR";
};

class Test {
public:
    Test(std::string tb_module, std::string flags) :
        _test_id(s_test_id++), _tb_module(tb_module),
        _flags(flags) , _command(_generate_command()) {}

    Test(std::string tb_module, std::string flags, const std::deque<Assertion>& assertions) :
        _test_id(s_test_id++), _tb_module(tb_module),
        _flags(flags), _command(_generate_command()),
        _assertions(assertions) {}

    void add_assertion(const Assertion& a) { _assertions.push_back(a); }

    // run all assertions in test
    bool run() {
        _generate_command();
        auto command_output = _run_command();

        _passed = true;
        for(auto& i : _assertions) {
            _passed &= i.run(command_output);
        }

        return _passed;
    }

    // output test results
    friend std::ostream& operator<<(std::ostream& os, const Test& t) {
        os << "Test " << t._test_id << ": ";
        os << (t._passed ? "\e[1;32mpassed\e[0m" : "\e[1;31mfailed\e[0m");
        os << " | Expected: ";
        for(auto& i : t._assertions) {
            os << i.get_var() << "=" << i.get_exp_val() << ", ";
        }
        os << "\b\b";
        os << " | Got: ";
        for(auto& i : t._assertions) {
            os << i.get_var() << "=" << i.get_val() << ", ";
        }
        os << "\b\b |";
        return os;
    }

private:
    std::string _generate_command() {
        std::string tb_module_source = TB_PATH + _tb_module + ".sv";

        std::string cd_sim_dir = "cd " + MPF_REL_PATH + " && ";
        std::string vsim_launch = "vsim -c " + _tb_module + " -do ";
        //std::string vsim_compile_syn = "'quit -sim; project open " + PROJECT + "; project compileall; ";
        std::string vsim_compile_syn = "'quit -sim; project open " + PROJECT + "; project compileoutofdate; ";
        std::string vsim_compile_tb = "vlog -work work " + tb_module_source + " " + _flags + "; ";
        std::string vsim_run = "vsim work." + _tb_module + "; run -all; quit -f;'";

        std::string vsim_do = vsim_compile_syn + vsim_compile_tb + vsim_run;
        return cd_sim_dir + vsim_launch + vsim_do;
    }

    std::vector<std::string> _run_command() {
        FILE* fp = nullptr;
        fp = popen(_command.c_str(), "r");
        if(fp == nullptr) {
            std::cout << "Failed to run command\n";
            exit(EXIT_FAILURE);
        }

        std::vector<std::string> command_output;
        char buf[2048];
        while(fgets(buf, sizeof(buf), fp)) {
            std::string buf_s = std::string(buf);
            command_output.push_back(buf_s);
        }

        pclose(fp);

        return command_output;
    }

    static std::size_t s_test_id;
    const std::size_t _test_id;

    const std::string _tb_module;
    const std::string _flags;

    const std::string _command;

    std::deque<Assertion> _assertions;

    bool _passed = true;
};

std::size_t Test::s_test_id = 0;

class Testbench {
public:
    Testbench(std::string name) : _name(name) { _load_from_file(); }

    void run(bool verbose = true) {
        if(verbose) std::cout << "Running testbench: " << _name << "\n";
        for(auto& i : _tests) {
            bool passed = i.run();
            _count_passed += passed;
            _count_failed += !passed;
            if(verbose) std::cout << i << "\n";
        }
        if(verbose) std::cout << "Testbench completed: \e[1;92m" << _count_passed << " passed\e[0m, \e[1;91m" << _count_failed << " failed\e[0m\n";
    }

    friend std::ostream& operator<<(std::ostream& os, const Testbench& tb) {
        os << "Running testbench: " << tb._name << "\n";
        for(auto& i : tb._tests) os << i << "\n";
        os << "Testbench completed: \e[0;92m" << tb._count_passed << " passed\e[0m, \e[0;91m" << tb._count_failed << "failed\e[0m\n";
        return os;
    }

private:
    void _load_from_file() {
        std::string filepath = _name + ".lst";
        std::ifstream fin(filepath);

        for(std::string line; std::getline(fin, line);) {
            std::string flags = "";
            std::deque<Assertion> assertions;
            std::istringstream ibuf(line);
            while(ibuf.get(), ibuf.peek() == '+') {
                std::string tmp_flag;
                ibuf >> tmp_flag;
                flags += tmp_flag + " ";
            }
            std::string var, exp_val;
            while(!ibuf.eof()) {
                ibuf >> var >> exp_val;
                assertions.push_back({var, exp_val});
            }
            _tests.push_back({_name, flags, assertions});
        }
    }

    const std::string _name;

    std::deque<Test> _tests;

    std::size_t _count_passed = 0;
    std::size_t _count_failed = 0;
};

class TestbenchRunner {
public:
    TestbenchRunner() {
        _load_tb_list();
        for(auto& i : _tb_list) {
            Testbench tb(i);
            tb.run();
        }
    }

private:
    void _load_tb_list(std::string filepath = "./auto.lst") {
        std::ifstream fin(filepath);
        for(std::string line; std::getline(fin, line);) {
            _tb_list.push_back(line);
        }
    }

    std::vector<std::string> _tb_list;
};

int main(int argc, char* argv[]) {
    TestbenchRunner();

    return 0;
}
