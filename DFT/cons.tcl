# Prevent assign statements in the generated netlist (must be applied before compile command)
set_fix_multiple_port_nets -all -buffer_constants -feedthroughs

####################################################################################
           #########################################################
                  #### Section 1 : Clock Definition ####
           #########################################################
#################################################################################### 
# 1. Master Clock Definitions 
# 2. Generated Clock Definitions
# 3. Clock Latencies
# 4. Clock Uncertainties
# 4. Clock Transitions
####################################################################################

set REF_CLK_PER 20
set UART_CLK_PER 271.2968
set CLK_SETUP_SKEW 0.2
set CLK_HOLD_SKEW 0.1
set CLK_LAT 0

create_clock -name "REF_CLK" -period $REF_CLK_PER -waveform "0 [expr $REF_CLK_PER/2]" [get_ports REF_CLK]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks REF_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks REF_CLK]
set_clock_latency $CLK_LAT [get_clocks REF_CLK]

create_clock -name "UART_CLK" -period $UART_CLK_PER -waveform "0 [expr $UART_CLK_PER/2]" [get_ports UART_CLK]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks UART_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks UART_CLK]
set_clock_latency $CLK_LAT [get_clocks UART_CLK]

create_generated_clock -master_clock REF_CLK -source [get_ports REF_CLK] \
                       -name "ALU_CLK" [get_port DUT_CLK_GATE/GATED_CLK] \
                       -divide_by 1
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks ALU_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks ALU_CLK]
set_clock_latency $CLK_LAT [get_clocks ALU_CLK]


create_generated_clock -master_clock UART_CLK -source [get_ports UART_CLK] \
                       -name "TX_CLK" [get_port DUT_CLKDIV_TX/O_div_clk] \
                       -divide_by 32
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks TX_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks TX_CLK]
set_clock_latency $CLK_LAT [get_clocks TX_CLK]

create_generated_clock -master_clock UART_CLK -source [get_ports UART_CLK] \
                       -name "RX_CLK" [get_port DUT_CLKDIV_RX/O_div_clk] \
                       -divide_by 1
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks RX_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks RX_CLK]
set_clock_latency $CLK_LAT [get_clocks RX_CLK]
					   
set_dont_touch_network [get_clocks {REF_CLK UART_CLK ALU_CLK TX_CLK RX_CLK}]


create_clock -name "SCAN_CLK" -period 1000 -waveform "0 500" [get_ports scan_clk]
set_clock_latency $CLK_LAT [get_clocks "SCAN_CLK"]


####################################################################################
           #########################################################
                  #### Section 2 : Clocks Relationships ####
           #########################################################
####################################################################################

set_clock_groups -asynchronous -group [get_clocks "REF_CLK ALU_CLK"] -group [get_clocks "UART_CLK TX_CLK RX_CLK"] -group [get_clocks "SCAN_CLK"]

####################################################################################
           #########################################################
             #### Section 3 : set input/output delay on ports ####
           #########################################################
####################################################################################


set delay  [expr 0.2*$UART_CLK_PER]

#Constrain Input Paths
set_input_delay $delay -clock RX_CLK [get_port RX_IN]
set_input_delay 200 -clock SCAN_CLK [get_port scan_clk]
set_input_delay 200 -clock SCAN_CLK [get_port scan_rst]
set_input_delay 200 -clock SCAN_CLK [get_port test_mode]
set_input_delay 200 -clock SCAN_CLK [get_port SE]
set_input_delay 200 -clock SCAN_CLK [get_port SI]


#Constrain Output Paths
set_output_delay $delay -clock TX_CLK [get_port TX_OUT]
set_output_delay $delay -clock RX_CLK [get_port parity_error]
set_output_delay $delay -clock RX_CLK [get_port framing_error]
set_output_delay 200 -clock SCAN_CLK [get_port SO]

####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################
####################################################################################

set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port RX_IN]

####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################

set_load 0.1 [get_port TX_OUT]
set_load 0.1 [get_port parity_error]
set_load 0.1 [get_port framing_error]

####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################

# Define the Worst Library for Max(#setup) analysis
# Define the Best Library for Min(hold) analysis

set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"

####################################################################################
           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c

####################################################################################
           #########################################################
                  #### Section 8 : Case Analysis ####
           #########################################################
####################################################################################
set_case_analysis 1 [get_ports test_mode]

