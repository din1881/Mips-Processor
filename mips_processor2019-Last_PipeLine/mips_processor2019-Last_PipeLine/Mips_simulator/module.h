#ifndef MODULE_H
#define MODULE_H
#include <string>
using namespace std;
class Module
{
public:
    Module();
    virtual void drawshape()=0;
    void set_data_inputs(int);
    void set_control_inputs(int);
    void set_data_outputs(int);
    void set_control_outputs(int);
    void set_type(string);
    int get_data_inputs();
    int get_control_inputs();
    int get_data_outputs();
    int get_control_outputs();
    string get_type();
private:
    int data_inputs,control_inputs,data_outputs,control_outputs;
    string type;
};

#endif // MODULE_H
