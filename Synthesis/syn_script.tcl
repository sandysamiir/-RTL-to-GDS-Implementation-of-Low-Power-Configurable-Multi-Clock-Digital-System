########################### Define Top Module ############################
                                                   
set top_module System_TOP

##################### Define Working Library Directory ######################
                                                   
define_design_lib work -path ./work

########################### Formality Setup file ############################

set_svf Final_System.svf

################## Design Compiler Library Files #setup ######################

puts "###########################################"
puts "#      #setting Design Libraries           #"
puts "###########################################"

#Add the path of the libraries to the search_path variable
lappend search_path /home/IC/Projects/System/std_cells
lappend search_path /home/IC/Projects/System/rtl

set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

## Standard Cell libraries 
set target_library [list $SSLIB $TTLIB $FFLIB]

## Standard Cell & Hard Macros libraries 
set link_library [list * $SSLIB $TTLIB $FFLIB]  

######################## Reading RTL Files #################################

puts "###########################################"
puts "#             Reading RTL Files           #"
puts "###########################################"

read_file -format verilog  TOP/System_TOP.v
read_file -format verilog  UART/TOP/UART_TOP.v
read_file -format verilog  UART/TX/UART_TX.v
read_file -format sverilog UART/TX/TX_FSM.sv
read_file -format verilog  UART/TX/Serializer.v
read_file -format verilog  UART/TX/Parity_Calc.v
read_file -format verilog  UART/TX/MUX.v
read_file -format verilog  UART/RX/UART_RX.v
read_file -format sverilog UART/RX/RX_FSM.sv
read_file -format verilog  UART/RX/edge_bit_counter.v
read_file -format verilog  UART/RX/data_sampling.v
read_file -format verilog  UART/RX/deserializer.v
read_file -format verilog  UART/RX/parity_check.v
read_file -format verilog  UART/RX/strt_check.v
read_file -format verilog  UART/RX/stop_check.v
read_file -format verilog  DATA_SYNC/DATA_SYNC.v
read_file -format verilog  PULSE_GEN/PULSE_GEN.v
read_file -format sverilog System_Control/SYS_CTRL.sv
read_file -format verilog  RegFile/Register_File.v
read_file -format verilog  ALU/ALU.v
read_file -format verilog  Clock_Gating/CLK_GATE.v
read_file -format verilog  RST_SYNC/RST_SYNC.v
read_file -format verilog  ASYNC_FIFO/ASYC_FIFO.v
read_file -format verilog  ASYNC_FIFO/FIFO_MEM_CNTRL.v
read_file -format verilog  ASYNC_FIFO/FIFO_RD.v
read_file -format verilog  ASYNC_FIFO/DF_SYNC.v
read_file -format verilog  ASYNC_FIFO/FIFO_WR.v
read_file -format verilog  Clock_Divider/CLKDiv.v
read_file -format verilog  CLK_DIV_MUX/CLKDIV_MUX.v


###################### Defining toplevel ###################################

current_design $top_module

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## Liniking All The Design Parts ########"
puts "###############################################"

link 

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## checking design consistency ##########"
puts "###############################################"

check_design

############################### Path groups ################################
puts "###############################################"
puts "################ Path groups ##################"
puts "###############################################"

group_path -name INREG -from [all_inputs]
group_path -name REGOUT -to [all_outputs]
group_path -name INOUT -from [all_inputs] -to [all_outputs]

#################### Define Design Constraints #########################
puts "###############################################"
puts "############ Design Constraints #### ##########"
puts "###############################################"

source ./cons.tcl


###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

compile -map_effort high 

##################### Close Formality Setup file ###########################

set_svf -off

#############################################################################
# Write out Design after initial compile
#############################################################################

write_file -format verilog -hierarchy -output Final_System.v
write_file -format ddc -hierarchy -output Final_System.ddc
write_sdc  -nosplit Final_System.sdc
write_sdf           Final_System.sdf

################# reporting #######################

report_area -hierarchy > area.rpt
report_power -hierarchy > power.rpt
report_timing -max_paths 100 -delay_type min > hold.rpt
report_timing -max_paths 100 -delay_type max > setup.rpt
report_clock -attributes > clocks.rpt
report_constraint -all_violators > constraints.rpt

################# starting graphical user interface #######################

#gui_start

exit
