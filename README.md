# -RTL-to-GDS-Implementation-of-Low-Power-Configurable-Multi-Clock-Digital-System
## **Project Overview**  
This project focuses on the **RTL to GDS implementation** of a **low-power configurable multi-clock digital system**. It includes multiple modules responsible for handling UART commands, register file operations, and ALU functionalities.  

## **System Block Diagram**  
The following diagram illustrates the architecture of the system:  
 
![Block_Diagram](https://github.com/user-attachments/assets/7eb7c461-91cc-41ff-8380-62bbff8f54f7)

## **Repository Contents**  
This repository contains:  
- **Source files** (`sourcefile.txt`)  
- **Simulation script** (`run.txt`)  
- **Testbench files**  
- **Documentation & Reports**  

## **Simulation Setup**  
To run the simulation:  
1. **Open the simulation tool** (I used ModelSim).  
2. **Navigate to the project directory** where `run.txt` is located.  
3. In the **simulation tool's terminal**, type:
   ```tcl
   do run.txt

## **Testbench Overview**  
The testbench validates the **System_TOP** module by generating clock signals, applying reset conditions, and sending UART frames with various commands and data.  

### **Key Components:**  
- **Clock Generation:** `UART_CLK` (3.6864 MHz) & `REF_CLK` (50 MHz)  

### **Test Cases:**  
1. **Write to Register File**  
2. **Read from Register File**  
3. **ALU Operations:** Addition, Subtraction, Multiplication, Division, XNOR, Compare  
4. **Error Handling:** Parity and Framing Errors  
