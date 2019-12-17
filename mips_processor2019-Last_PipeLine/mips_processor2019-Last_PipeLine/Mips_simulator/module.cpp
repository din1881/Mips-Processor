#include "module.h"

Module::Module()
{
    data_inputs = 0;
    control_inputs = 0;
    data_outputs = 0;
    control_outputs = 0;
}

void Module::set_data_inputs(int a)
{
    data_inputs = a;
}

void Module::set_control_inputs(int a)
{
    control_inputs = a;
}

void Module::set_data_outputs(int a)
{
    data_outputs = a;
}

void Module::set_control_outputs(int a)
{
    control_outputs = a;
}

void Module::set_type(string a)
{
    type = a;
}

int Module::get_data_inputs()
{
    return data_inputs;
}

int Module::get_control_inputs()
{
    return control_inputs;
}

int Module::get_data_outputs()
{
    return data_outputs;
}

int Module::get_control_outputs()
{
    return control_outputs;
}

string Module::get_type()
{
    return type;
}
