from Assembler import Assembler
import os
import filecmp as file_compare
# The path where the Modelsim will generate the files
Default_Path_For_mem = "F:/3rd-CSE/PythonScripts/Automated_Test"
# The path of the assembly code to be passed to the assembler
Path_For_Assembly = 'F:/3rd-CSE/mips_processor2019/Test_cases/assembly_source'
# The path for the correct test cases to be compared with the generated ones
Path_For_Test = 'F:/3rd-CSE/Test_cases/output_of_modelsim'
# Counter for the current iteration in the test files
test_number = 1
folder = os.fsencode(Path_For_Assembly)
filenames = []
test_result = []
# index = 0
for file in os.listdir(folder):
    # print(index)
    filename = os.fsdecode(file)
    x = Path_For_Assembly + '/' + filename
    newline = Assembler(x)
    # The file where the binary is generated
    newfile_name = "test.txt"
    newfile_name = open(newfile_name ,"w+")
    for line in newline:
        newfile_name.write(line)
    newfile_name.close()
    # index = index + 1
    os.chdir('F:/3rd-CSE/1stTerm/COIIProjects/Modeltech_pe_edu_10.4a/win32pe_edu')
    os.system('vsim -c -do "run -all" F:/3rd-CSE/1stTerm/COIIProjects/Modeltech_pe_edu_10.4a/examples/work.MIPS_cpu')
    os.chdir('F:/3rd-CSE/PythonScripts/Automated_Test')
    #this previous part runs the modelsim giving it the binary file
    local_mem_file = Default_Path_For_mem + '/'+"mem.txt"
    test_mem_file = Path_For_Test + '/' + 'mem' + str(test_number) + '.txt'
    print(local_mem_file)
    print(test_mem_file)
    local_reg_file = Default_Path_For_mem + '/' + 'reg.txt'
    test_reg_file = Path_For_Test + '/' + 'reg' + str(test_number) + '.txt'

    if file_compare.cmp(local_mem_file, test_mem_file) and file_compare.cmp(local_reg_file, test_reg_file):
        print("Test case (" + str(test_number) + "): Success")
        test_result.append("Test case (" + str(test_number) + "): Success\n")
    else:
        print("Test case (" + str(test_number) + "): Failed")
        test_result.append("Test case (" + str(test_number) + "): Failed\n")

    test_number = test_number + 1

result = open("Test_Result.txt" ,"w+")
for line in test_result:
    result.write(line)