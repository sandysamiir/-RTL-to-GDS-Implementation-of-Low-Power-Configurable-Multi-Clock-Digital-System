###################################################################
########################### Variables #############################
###################################################################

set SSLIB "/home/IC/Projects/System/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/IC/Projects/System/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/IC/Projects/System/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

###################################################################
############################ Guidance #############################
###################################################################

# Synopsys setup variable
set synopsys_auto_setup true

# Formality Setup File
set_svf "/home/IC/Projects/System/dft/Final_System.svf"

###################################################################
###################### Reference Container ########################
###################################################################

# Read Reference Design Verilog Files
read_verilog -container Ref "/home/IC/Projects/System/rtl/TOP/SYS_TOP_dft.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/TOP/mux2X1.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/UART/TOP/UART_TOP.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/UART/TX/UART_TX.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/UART/TX/Serializer.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/UART/TX/Parity_Calc.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/UART/TX/MUX.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/UART/RX/UART_RX.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/UART/RX/edge_bit_counter.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/UART/RX/data_sampling.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/UART/RX/deserializer.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/UART/RX/parity_check.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/UART/RX/strt_check.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/UART/RX/stop_check.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/DATA_SYNC/DATA_SYNC.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/PULSE_GEN/PULSE_GEN.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/RegFile/Register_File.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/ALU/ALU.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/Clock_Gating/CLK_GATE.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/RST_SYNC/RST_SYNC.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/ASYNC_FIFO/ASYC_FIFO.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/ASYNC_FIFO/FIFO_MEM_CNTRL.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/ASYNC_FIFO/FIFO_RD.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/ASYNC_FIFO/DF_SYNC.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/ASYNC_FIFO/FIFO_WR.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/Clock_Divider/CLKDiv.v"
read_verilog -container Ref "/home/IC/Projects/System/rtl/CLK_DIV_MUX/CLKDIV_MUX.v"
read_sverilog -container Ref "/home/IC/Projects/System/rtl/UART/TX/TX_FSM.sv"
read_sverilog -container Ref "/home/IC/Projects/System/rtl/UART/RX/RX_FSM.sv"
read_sverilog -container Ref "/home/IC/Projects/System/rtl/System_Control/SYS_CTRL.sv"


# Read Reference technology libraries
read_db -container Ref [list $SSLIB $TTLIB $FFLIB]

# set the top Reference Design 
set_reference_design System_TOP
set_top System_TOP

###################################################################
#################### Implementation Container #####################
###################################################################

# Read Implementation Design Files
read_verilog -netlist -container Imp "/home/IC/Projects/System/dft/Final_System.v"

# Read Implementation technology libraries
read_db -container Imp [list $TTLIB $SSLIB $FFLIB]

# set the top Implementation Design
set_implementation_design System_TOP
set_top System_TOP


###################################################################
#################### Implementation Container #####################
###################################################################

########################## Don't verify ###########################

# do not verify scan in & scan out ports as a compare point as it is existed only after synthesis and not existed in the RTL

#scan in
#set_dont_verify_points -type port Ref:/WORK/*/SO
#set_dont_verify_points -type port Imp:/WORK/*/SO



############################### contants #####################################

# all atpg enable (test_mode, scan_enable) are zero during formal compare

#test_mode
set_constant Ref:/WORK/*/test_mode 0
set_constant Imp:/WORK/*/test_mode 0

#scan_enable
set_constant Ref:/WORK/*/SE 0
set_constant Imp:/WORK/*/SE 0


###################### Matching Compare points ####################

match

######################### Run Verification ########################

set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

########################### Reporting ############################# 
report_passing_points > "passing_points.rpt"
report_failing_points > "failing_points.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"

########################### Start GUI ############################# 
start_gui

