/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Fri Aug 16 05:25:23 2024
/////////////////////////////////////////////////////////////


module mux2X1_1 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X6M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module mux2X1_4 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X6M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module mux2X1_3 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X6M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module mux2X1_2 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X6M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module mux2X1_0 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module mux2X1_6 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module mux2X1_5 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module TX_FSM_test_1 ( CLK, RST, Data_Valid, PAR_EN, ser_done, busy, mux_sel, 
        ser_en, par_en, test_si, test_so, test_se );
  output [1:0] mux_sel;
  input CLK, RST, Data_Valid, PAR_EN, ser_done, test_si, test_se;
  output busy, ser_en, par_en, test_so;
  wire   Current_State_1_, Current_State_0_, n10, n11, n13, n14, n16, n17, n7,
         n8, n9, n15, n18, n19, n22;
  wire   [2:0] Next_State;

  SDFFRQX2M Current_State_reg_1_ ( .D(Next_State[1]), .SI(n9), .SE(test_se), 
        .CK(CLK), .RN(n7), .Q(Current_State_1_) );
  SDFFRQX4M Current_State_reg_2_ ( .D(Next_State[2]), .SI(n18), .SE(test_se), 
        .CK(CLK), .RN(n7), .Q(test_so) );
  AOI31X2M U6 ( .A0(mux_sel[1]), .A1(n8), .A2(n9), .B0(par_en), .Y(n10) );
  NAND2X2M U10 ( .A(Current_State_1_), .B(n15), .Y(n14) );
  BUFX2M U11 ( .A(RST), .Y(n7) );
  INVX2M U12 ( .A(n10), .Y(ser_en) );
  INVX2M U13 ( .A(n14), .Y(mux_sel[1]) );
  OAI211X2M U14 ( .A0(n18), .A1(n9), .B0(n11), .C0(n15), .Y(mux_sel[0]) );
  NAND2X2M U15 ( .A(n9), .B(n18), .Y(n11) );
  NAND2X2M U16 ( .A(n17), .B(n10), .Y(Next_State[1]) );
  INVX2M U17 ( .A(test_so), .Y(n15) );
  NOR3X4M U18 ( .A(test_so), .B(Current_State_1_), .C(n9), .Y(par_en) );
  INVX4M U19 ( .A(Current_State_0_), .Y(n9) );
  INVX2M U20 ( .A(ser_done), .Y(n8) );
  OAI32X2M U21 ( .A0(n19), .A1(test_so), .A2(n11), .B0(n8), .B1(n17), .Y(
        Next_State[0]) );
  INVX2M U22 ( .A(Data_Valid), .Y(n19) );
  NAND3X2M U23 ( .A(mux_sel[1]), .B(n9), .C(PAR_EN), .Y(n17) );
  INVX2M U24 ( .A(Current_State_1_), .Y(n18) );
  NOR2X2M U25 ( .A(n16), .B(n14), .Y(Next_State[2]) );
  AOI2B1X1M U26 ( .A1N(PAR_EN), .A0(n22), .B0(Current_State_0_), .Y(n16) );
  OAI211X2M U27 ( .A0(test_so), .A1(n9), .B0(n13), .C0(n14), .Y(busy) );
  NAND2BX2M U28 ( .AN(n11), .B(test_so), .Y(n13) );
  INVXLM U29 ( .A(n8), .Y(n22) );
  SDFFRQX2M Current_State_reg_0_ ( .D(Next_State[0]), .SI(test_si), .SE(
        test_se), .CK(CLK), .RN(n7), .Q(Current_State_0_) );
endmodule


module Serializer_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHX1M U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHX1M U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1M U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1M U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1M U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1M U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  CLKXOR2X2M U1 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
  CLKINVX1M U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module Serializer_test_1 ( CLK, RST, Data_Valid, ser_en, P_DATA, ser_done, 
        ser_data, test_si, test_se );
  input [7:0] P_DATA;
  input CLK, RST, Data_Valid, ser_en, test_si, test_se;
  output ser_done, ser_data;
  wire   N8, N9, N10, N11, N12, N13, N14, N15, N25, N35, n2, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n20, n22, n24, n26, n28,
         n30, n32, n34, n43, n44, n45, n46, n47, n48, n49, n50, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n78, n79, n80, n81, n82, n83, n84, n85;
  wire   [7:1] IN_Data;
  wire   [7:0] Counter;

  SDFFRQX2M Counter_reg_2_ ( .D(n30), .SI(Counter[1]), .SE(test_se), .CK(CLK), 
        .RN(n71), .Q(Counter[2]) );
  SDFFRQX2M Counter_reg_3_ ( .D(n28), .SI(Counter[2]), .SE(test_se), .CK(CLK), 
        .RN(n71), .Q(Counter[3]) );
  SDFFRQX2M Counter_reg_0_ ( .D(n34), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(n71), .Q(Counter[0]) );
  SDFFRQX2M Counter_reg_1_ ( .D(n32), .SI(n74), .SE(test_se), .CK(CLK), .RN(
        n71), .Q(Counter[1]) );
  SDFFRQX2M Counter_reg_5_ ( .D(n24), .SI(Counter[4]), .SE(test_se), .CK(CLK), 
        .RN(n71), .Q(Counter[5]) );
  SDFFRQX2M Counter_reg_6_ ( .D(n22), .SI(Counter[5]), .SE(test_se), .CK(CLK), 
        .RN(n71), .Q(Counter[6]) );
  SDFFRQX2M Counter_reg_7_ ( .D(n20), .SI(Counter[6]), .SE(test_se), .CK(CLK), 
        .RN(n71), .Q(Counter[7]) );
  SDFFRQX2M Counter_reg_4_ ( .D(n26), .SI(Counter[3]), .SE(test_se), .CK(CLK), 
        .RN(n71), .Q(Counter[4]) );
  AO22X1M U3 ( .A0(n75), .A1(Counter[5]), .B0(N13), .B1(n2), .Y(n24) );
  NOR4X2M U4 ( .A(Counter[7]), .B(Counter[6]), .C(Counter[5]), .D(Counter[4]), 
        .Y(n15) );
  NAND4X2M U5 ( .A(Counter[2]), .B(Counter[1]), .C(n14), .D(n15), .Y(n4) );
  INVX4M U24 ( .A(n69), .Y(n75) );
  INVX6M U25 ( .A(n73), .Y(n71) );
  INVX4M U26 ( .A(n73), .Y(n72) );
  NOR2X8M U27 ( .A(n67), .B(n69), .Y(n6) );
  INVX4M U28 ( .A(n68), .Y(n70) );
  INVX4M U29 ( .A(n68), .Y(n69) );
  INVX2M U30 ( .A(RST), .Y(n73) );
  CLKBUFX6M U31 ( .A(n7), .Y(n67) );
  NOR2X2M U32 ( .A(Data_Valid), .B(n70), .Y(n7) );
  INVX2M U33 ( .A(ser_en), .Y(n68) );
  CLKAND2X4M U34 ( .A(n4), .B(n69), .Y(n2) );
  NOR2X2M U35 ( .A(n75), .B(n4), .Y(N35) );
  OAI2BB1X2M U54 ( .A0N(n69), .A1N(n80), .B0(n13), .Y(n50) );
  AOI22X1M U55 ( .A0(P_DATA[1]), .A1(n6), .B0(IN_Data[1]), .B1(n67), .Y(n13)
         );
  OAI2BB1X2M U56 ( .A0N(n70), .A1N(n81), .B0(n12), .Y(n49) );
  AOI22X1M U57 ( .A0(P_DATA[2]), .A1(n6), .B0(IN_Data[2]), .B1(n67), .Y(n12)
         );
  OAI2BB1X2M U58 ( .A0N(n69), .A1N(n82), .B0(n11), .Y(n48) );
  AOI22X1M U59 ( .A0(P_DATA[3]), .A1(n6), .B0(IN_Data[3]), .B1(n67), .Y(n11)
         );
  OAI2BB1X2M U60 ( .A0N(n70), .A1N(n83), .B0(n10), .Y(n47) );
  AOI22X1M U61 ( .A0(P_DATA[4]), .A1(n6), .B0(IN_Data[4]), .B1(n67), .Y(n10)
         );
  OAI2BB1X2M U62 ( .A0N(n69), .A1N(n84), .B0(n9), .Y(n46) );
  AOI22X1M U63 ( .A0(P_DATA[5]), .A1(n6), .B0(IN_Data[5]), .B1(n67), .Y(n9) );
  OAI2BB1X2M U64 ( .A0N(n70), .A1N(n78), .B0(n8), .Y(n45) );
  AOI22X1M U65 ( .A0(P_DATA[6]), .A1(n6), .B0(IN_Data[6]), .B1(n67), .Y(n8) );
  OAI2BB1X2M U66 ( .A0N(n69), .A1N(n79), .B0(n5), .Y(n43) );
  AOI22X1M U67 ( .A0(P_DATA[0]), .A1(n6), .B0(n16), .B1(n67), .Y(n5) );
  OAI2BB2X1M U68 ( .B0(n70), .B1(n74), .A0N(N8), .A1N(n2), .Y(n34) );
  AO22X1M U69 ( .A0(n67), .A1(IN_Data[7]), .B0(P_DATA[7]), .B1(n6), .Y(n44) );
  AO22X1M U70 ( .A0(n75), .A1(Counter[7]), .B0(N15), .B1(n2), .Y(n20) );
  AO22X1M U71 ( .A0(n75), .A1(Counter[6]), .B0(N14), .B1(n2), .Y(n22) );
  AO22X1M U72 ( .A0(n75), .A1(Counter[4]), .B0(N12), .B1(n2), .Y(n26) );
  AO22X1M U73 ( .A0(n75), .A1(Counter[3]), .B0(N11), .B1(n2), .Y(n28) );
  AO22X1M U74 ( .A0(n75), .A1(Counter[2]), .B0(N10), .B1(n2), .Y(n30) );
  AO22X1M U75 ( .A0(n75), .A1(Counter[1]), .B0(N9), .B1(n2), .Y(n32) );
  NOR2X2M U76 ( .A(Counter[3]), .B(n74), .Y(n14) );
  INVX2M U77 ( .A(Counter[0]), .Y(n74) );
  AND2X2M U78 ( .A(n85), .B(n70), .Y(N25) );
  DLY1X1M U79 ( .A(IN_Data[7]), .Y(n78) );
  DLY1X1M U80 ( .A(IN_Data[1]), .Y(n79) );
  DLY1X1M U81 ( .A(IN_Data[2]), .Y(n80) );
  DLY1X1M U82 ( .A(IN_Data[3]), .Y(n81) );
  DLY1X1M U83 ( .A(IN_Data[4]), .Y(n82) );
  DLY1X1M U84 ( .A(IN_Data[5]), .Y(n83) );
  DLY1X1M U85 ( .A(IN_Data[6]), .Y(n84) );
  DLY1X1M U86 ( .A(n16), .Y(n85) );
  Serializer_DW01_inc_0 add_35 ( .A(Counter), .SUM({N15, N14, N13, N12, N11, 
        N10, N9, N8}) );
  SDFFRQX2M ser_done_reg ( .D(N35), .SI(ser_data), .SE(test_se), .CK(CLK), 
        .RN(n71), .Q(ser_done) );
  SDFFRQX2M ser_data_reg ( .D(N25), .SI(n78), .SE(test_se), .CK(CLK), .RN(n71), 
        .Q(ser_data) );
  SDFFRQX2M IN_Data_reg_7_ ( .D(n44), .SI(n84), .SE(test_se), .CK(CLK), .RN(
        n71), .Q(IN_Data[7]) );
  SDFFRQX2M IN_Data_reg_6_ ( .D(n45), .SI(n83), .SE(test_se), .CK(CLK), .RN(
        n72), .Q(IN_Data[6]) );
  SDFFRQX2M IN_Data_reg_5_ ( .D(n46), .SI(n82), .SE(test_se), .CK(CLK), .RN(
        n72), .Q(IN_Data[5]) );
  SDFFRQX2M IN_Data_reg_4_ ( .D(n47), .SI(n81), .SE(test_se), .CK(CLK), .RN(
        n72), .Q(IN_Data[4]) );
  SDFFRQX2M IN_Data_reg_3_ ( .D(n48), .SI(n80), .SE(test_se), .CK(CLK), .RN(
        n72), .Q(IN_Data[3]) );
  SDFFRQX2M IN_Data_reg_2_ ( .D(n49), .SI(n79), .SE(test_se), .CK(CLK), .RN(
        n72), .Q(IN_Data[2]) );
  SDFFRQX2M IN_Data_reg_1_ ( .D(n50), .SI(n85), .SE(test_se), .CK(CLK), .RN(
        n71), .Q(IN_Data[1]) );
  SDFFRQX2M IN_Data_reg_0_ ( .D(n43), .SI(Counter[7]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(n16) );
endmodule


module Parity_Calc_test_1 ( CLK, RST, PAR_TYP, Data_Valid, par_en, P_DATA, 
        par_bit, test_si, test_se );
  input [7:0] P_DATA;
  input CLK, RST, PAR_TYP, Data_Valid, par_en, test_si, test_se;
  output par_bit;
  wire   n51, n1, n3, n4, n5, n6, n8, n10, n12, n14, n16, n18, n20, n22, n24,
         n33, n34, n35, n36, n37, n38, n41, n42, n43, n44, n45, n46, n48, n49,
         n50;
  wire   [7:0] IN_Data;

  INVX4M U11 ( .A(n33), .Y(n34) );
  INVX4M U12 ( .A(n33), .Y(n35) );
  INVX6M U13 ( .A(n37), .Y(n36) );
  INVX2M U14 ( .A(RST), .Y(n37) );
  INVX2M U15 ( .A(Data_Valid), .Y(n33) );
  OAI2BB2X1M U16 ( .B0(n1), .B1(n38), .A0N(n48), .A1N(n38), .Y(n8) );
  INVX2M U26 ( .A(par_en), .Y(n38) );
  XOR3XLM U27 ( .A(n3), .B(PAR_TYP), .C(n4), .Y(n1) );
  XOR3XLM U28 ( .A(IN_Data[1]), .B(IN_Data[0]), .C(n5), .Y(n4) );
  XOR3XLM U29 ( .A(IN_Data[5]), .B(IN_Data[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U30 ( .A(IN_Data[7]), .B(IN_Data[6]), .Y(n6) );
  AO2B2X2M U31 ( .B0(P_DATA[0]), .B1(n34), .A0(n44), .A1N(n34), .Y(n10) );
  AO2B2X2M U32 ( .B0(P_DATA[1]), .B1(n35), .A0(n42), .A1N(n35), .Y(n12) );
  AO2B2X2M U33 ( .B0(P_DATA[2]), .B1(n34), .A0(n46), .A1N(n34), .Y(n14) );
  AO2B2X2M U34 ( .B0(P_DATA[3]), .B1(n35), .A0(n49), .A1N(n35), .Y(n16) );
  AO2B2X2M U35 ( .B0(P_DATA[4]), .B1(n34), .A0(n45), .A1N(n34), .Y(n18) );
  AO2B2X2M U36 ( .B0(P_DATA[5]), .B1(n35), .A0(n43), .A1N(n35), .Y(n20) );
  AO2B2X2M U37 ( .B0(P_DATA[6]), .B1(n34), .A0(n41), .A1N(n34), .Y(n22) );
  AO2B2X2M U38 ( .B0(P_DATA[7]), .B1(n35), .A0(n50), .A1N(n35), .Y(n24) );
  XNOR2X2M U39 ( .A(IN_Data[2]), .B(IN_Data[3]), .Y(n5) );
  DLY1X1M U40 ( .A(IN_Data[6]), .Y(n41) );
  DLY1X1M U41 ( .A(IN_Data[1]), .Y(n42) );
  DLY1X1M U42 ( .A(IN_Data[5]), .Y(n43) );
  DLY1X1M U43 ( .A(IN_Data[0]), .Y(n44) );
  DLY1X1M U44 ( .A(IN_Data[4]), .Y(n45) );
  DLY1X1M U45 ( .A(IN_Data[2]), .Y(n46) );
  DLY1X1M U46 ( .A(n51), .Y(par_bit) );
  DLY1X1M U47 ( .A(n51), .Y(n48) );
  DLY1X1M U48 ( .A(IN_Data[3]), .Y(n49) );
  DLY1X1M U49 ( .A(IN_Data[7]), .Y(n50) );
  SDFFRQX2M par_bit_reg ( .D(n8), .SI(n50), .SE(test_se), .CK(CLK), .RN(n36), 
        .Q(n51) );
  SDFFRQX2M IN_Data_reg_7_ ( .D(n24), .SI(n41), .SE(test_se), .CK(CLK), .RN(
        n36), .Q(IN_Data[7]) );
  SDFFRQX2M IN_Data_reg_6_ ( .D(n22), .SI(n43), .SE(test_se), .CK(CLK), .RN(
        n36), .Q(IN_Data[6]) );
  SDFFRQX2M IN_Data_reg_5_ ( .D(n20), .SI(n45), .SE(test_se), .CK(CLK), .RN(
        n36), .Q(IN_Data[5]) );
  SDFFRQX2M IN_Data_reg_4_ ( .D(n18), .SI(n49), .SE(test_se), .CK(CLK), .RN(
        n36), .Q(IN_Data[4]) );
  SDFFRQX2M IN_Data_reg_3_ ( .D(n16), .SI(n46), .SE(test_se), .CK(CLK), .RN(
        n36), .Q(IN_Data[3]) );
  SDFFRQX2M IN_Data_reg_2_ ( .D(n14), .SI(n42), .SE(test_se), .CK(CLK), .RN(
        n36), .Q(IN_Data[2]) );
  SDFFRQX2M IN_Data_reg_1_ ( .D(n12), .SI(n44), .SE(test_se), .CK(CLK), .RN(
        n36), .Q(IN_Data[1]) );
  SDFFRQX2M IN_Data_reg_0_ ( .D(n10), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(n36), .Q(IN_Data[0]) );
endmodule


module MUX_test_1 ( CLK, RST, mux_sel, ser_data, par_bit, TX_OUT, test_si, 
        test_se );
  input [1:0] mux_sel;
  input CLK, RST, ser_data, par_bit, test_si, test_se;
  output TX_OUT;
  wire   N13, n3, n4, n5;

  SDFFSQX2M TX_OUT_reg ( .D(N13), .SI(test_si), .SE(test_se), .CK(CLK), .SN(
        RST), .Q(TX_OUT) );
  OAI21X2M U5 ( .A0(n3), .A1(n5), .B0(n4), .Y(N13) );
  NAND3X2M U6 ( .A(mux_sel[1]), .B(n5), .C(ser_data), .Y(n4) );
  INVX2M U7 ( .A(mux_sel[0]), .Y(n5) );
  NOR2BX2M U8 ( .AN(mux_sel[1]), .B(par_bit), .Y(n3) );
endmodule


module UART_TX_test_1 ( CLK, RST, PAR_EN, PAR_TYP, Data_Valid, P_DATA, TX_OUT, 
        busy, test_si, test_se );
  input [7:0] P_DATA;
  input CLK, RST, PAR_EN, PAR_TYP, Data_Valid, test_si, test_se;
  output TX_OUT, busy;
  wire   ser_done, ser_en, par_en, ser_data, par_bit, n1, n2, n3, n4, n5;
  wire   [1:0] mux_sel;

  INVXLM U1 ( .A(n4), .Y(n1) );
  INVXLM U2 ( .A(n4), .Y(n2) );
  INVX2M U3 ( .A(n4), .Y(n3) );
  INVX2M U4 ( .A(RST), .Y(n4) );
  TX_FSM_test_1 DUT_fsm ( .CLK(CLK), .RST(n1), .Data_Valid(Data_Valid), 
        .PAR_EN(PAR_EN), .ser_done(ser_done), .busy(busy), .mux_sel(mux_sel), 
        .ser_en(ser_en), .par_en(par_en), .test_si(test_si), .test_so(n5), 
        .test_se(test_se) );
  Serializer_test_1 DUT_ser ( .CLK(CLK), .RST(n3), .Data_Valid(Data_Valid), 
        .ser_en(ser_en), .P_DATA(P_DATA), .ser_done(ser_done), .ser_data(
        ser_data), .test_si(par_bit), .test_se(test_se) );
  Parity_Calc_test_1 DUT_par ( .CLK(CLK), .RST(n2), .PAR_TYP(PAR_TYP), 
        .Data_Valid(Data_Valid), .par_en(par_en), .P_DATA(P_DATA), .par_bit(
        par_bit), .test_si(n5), .test_se(test_se) );
  MUX_test_1 DUT_mux ( .CLK(CLK), .RST(n3), .mux_sel(mux_sel), .ser_data(
        ser_data), .par_bit(par_bit), .TX_OUT(TX_OUT), .test_si(ser_done), 
        .test_se(test_se) );
endmodule


module RX_FSM_test_1 ( CLK, RST, RX_IN, PAR_EN, edge_cnt, bit_cnt, parr_err, 
        strt_glitch, stp_err, prescale, data_valid, deser_en, data_sample_en, 
        enable, par_chk_en, strt_chk_en, stp_chk_en, test_so, test_se );
  input [5:0] edge_cnt;
  input [7:0] bit_cnt;
  input [5:0] prescale;
  input CLK, RST, RX_IN, PAR_EN, parr_err, strt_glitch, stp_err, test_se;
  output data_valid, deser_en, data_sample_en, enable, par_chk_en, strt_chk_en,
         stp_chk_en, test_so;
  wire   Current_State_1_, Current_State_0_, N102, n20, n21, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n5, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n22,
         n23, n43, n44, n45, n46, n47, n48;
  wire   [2:0] Next_State;

  SDFFRQX4M Current_State_reg_1_ ( .D(Next_State[1]), .SI(Current_State_0_), 
        .SE(test_se), .CK(CLK), .RN(n5), .Q(Current_State_1_) );
  SDFFRQX4M Current_State_reg_2_ ( .D(Next_State[2]), .SI(n47), .SE(test_se), 
        .CK(CLK), .RN(n5), .Q(test_so) );
  SDFFRQX4M Current_State_reg_0_ ( .D(Next_State[0]), .SI(edge_cnt[5]), .SE(
        test_se), .CK(CLK), .RN(n5), .Q(Current_State_0_) );
  BUFX4M U4 ( .A(data_sample_en), .Y(enable) );
  NOR2X2M U7 ( .A(bit_cnt[2]), .B(bit_cnt[1]), .Y(n41) );
  NOR2BX2M U8 ( .AN(edge_cnt[0]), .B(prescale[0]), .Y(n9) );
  NOR2BX2M U9 ( .AN(prescale[0]), .B(edge_cnt[0]), .Y(n10) );
  NOR4X1M U10 ( .A(n21), .B(Current_State_1_), .C(stp_err), .D(parr_err), .Y(
        data_valid) );
  AND4X1M U11 ( .A(n23), .B(bit_cnt[3]), .C(bit_cnt[1]), .D(n42), .Y(n39) );
  NOR4X2M U12 ( .A(bit_cnt[7]), .B(bit_cnt[6]), .C(bit_cnt[5]), .D(bit_cnt[4]), 
        .Y(n42) );
  NOR4X4M U13 ( .A(n17), .B(n16), .C(n15), .D(n14), .Y(N102) );
  OAI33X4M U14 ( .A0(n44), .A1(PAR_EN), .A2(n27), .B0(n37), .B1(RX_IN), .B2(
        Current_State_1_), .Y(n36) );
  NOR3X6M U15 ( .A(Current_State_1_), .B(test_so), .C(n43), .Y(strt_chk_en) );
  NAND2XLM U16 ( .A(test_so), .B(Current_State_0_), .Y(n21) );
  INVX2M U20 ( .A(Current_State_0_), .Y(n43) );
  NAND2X2M U21 ( .A(Current_State_0_), .B(n45), .Y(n20) );
  BUFX2M U22 ( .A(RST), .Y(n5) );
  INVX2M U23 ( .A(n27), .Y(n22) );
  OAI211X2M U24 ( .A0(n27), .A1(n20), .B0(n28), .C0(n44), .Y(Next_State[2]) );
  NAND3X2M U25 ( .A(n29), .B(n48), .C(deser_en), .Y(n28) );
  OAI21X2M U26 ( .A0(n22), .A1(n20), .B0(n30), .Y(Next_State[1]) );
  AOI31X2M U27 ( .A0(n19), .A1(n18), .A2(strt_chk_en), .B0(n31), .Y(n30) );
  INVX2M U28 ( .A(n33), .Y(n19) );
  AOI21X2M U29 ( .A0(n29), .A1(n48), .B0(n32), .Y(n31) );
  NAND2X2M U30 ( .A(n43), .B(n45), .Y(n32) );
  INVX2M U31 ( .A(stp_chk_en), .Y(n44) );
  INVX2M U32 ( .A(n26), .Y(n45) );
  INVX2M U33 ( .A(n20), .Y(par_chk_en) );
  NAND3BX2M U34 ( .AN(bit_cnt[0]), .B(N102), .C(n39), .Y(n27) );
  CLKXOR2X2M U35 ( .A(test_so), .B(Current_State_0_), .Y(n37) );
  OAI221X1M U36 ( .A0(n34), .A1(n48), .B0(n22), .B1(n20), .C0(n35), .Y(
        Next_State[0]) );
  AOI32X1M U37 ( .A0(stp_chk_en), .A1(n39), .A2(n40), .B0(deser_en), .B1(n29), 
        .Y(n34) );
  AOI31X2M U38 ( .A0(n33), .A1(n18), .A2(strt_chk_en), .B0(n36), .Y(n35) );
  AND2X1M U39 ( .A(N102), .B(bit_cnt[0]), .Y(n40) );
  AND4X1M U40 ( .A(bit_cnt[0]), .B(N102), .C(n41), .D(n42), .Y(n38) );
  NAND2BX2M U41 ( .AN(bit_cnt[3]), .B(n38), .Y(n33) );
  AND2X2M U42 ( .A(bit_cnt[3]), .B(n38), .Y(n29) );
  INVX2M U43 ( .A(n32), .Y(deser_en) );
  NAND3X2M U44 ( .A(n43), .B(n47), .C(test_so), .Y(n25) );
  INVX2M U45 ( .A(Current_State_1_), .Y(n47) );
  NAND2X2M U46 ( .A(Current_State_1_), .B(n46), .Y(n26) );
  INVX2M U47 ( .A(test_so), .Y(n46) );
  NOR3X6M U48 ( .A(Current_State_1_), .B(Current_State_0_), .C(n46), .Y(
        stp_chk_en) );
  INVX2M U49 ( .A(bit_cnt[2]), .Y(n23) );
  INVX2M U50 ( .A(PAR_EN), .Y(n48) );
  INVX2M U51 ( .A(strt_glitch), .Y(n18) );
  OAI211X4M U52 ( .A0(test_so), .A1(n43), .B0(n25), .C0(n26), .Y(
        data_sample_en) );
  OAI2B2X1M U53 ( .A1N(prescale[1]), .A0(n9), .B0(edge_cnt[1]), .B1(n9), .Y(
        n13) );
  OAI2B2X1M U54 ( .A1N(edge_cnt[1]), .A0(n10), .B0(prescale[1]), .B1(n10), .Y(
        n12) );
  XNOR2X1M U55 ( .A(prescale[5]), .B(edge_cnt[5]), .Y(n11) );
  NAND3X1M U56 ( .A(n13), .B(n12), .C(n11), .Y(n17) );
  CLKXOR2X2M U57 ( .A(prescale[4]), .B(edge_cnt[4]), .Y(n16) );
  CLKXOR2X2M U58 ( .A(prescale[2]), .B(edge_cnt[2]), .Y(n15) );
  CLKXOR2X2M U59 ( .A(prescale[3]), .B(edge_cnt[3]), .Y(n14) );
endmodule


module edge_bit_counter_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHX1M U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX1M U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1M U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1M U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1M U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHX1M U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  CLKXOR2X2M U1 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
  CLKINVX1M U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module edge_bit_counter_test_1 ( CLK, RST, enable, prescale, edge_cnt, bit_cnt, 
        test_si, test_se );
  input [5:0] prescale;
  output [5:0] edge_cnt;
  output [7:0] bit_cnt;
  input CLK, RST, enable, test_si, test_se;
  wire   n66, n7, n67, n77, n78, N6, N8, N9, N10, N11, N12, N13, N14, N15, N17,
         N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, N45,
         mult_add_23_aco_PROD_not_0_, n1, n2, n3, n4, n19, n20, n34, n35, n36,
         n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65,
         n70, n72, n74, n75, n76, n5;
  wire   [5:2] add_23_aco_carry;

  SDFFRQX2M bit_cnt_reg_3_ ( .D(n28), .SI(n74), .SE(test_se), .CK(CLK), .RN(
        n52), .Q(n67) );
  SDFFRQX2M bit_cnt_reg_0_ ( .D(n31), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(n52), .Q(bit_cnt[0]) );
  SDFFRQX2M edge_cnt_reg_1_ ( .D(N25), .SI(edge_cnt[0]), .SE(test_se), .CK(CLK), .RN(n52), .Q(n66) );
  SDFFRQX4M edge_cnt_reg_2_ ( .D(N26), .SI(edge_cnt[1]), .SE(test_se), .CK(CLK), .RN(n52), .Q(edge_cnt[2]) );
  SDFFRQX4M edge_cnt_reg_3_ ( .D(N27), .SI(n76), .SE(test_se), .CK(CLK), .RN(
        n52), .Q(edge_cnt[3]) );
  SDFFRQX4M edge_cnt_reg_4_ ( .D(N28), .SI(edge_cnt[3]), .SE(test_se), .CK(CLK), .RN(n52), .Q(edge_cnt[4]) );
  SDFFRQX4M edge_cnt_reg_5_ ( .D(N29), .SI(edge_cnt[4]), .SE(test_se), .CK(CLK), .RN(n52), .Q(edge_cnt[5]) );
  SDFFRQX2M bit_cnt_reg_2_ ( .D(n29), .SI(n70), .SE(test_se), .CK(CLK), .RN(
        n52), .Q(n77) );
  SDFFRQX2M bit_cnt_reg_5_ ( .D(n26), .SI(bit_cnt[4]), .SE(test_se), .CK(CLK), 
        .RN(n53), .Q(bit_cnt[5]) );
  SDFFRQX2M bit_cnt_reg_7_ ( .D(n32), .SI(bit_cnt[6]), .SE(test_se), .CK(CLK), 
        .RN(n52), .Q(bit_cnt[7]) );
  SDFFRQX2M bit_cnt_reg_6_ ( .D(n25), .SI(bit_cnt[5]), .SE(test_se), .CK(CLK), 
        .RN(n53), .Q(bit_cnt[6]) );
  SDFFRQX2M bit_cnt_reg_4_ ( .D(n27), .SI(n67), .SE(test_se), .CK(CLK), .RN(
        n52), .Q(bit_cnt[4]) );
  SDFFRQX2M bit_cnt_reg_1_ ( .D(n30), .SI(n35), .SE(test_se), .CK(CLK), .RN(
        n52), .Q(n78) );
  AND2X2M U6 ( .A(edge_cnt[1]), .B(N17), .Y(n1) );
  AND2X2M U18 ( .A(n76), .B(N17), .Y(n2) );
  AND2X2M U19 ( .A(edge_cnt[3]), .B(N17), .Y(n3) );
  AND2X2M U20 ( .A(edge_cnt[4]), .B(N17), .Y(n4) );
  AND2X2M U21 ( .A(N17), .B(edge_cnt[5]), .Y(n19) );
  CLKINVX1M U22 ( .A(n67), .Y(n20) );
  CLKINVX2M U23 ( .A(n20), .Y(bit_cnt[3]) );
  NOR2BX2M U24 ( .AN(edge_cnt[0]), .B(prescale[0]), .Y(n55) );
  NOR2BX2M U25 ( .AN(prescale[0]), .B(edge_cnt[0]), .Y(n56) );
  CLKINVX1M U26 ( .A(bit_cnt[0]), .Y(n34) );
  INVX2M U27 ( .A(n34), .Y(n35) );
  OR3X1M U28 ( .A(edge_cnt[5]), .B(edge_cnt[4]), .C(edge_cnt[3]), .Y(n23) );
  INVXLM U29 ( .A(n66), .Y(n36) );
  INVX8M U30 ( .A(n36), .Y(edge_cnt[1]) );
  NOR4X2M U45 ( .A(n63), .B(n62), .C(n61), .D(n60), .Y(N6) );
  INVX6M U46 ( .A(n54), .Y(n52) );
  INVX2M U47 ( .A(n54), .Y(n53) );
  INVX2M U48 ( .A(RST), .Y(n54) );
  CLKINVX3M U49 ( .A(N6), .Y(N17) );
  AND2X2M U50 ( .A(mult_add_23_aco_PROD_not_0_), .B(enable), .Y(N24) );
  AND2X2M U51 ( .A(N19), .B(enable), .Y(N25) );
  AND2X2M U52 ( .A(N20), .B(enable), .Y(N26) );
  AND2X2M U53 ( .A(N21), .B(enable), .Y(N27) );
  AND2X2M U54 ( .A(N22), .B(enable), .Y(N28) );
  INVX4M U55 ( .A(n22), .Y(n64) );
  CLKAND2X4M U56 ( .A(enable), .B(n22), .Y(n21) );
  ADDHX1M U57 ( .A(n1), .B(N45), .CO(add_23_aco_carry[2]), .S(N19) );
  ADDHX1M U58 ( .A(n2), .B(add_23_aco_carry[2]), .CO(add_23_aco_carry[3]), .S(
        N20) );
  ADDHX1M U59 ( .A(n3), .B(add_23_aco_carry[3]), .CO(add_23_aco_carry[4]), .S(
        N21) );
  ADDHX1M U60 ( .A(n4), .B(add_23_aco_carry[4]), .CO(add_23_aco_carry[5]), .S(
        N22) );
  AND2X2M U61 ( .A(N23), .B(enable), .Y(N29) );
  OAI211X4M U62 ( .A0(n23), .A1(n24), .B0(n65), .C0(enable), .Y(n22) );
  OR3X2M U63 ( .A(edge_cnt[0]), .B(edge_cnt[1]), .C(edge_cnt[2]), .Y(n24) );
  INVXLM U64 ( .A(N6), .Y(n65) );
  AO22X1M U65 ( .A0(n35), .A1(n64), .B0(N8), .B1(n21), .Y(n31) );
  AO22X1M U66 ( .A0(n67), .A1(n64), .B0(N11), .B1(n21), .Y(n28) );
  AO22X1M U67 ( .A0(n64), .A1(n75), .B0(N10), .B1(n21), .Y(n29) );
  AO22X1M U68 ( .A0(n64), .A1(n72), .B0(N9), .B1(n21), .Y(n30) );
  AO22X1M U69 ( .A0(bit_cnt[6]), .A1(n64), .B0(N14), .B1(n21), .Y(n25) );
  AO22X1M U70 ( .A0(bit_cnt[5]), .A1(n64), .B0(N13), .B1(n21), .Y(n26) );
  AO22X1M U71 ( .A0(bit_cnt[4]), .A1(n64), .B0(N12), .B1(n21), .Y(n27) );
  AO22X1M U72 ( .A0(bit_cnt[7]), .A1(n64), .B0(N15), .B1(n21), .Y(n32) );
  CLKNAND2X2M U73 ( .A(edge_cnt[0]), .B(N17), .Y(mult_add_23_aco_PROD_not_0_)
         );
  CLKINVX1M U74 ( .A(mult_add_23_aco_PROD_not_0_), .Y(N45) );
  CLKXOR2X2M U75 ( .A(add_23_aco_carry[5]), .B(n19), .Y(N23) );
  OAI2B2X1M U76 ( .A1N(prescale[1]), .A0(n55), .B0(edge_cnt[1]), .B1(n55), .Y(
        n59) );
  OAI2B2X1M U77 ( .A1N(edge_cnt[1]), .A0(n56), .B0(prescale[1]), .B1(n56), .Y(
        n58) );
  XNOR2X1M U78 ( .A(prescale[5]), .B(edge_cnt[5]), .Y(n57) );
  NAND3X1M U79 ( .A(n59), .B(n58), .C(n57), .Y(n63) );
  CLKXOR2X2M U80 ( .A(prescale[4]), .B(edge_cnt[4]), .Y(n62) );
  CLKXOR2X2M U81 ( .A(prescale[2]), .B(edge_cnt[2]), .Y(n61) );
  CLKXOR2X2M U82 ( .A(prescale[3]), .B(edge_cnt[3]), .Y(n60) );
  DLY1X1M U83 ( .A(n78), .Y(n70) );
  DLY1X1M U84 ( .A(n78), .Y(bit_cnt[1]) );
  DLY1X1M U85 ( .A(n78), .Y(n72) );
  DLY1X1M U86 ( .A(n77), .Y(bit_cnt[2]) );
  DLY1X1M U87 ( .A(n77), .Y(n74) );
  DLY1X1M U88 ( .A(n77), .Y(n75) );
  DLY1X1M U89 ( .A(edge_cnt[2]), .Y(n76) );
  edge_bit_counter_DW01_inc_0 add_26 ( .A({bit_cnt[7:4], n67, n74, n70, n35}), 
        .SUM({N15, N14, N13, N12, N11, N10, N9, N8}) );
  SDFFRQX2M edge_cnt_reg_0_ ( .D(N24), .SI(bit_cnt[7]), .SE(test_se), .CK(CLK), 
        .RN(n52), .Q(n7) );
  INVXLM U3 ( .A(n7), .Y(n5) );
  INVX8M U4 ( .A(n5), .Y(edge_cnt[0]) );
endmodule


module data_sampling_test_1 ( CLK, RST, RX_IN, prescale, data_sample_en, 
        edge_cnt, sampled_bit, Done, test_si, test_se );
  input [5:0] prescale;
  input [5:0] edge_cnt;
  input CLK, RST, RX_IN, data_sample_en, test_si, test_se;
  output sampled_bit, Done;
  wire   bit1_sampled, bit2_sampled, bit3_sampled, N8, N9, N10, N11, N12, N13,
         N17, N18, N19, N20, N21, N40, N41, n27, n28, n29, n1, n7, n8, n9, n10,
         n11, n12, n13, n14, n20, n21, n22, n23, n24, n25, n26, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n70, n71, n72;
  wire   [4:2] add_33_carry;

  SDFFSQX2M sampled_bit_reg ( .D(N41), .SI(n72), .SE(test_se), .CK(CLK), .SN(
        RST), .Q(sampled_bit) );
  SDFFRQX2M Done_reg ( .D(N40), .SI(test_si), .SE(test_se), .CK(CLK), .RN(n7), 
        .Q(Done) );
  INVX2M U4 ( .A(n8), .Y(n7) );
  OR4X2M U5 ( .A(n24), .B(n23), .C(n22), .D(n21), .Y(n1) );
  OAI22X1M U6 ( .A0(edge_cnt[1]), .A1(n60), .B0(edge_cnt[0]), .B1(prescale[1]), 
        .Y(n58) );
  OR2X2M U7 ( .A(prescale[2]), .B(prescale[1]), .Y(n9) );
  INVX4M U8 ( .A(edge_cnt[4]), .Y(n42) );
  XOR2X2M U9 ( .A(N12), .B(edge_cnt[4]), .Y(n23) );
  INVX4M U19 ( .A(edge_cnt[3]), .Y(n46) );
  AOI2BB2X1M U20 ( .B0(edge_cnt[0]), .B1(prescale[1]), .A0N(n46), .A1N(N19), 
        .Y(n45) );
  NOR4BX2M U21 ( .AN(n38), .B(n39), .C(n40), .D(n32), .Y(n37) );
  NOR3X4M U22 ( .A(prescale[4]), .B(prescale[5]), .C(n10), .Y(N13) );
  NOR4X2M U23 ( .A(n31), .B(n32), .C(n33), .D(n34), .Y(n30) );
  AOI222X2M U24 ( .A0(N19), .A1(n46), .B0(n38), .B1(n58), .C0(N18), .C1(n59), 
        .Y(n57) );
  AOI2BB2X2M U25 ( .B0(n60), .B1(edge_cnt[1]), .A0N(N18), .A1N(n59), .Y(n38)
         );
  OAI21X2M U26 ( .A0(N21), .A1(n53), .B0(n54), .Y(n43) );
  INVX2M U27 ( .A(data_sample_en), .Y(n32) );
  NOR3X2M U28 ( .A(n65), .B(n66), .C(n67), .Y(n64) );
  OR2X2M U29 ( .A(n9), .B(prescale[3]), .Y(n10) );
  NOR2BX2M U30 ( .AN(edge_cnt[0]), .B(N8), .Y(n12) );
  NOR2BX2M U31 ( .AN(N8), .B(edge_cnt[0]), .Y(n13) );
  OAI2BB1XLM U32 ( .A0N(n9), .A1N(prescale[3]), .B0(n10), .Y(N10) );
  INVX2M U33 ( .A(edge_cnt[5]), .Y(n41) );
  XOR2X1M U34 ( .A(prescale[1]), .B(edge_cnt[1]), .Y(n65) );
  INVX2M U35 ( .A(RST), .Y(n8) );
  ADDHX1M U36 ( .A(prescale[2]), .B(prescale[1]), .CO(add_33_carry[2]), .S(N17) );
  ADDHX2M U37 ( .A(prescale[3]), .B(add_33_carry[2]), .CO(add_33_carry[3]), 
        .S(N18) );
  ADDHX4M U38 ( .A(prescale[4]), .B(add_33_carry[3]), .CO(add_33_carry[4]), 
        .S(N19) );
  ADDHX4M U39 ( .A(prescale[5]), .B(add_33_carry[4]), .CO(N21), .S(N20) );
  CLKINVX1M U40 ( .A(prescale[1]), .Y(N8) );
  OAI2BB1X1M U41 ( .A0N(prescale[1]), .A1N(prescale[2]), .B0(n9), .Y(N9) );
  XNOR2X1M U42 ( .A(prescale[4]), .B(n10), .Y(N11) );
  OAI21X1M U43 ( .A0(prescale[4]), .A1(n10), .B0(prescale[5]), .Y(n11) );
  NAND2BX1M U44 ( .AN(N13), .B(n11), .Y(N12) );
  OAI2B2X1M U45 ( .A1N(N9), .A0(n12), .B0(edge_cnt[1]), .B1(n12), .Y(n20) );
  OAI2B2X1M U46 ( .A1N(edge_cnt[1]), .A0(n13), .B0(N9), .B1(n13), .Y(n14) );
  NAND4BBX1M U47 ( .AN(N13), .BN(edge_cnt[5]), .C(n20), .D(n14), .Y(n24) );
  CLKXOR2X2M U48 ( .A(N10), .B(edge_cnt[2]), .Y(n22) );
  CLKXOR2X2M U49 ( .A(N11), .B(edge_cnt[3]), .Y(n21) );
  MXI2X1M U50 ( .A(n25), .B(n26), .S0(n30), .Y(n29) );
  NAND3X1M U51 ( .A(n35), .B(n1), .C(n36), .Y(n31) );
  CLKMX2X2M U52 ( .A(n72), .B(RX_IN), .S0(n37), .Y(n28) );
  OAI22X1M U53 ( .A0(N21), .A1(n41), .B0(N20), .B1(n42), .Y(n40) );
  NAND4X1M U54 ( .A(n43), .B(n1), .C(n44), .D(n45), .Y(n39) );
  NAND4BBX1M U55 ( .AN(n34), .BN(n33), .C(n36), .D(n35), .Y(n44) );
  CLKXOR2X2M U56 ( .A(prescale[4]), .B(n46), .Y(n35) );
  CLKXOR2X2M U57 ( .A(prescale[5]), .B(n42), .Y(n36) );
  NAND3X1M U58 ( .A(n47), .B(n41), .C(n48), .Y(n33) );
  XNOR2X1M U59 ( .A(prescale[1]), .B(edge_cnt[0]), .Y(n48) );
  XNOR2X1M U60 ( .A(prescale[2]), .B(edge_cnt[1]), .Y(n47) );
  CLKXOR2X2M U61 ( .A(prescale[3]), .B(edge_cnt[2]), .Y(n34) );
  MXI2X1M U62 ( .A(n49), .B(n26), .S0(n50), .Y(n27) );
  NOR2X1M U63 ( .A(n32), .B(n1), .Y(n50) );
  CLKINVX1M U64 ( .A(RX_IN), .Y(n26) );
  OAI211X1M U65 ( .A0(n25), .A1(n49), .B0(n51), .C0(N40), .Y(N41) );
  OAI21X1M U66 ( .A0(n71), .A1(n70), .B0(bit3_sampled), .Y(n51) );
  CLKINVX1M U67 ( .A(bit1_sampled), .Y(n49) );
  CLKINVX1M U68 ( .A(bit2_sampled), .Y(n25) );
  AND3X1M U69 ( .A(n52), .B(n43), .C(data_sample_en), .Y(N40) );
  AO21XLM U70 ( .A0(n53), .A1(N21), .B0(n41), .Y(n54) );
  OA21X1M U71 ( .A0(N20), .A1(n42), .B0(n55), .Y(n53) );
  OAI2BB2X1M U72 ( .B0(n56), .B1(n57), .A0N(n42), .A1N(N20), .Y(n55) );
  CLKINVX1M U73 ( .A(edge_cnt[2]), .Y(n59) );
  CLKINVX1M U74 ( .A(N17), .Y(n60) );
  NOR2X1M U75 ( .A(N19), .B(n46), .Y(n56) );
  NAND4X1M U76 ( .A(n61), .B(n62), .C(n63), .D(n64), .Y(n52) );
  CLKXOR2X2M U77 ( .A(prescale[0]), .B(edge_cnt[0]), .Y(n67) );
  CLKXOR2X2M U78 ( .A(prescale[2]), .B(edge_cnt[2]), .Y(n66) );
  CLKXOR2X2M U79 ( .A(prescale[4]), .B(n42), .Y(n63) );
  CLKXOR2X2M U80 ( .A(prescale[5]), .B(n41), .Y(n62) );
  CLKXOR2X2M U81 ( .A(prescale[3]), .B(n46), .Y(n61) );
  DLY1X1M U82 ( .A(bit2_sampled), .Y(n70) );
  DLY1X1M U83 ( .A(bit1_sampled), .Y(n71) );
  DLY1X1M U84 ( .A(bit3_sampled), .Y(n72) );
  SDFFRQX2M bit3_sampled_reg ( .D(n28), .SI(n70), .SE(test_se), .CK(CLK), .RN(
        n7), .Q(bit3_sampled) );
  SDFFRQX2M bit2_sampled_reg ( .D(n29), .SI(n71), .SE(test_se), .CK(CLK), .RN(
        n7), .Q(bit2_sampled) );
  SDFFRQX2M bit1_sampled_reg ( .D(n27), .SI(Done), .SE(test_se), .CK(CLK), 
        .RN(n7), .Q(bit1_sampled) );
endmodule


module deserializer_test_1 ( CLK, RST, deser_en, sampled_bit, edge_cnt, 
        prescale, P_DATA, test_so, test_se );
  input [5:0] edge_cnt;
  input [5:0] prescale;
  output [7:0] P_DATA;
  input CLK, RST, deser_en, sampled_bit, test_se;
  output test_so;
  wire   i_1_, i_0_, N15, n3, n4, n6, n7, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n22, n23, n24, n34, n36, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66;

  SDFFRQX2M i_reg_0_ ( .D(n38), .SI(P_DATA[7]), .SE(test_se), .CK(CLK), .RN(
        n52), .Q(i_0_) );
  SDFFRQX2M i_reg_1_ ( .D(n36), .SI(n63), .SE(test_se), .CK(CLK), .RN(n52), 
        .Q(i_1_) );
  SDFFRQX2M i_reg_2_ ( .D(n34), .SI(n64), .SE(test_se), .CK(CLK), .RN(n52), 
        .Q(test_so) );
  SDFFRQX2M P_DATA_reg_2_ ( .D(n44), .SI(P_DATA[1]), .SE(test_se), .CK(CLK), 
        .RN(n52), .Q(P_DATA[2]) );
  SDFFRQX2M P_DATA_reg_6_ ( .D(n40), .SI(P_DATA[5]), .SE(test_se), .CK(CLK), 
        .RN(n52), .Q(P_DATA[6]) );
  SDFFRQX2M P_DATA_reg_4_ ( .D(n42), .SI(P_DATA[3]), .SE(test_se), .CK(CLK), 
        .RN(n52), .Q(P_DATA[4]) );
  SDFFRQX2M P_DATA_reg_0_ ( .D(n46), .SI(sampled_bit), .SE(test_se), .CK(CLK), 
        .RN(n52), .Q(P_DATA[0]) );
  SDFFRQX2M P_DATA_reg_1_ ( .D(n45), .SI(P_DATA[0]), .SE(test_se), .CK(CLK), 
        .RN(n52), .Q(P_DATA[1]) );
  SDFFRQX2M P_DATA_reg_5_ ( .D(n41), .SI(P_DATA[4]), .SE(test_se), .CK(CLK), 
        .RN(n52), .Q(P_DATA[5]) );
  SDFFRQX2M P_DATA_reg_3_ ( .D(n43), .SI(P_DATA[2]), .SE(test_se), .CK(CLK), 
        .RN(n52), .Q(P_DATA[3]) );
  SDFFRQX2M P_DATA_reg_7_ ( .D(n39), .SI(P_DATA[6]), .SE(test_se), .CK(CLK), 
        .RN(n52), .Q(P_DATA[7]) );
  NOR2BX2M U3 ( .AN(prescale[0]), .B(edge_cnt[0]), .Y(n55) );
  NAND2X3M U4 ( .A(i_1_), .B(i_0_), .Y(n4) );
  XOR2X2M U5 ( .A(prescale[4]), .B(edge_cnt[4]), .Y(n61) );
  NOR4X2M U17 ( .A(n62), .B(n61), .C(n60), .D(n59), .Y(N15) );
  NAND3X2M U18 ( .A(n58), .B(n57), .C(n56), .Y(n62) );
  NOR2BX2M U19 ( .AN(edge_cnt[0]), .B(prescale[0]), .Y(n54) );
  NOR2X2M U20 ( .A(n6), .B(test_so), .Y(n24) );
  INVX6M U21 ( .A(n53), .Y(n52) );
  INVX2M U22 ( .A(RST), .Y(n53) );
  OAI221X1M U23 ( .A0(n6), .A1(n7), .B0(n66), .B1(n64), .C0(n10), .Y(n36) );
  INVX4M U24 ( .A(n24), .Y(n65) );
  INVX2M U25 ( .A(n6), .Y(n66) );
  NAND2X2M U26 ( .A(n64), .B(n63), .Y(n16) );
  NAND2X3M U27 ( .A(deser_en), .B(N15), .Y(n6) );
  NAND2BX2M U28 ( .AN(n13), .B(sampled_bit), .Y(n11) );
  OAI2B2X1M U29 ( .A1N(test_so), .A0(n3), .B0(n4), .B1(n65), .Y(n34) );
  NOR2X2M U30 ( .A(n4), .B(n6), .Y(n3) );
  NAND2X4M U31 ( .A(test_so), .B(n66), .Y(n13) );
  NAND2X2M U32 ( .A(sampled_bit), .B(n24), .Y(n18) );
  OAI21X2M U33 ( .A0(n4), .A1(n18), .B0(n19), .Y(n43) );
  OAI21X2M U34 ( .A0(n4), .A1(n65), .B0(P_DATA[3]), .Y(n19) );
  OAI21X2M U35 ( .A0(n4), .A1(n11), .B0(n12), .Y(n39) );
  OAI21X2M U36 ( .A0(n4), .A1(n13), .B0(P_DATA[7]), .Y(n12) );
  OAI21X2M U48 ( .A0(n7), .A1(n18), .B0(n22), .Y(n45) );
  OAI21X2M U49 ( .A0(n65), .A1(n7), .B0(P_DATA[1]), .Y(n22) );
  OAI21X2M U50 ( .A0(n7), .A1(n11), .B0(n15), .Y(n41) );
  OAI21X2M U51 ( .A0(n7), .A1(n13), .B0(P_DATA[5]), .Y(n15) );
  OAI21X2M U52 ( .A0(n10), .A1(n18), .B0(n20), .Y(n44) );
  OAI21X2M U53 ( .A0(n65), .A1(n10), .B0(P_DATA[2]), .Y(n20) );
  OAI21X2M U54 ( .A0(n11), .A1(n10), .B0(n14), .Y(n40) );
  OAI21X2M U55 ( .A0(n13), .A1(n10), .B0(P_DATA[6]), .Y(n14) );
  OAI21X2M U56 ( .A0(n16), .A1(n18), .B0(n23), .Y(n46) );
  OAI21X2M U57 ( .A0(n65), .A1(n16), .B0(P_DATA[0]), .Y(n23) );
  OAI21X2M U58 ( .A0(n11), .A1(n16), .B0(n17), .Y(n42) );
  OAI21X2M U59 ( .A0(n13), .A1(n16), .B0(P_DATA[4]), .Y(n17) );
  XNOR2X2M U60 ( .A(i_0_), .B(n6), .Y(n38) );
  NAND2X4M U61 ( .A(i_0_), .B(n64), .Y(n7) );
  NAND2X4M U62 ( .A(i_1_), .B(n63), .Y(n10) );
  INVX2M U63 ( .A(i_1_), .Y(n64) );
  INVX2M U64 ( .A(i_0_), .Y(n63) );
  OAI2B2X1M U65 ( .A1N(prescale[1]), .A0(n54), .B0(edge_cnt[1]), .B1(n54), .Y(
        n58) );
  OAI2B2X1M U66 ( .A1N(edge_cnt[1]), .A0(n55), .B0(prescale[1]), .B1(n55), .Y(
        n57) );
  XNOR2X1M U67 ( .A(prescale[5]), .B(edge_cnt[5]), .Y(n56) );
  CLKXOR2X2M U68 ( .A(prescale[2]), .B(edge_cnt[2]), .Y(n60) );
  CLKXOR2X2M U69 ( .A(prescale[3]), .B(edge_cnt[3]), .Y(n59) );
endmodule


module parity_check_test_1 ( CLK, RST, par_chk_en, sampled_bit, PAR_TYP, 
        P_DATA, Done, parr_err, test_si, test_se );
  input [7:0] P_DATA;
  input CLK, RST, par_chk_en, sampled_bit, PAR_TYP, Done, test_si, test_se;
  output parr_err;
  wire   n1, n2, n3, n4, n5, n6, n7, n9;

  SDFFRQX4M parr_err_reg ( .D(n9), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(parr_err) );
  XNOR2X2M U2 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
  XNOR2X2M U3 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n7) );
  XNOR2X1M U4 ( .A(sampled_bit), .B(PAR_TYP), .Y(n5) );
  OAI2BB2X1M U6 ( .B0(n1), .B1(n2), .A0N(parr_err), .A1N(n2), .Y(n9) );
  XOR3XLM U7 ( .A(n3), .B(n4), .C(n5), .Y(n1) );
  NAND2X2M U8 ( .A(par_chk_en), .B(Done), .Y(n2) );
  XOR3XLM U9 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n4) );
  XOR3XLM U11 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n7), .Y(n3) );
endmodule


module strt_check_test_1 ( CLK, RST, strt_chk_en, sampled_bit, Done, 
        strt_glitch, test_si, test_se );
  input CLK, RST, strt_chk_en, sampled_bit, Done, test_si, test_se;
  output strt_glitch;
  wire   N1;

  AND3XLM U4 ( .A(sampled_bit), .B(Done), .C(strt_chk_en), .Y(N1) );
  SDFFRQX2M strt_glitch_reg ( .D(N1), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(strt_glitch) );
endmodule


module stp_check_test_1 ( CLK, RST, stp_chk_en, sampled_bit, Done, stp_err, 
        test_si, test_se );
  input CLK, RST, stp_chk_en, sampled_bit, Done, test_si, test_se;
  output stp_err;
  wire   N1, n3;

  SDFFRQX4M stp_err_reg ( .D(N1), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(stp_err) );
  AND3XLM U4 ( .A(n3), .B(Done), .C(stp_chk_en), .Y(N1) );
  INVX2M U6 ( .A(sampled_bit), .Y(n3) );
endmodule


module UART_RX_test_1 ( CLK, RST, PAR_EN, PAR_TYP, prescale, RX_IN, P_DATA, 
        data_valid, parr_err, Framing_error, test_si, test_so, test_se );
  input [5:0] prescale;
  output [7:0] P_DATA;
  input CLK, RST, PAR_EN, PAR_TYP, RX_IN, test_si, test_se;
  output data_valid, parr_err, Framing_error, test_so;
  wire   deser_en, data_sample_en, enable, par_chk_en, strt_chk_en, stp_chk_en,
         sampled_bit, Done, n1, n2, n3, n4, n7;
  wire   [5:0] edge_cnt;
  wire   [7:0] bit_cnt;

  INVX4M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
  DLY1X1M U3 ( .A(sampled_bit), .Y(n7) );
  RX_FSM_test_1 DUT_fsm ( .CLK(CLK), .RST(n1), .RX_IN(RX_IN), .PAR_EN(PAR_EN), 
        .edge_cnt(edge_cnt), .bit_cnt(bit_cnt), .parr_err(parr_err), 
        .strt_glitch(test_so), .stp_err(Framing_error), .prescale(prescale), 
        .data_valid(data_valid), .deser_en(deser_en), .data_sample_en(
        data_sample_en), .enable(enable), .par_chk_en(par_chk_en), 
        .strt_chk_en(strt_chk_en), .stp_chk_en(stp_chk_en), .test_so(n3), 
        .test_se(test_se) );
  edge_bit_counter_test_1 DUT_edge_bit_cnt ( .CLK(CLK), .RST(n1), .enable(
        enable), .prescale(prescale), .edge_cnt(edge_cnt), .bit_cnt(bit_cnt), 
        .test_si(n4), .test_se(test_se) );
  data_sampling_test_1 DUT_data_samp ( .CLK(CLK), .RST(n1), .RX_IN(RX_IN), 
        .prescale(prescale), .data_sample_en(data_sample_en), .edge_cnt(
        edge_cnt), .sampled_bit(sampled_bit), .Done(Done), .test_si(test_si), 
        .test_se(test_se) );
  deserializer_test_1 DUT_deser ( .CLK(CLK), .RST(n1), .deser_en(deser_en), 
        .sampled_bit(sampled_bit), .edge_cnt(edge_cnt), .prescale(prescale), 
        .P_DATA(P_DATA), .test_so(n4), .test_se(test_se) );
  parity_check_test_1 DUT_par_chk ( .CLK(CLK), .RST(n1), .par_chk_en(
        par_chk_en), .sampled_bit(sampled_bit), .PAR_TYP(PAR_TYP), .P_DATA(
        P_DATA), .Done(Done), .parr_err(parr_err), .test_si(n3), .test_se(
        test_se) );
  strt_check_test_1 DUT_strt_chk ( .CLK(CLK), .RST(n1), .strt_chk_en(
        strt_chk_en), .sampled_bit(n7), .Done(Done), .strt_glitch(test_so), 
        .test_si(Framing_error), .test_se(test_se) );
  stp_check_test_1 DUT_stp_chk ( .CLK(CLK), .RST(n1), .stp_chk_en(stp_chk_en), 
        .sampled_bit(n7), .Done(Done), .stp_err(Framing_error), .test_si(
        parr_err), .test_se(test_se) );
endmodule


module UART_test_1 ( PAR_EN, PAR_TYP, RST, TX_CLK, TX_IN_VLD, TX_IN_P, 
        TX_OUT_S, TX_OUT_VLD, RX_CLK, prescale, RX_IN_S, RX_OUT_P, RX_OUT_VLD, 
        parr_err, Framing_error, test_si, test_se );
  input [7:0] TX_IN_P;
  input [5:0] prescale;
  output [7:0] RX_OUT_P;
  input PAR_EN, PAR_TYP, RST, TX_CLK, TX_IN_VLD, RX_CLK, RX_IN_S, test_si,
         test_se;
  output TX_OUT_S, TX_OUT_VLD, RX_OUT_VLD, parr_err, Framing_error;
  wire   n1, n2, n3;

  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
  UART_TX_test_1 U0_UART_TX ( .CLK(TX_CLK), .RST(n1), .PAR_EN(PAR_EN), 
        .PAR_TYP(PAR_TYP), .Data_Valid(TX_IN_VLD), .P_DATA(TX_IN_P), .TX_OUT(
        TX_OUT_S), .busy(TX_OUT_VLD), .test_si(n3), .test_se(test_se) );
  UART_RX_test_1 U0_UART_RX ( .CLK(RX_CLK), .RST(n1), .PAR_EN(PAR_EN), 
        .PAR_TYP(PAR_TYP), .prescale(prescale), .RX_IN(RX_IN_S), .P_DATA(
        RX_OUT_P), .data_valid(RX_OUT_VLD), .parr_err(parr_err), 
        .Framing_error(Framing_error), .test_si(test_si), .test_so(n3), 
        .test_se(test_se) );
endmodule


module DATA_SYNC_test_1 ( CLK, RST, bus_enable, Unsync_bus, sync_bus, 
        enable_pulse, test_si, test_so, test_se );
  input [7:0] Unsync_bus;
  output [7:0] sync_bus;
  input CLK, RST, bus_enable, test_si, test_se;
  output enable_pulse, test_so;
  wire   sync_reg_0_, pulse, N1, n3, n5, n7, n9, n11, n13, n15, n17, n33, n34,
         n35, n36, n39, n40, n41;

  SDFFRQX2M enable_pulse_reg ( .D(pulse), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(enable_pulse) );
  SDFFRQX1M sync_reg_reg_1_ ( .D(n41), .SI(n41), .SE(test_se), .CK(CLK), .RN(
        n34), .Q(test_so) );
  SDFFRQX1M pulse_reg ( .D(N1), .SI(enable_pulse), .SE(test_se), .CK(CLK), 
        .RN(n34), .Q(pulse) );
  SDFFRQX1M sync_reg_reg_0_ ( .D(bus_enable), .SI(sync_bus[7]), .SE(test_se), 
        .CK(CLK), .RN(n34), .Q(sync_reg_0_) );
  SDFFRQX2M sync_bus_reg_6_ ( .D(n15), .SI(sync_bus[5]), .SE(test_se), .CK(CLK), .RN(n34), .Q(sync_bus[6]) );
  SDFFRQX2M sync_bus_reg_1_ ( .D(n5), .SI(sync_bus[0]), .SE(test_se), .CK(CLK), 
        .RN(n34), .Q(sync_bus[1]) );
  SDFFRQX2M sync_bus_reg_3_ ( .D(n9), .SI(sync_bus[2]), .SE(test_se), .CK(CLK), 
        .RN(n34), .Q(sync_bus[3]) );
  SDFFRQX2M sync_bus_reg_0_ ( .D(n3), .SI(n36), .SE(test_se), .CK(CLK), .RN(
        n34), .Q(sync_bus[0]) );
  SDFFRQX2M sync_bus_reg_5_ ( .D(n13), .SI(sync_bus[4]), .SE(test_se), .CK(CLK), .RN(n34), .Q(sync_bus[5]) );
  SDFFRQX2M sync_bus_reg_7_ ( .D(n17), .SI(n40), .SE(test_se), .CK(CLK), .RN(
        n34), .Q(sync_bus[7]) );
  SDFFRQX4M sync_bus_reg_2_ ( .D(n7), .SI(n39), .SE(test_se), .CK(CLK), .RN(
        n34), .Q(sync_bus[2]) );
  SDFFRQX4M sync_bus_reg_4_ ( .D(n11), .SI(sync_bus[3]), .SE(test_se), .CK(CLK), .RN(n34), .Q(sync_bus[4]) );
  BUFX4M U3 ( .A(pulse), .Y(n33) );
  AO22XLM U4 ( .A0(sync_bus[7]), .A1(n36), .B0(Unsync_bus[7]), .B1(n33), .Y(
        n17) );
  AO22XLM U5 ( .A0(sync_bus[4]), .A1(n36), .B0(Unsync_bus[4]), .B1(n33), .Y(
        n11) );
  AO22XLM U6 ( .A0(sync_bus[2]), .A1(n36), .B0(Unsync_bus[2]), .B1(n33), .Y(n7) );
  INVX4M U31 ( .A(n33), .Y(n36) );
  INVX6M U32 ( .A(n35), .Y(n34) );
  INVX2M U33 ( .A(RST), .Y(n35) );
  AO22X1M U34 ( .A0(sync_bus[0]), .A1(n36), .B0(n33), .B1(Unsync_bus[0]), .Y(
        n3) );
  AO22X1M U35 ( .A0(n36), .A1(n39), .B0(Unsync_bus[1]), .B1(n33), .Y(n5) );
  AO22X1M U36 ( .A0(sync_bus[3]), .A1(n36), .B0(Unsync_bus[3]), .B1(n33), .Y(
        n9) );
  AO22X1M U37 ( .A0(sync_bus[5]), .A1(n36), .B0(Unsync_bus[5]), .B1(n33), .Y(
        n13) );
  AO22X1M U38 ( .A0(n36), .A1(n40), .B0(Unsync_bus[6]), .B1(n33), .Y(n15) );
  NOR2BX2M U39 ( .AN(test_so), .B(sync_reg_0_), .Y(N1) );
  DLY1X1M U40 ( .A(sync_bus[1]), .Y(n39) );
  DLY1X1M U41 ( .A(sync_bus[6]), .Y(n40) );
  DLY1X1M U42 ( .A(sync_reg_0_), .Y(n41) );
endmodule


module PULSE_GEN_test_1 ( CLK, RST, LVL_SIG, PULSE_SIG, test_si, test_so, 
        test_se );
  input CLK, RST, LVL_SIG, test_si, test_se;
  output PULSE_SIG, test_so;
  wire   pls_flop, rcv_flop;

  SDFFRQX1M pls_flop_reg ( .D(test_so), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(pls_flop) );
  SDFFRQX1M rcv_flop_reg ( .D(LVL_SIG), .SI(pls_flop), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(rcv_flop) );
  NOR2BX2M U7 ( .AN(rcv_flop), .B(pls_flop), .Y(PULSE_SIG) );
  DLY1X1M U8 ( .A(rcv_flop), .Y(test_so) );
endmodule


module SYS_CTRL_test_1 ( CLK, RST, ALU_OUT, OUT_Valid, RdData, RdData_Valid, 
        RX_P_DATA, RX_D_VLD, FIFO_FULL, parity_error, Framing_error, ALU_FUN, 
        ALU_EN, CLK_EN, Address, WrEn, RdEn, WrData, TX_P_DATA, TX_D_VLD, 
        clk_div_en, test_si, test_so, test_se );
  input [15:0] ALU_OUT;
  input [7:0] RdData;
  input [7:0] RX_P_DATA;
  output [3:0] ALU_FUN;
  output [3:0] Address;
  output [7:0] WrData;
  output [7:0] TX_P_DATA;
  input CLK, RST, OUT_Valid, RdData_Valid, RX_D_VLD, FIFO_FULL, parity_error,
         Framing_error, test_si, test_se;
  output ALU_EN, CLK_EN, WrEn, RdEn, TX_D_VLD, clk_div_en, test_so;
  wire   n108, n109, n1, n11, n12, n18, n20, n21, n23, n24, n25, n26, n27, n28,
         n30, n32, n33, n34, n35, n36, n37, n39, n40, n41, n43, n44, n48, n49,
         n50, n52, n53, n54, n55, n56, n57, n59, n60, n61, n62, n63, n64, n65,
         n66, n68, n69, n70, n71, n72, n76, n78, n80, n82, n15, n17, n22, n29,
         n31, n38, n42, n45, n46, n47, n51, n58, n67, n73, n74, n87, n88, n89,
         n90, n91, n92, n93, n94, n96, n97, n98, n99, n100, n101, n102, n103,
         n104, n105, n106, n107, n112, n113;
  wire   [3:0] Current_State;
  wire   [3:0] Next_State;
  wire   [3:0] Temp_Address;

  NOR3X12M U8 ( .A(n38), .B(RX_D_VLD), .C(n11), .Y(n1) );
  SDFFRQX4M Current_State_reg_0_ ( .D(Next_State[0]), .SI(test_si), .SE(
        test_se), .CK(CLK), .RN(n42), .Q(Current_State[0]) );
  SDFFRQX4M Current_State_reg_1_ ( .D(Next_State[1]), .SI(Current_State[0]), 
        .SE(test_se), .CK(CLK), .RN(n42), .Q(Current_State[1]) );
  SDFFRQX4M Current_State_reg_2_ ( .D(Next_State[2]), .SI(n92), .SE(test_se), 
        .CK(CLK), .RN(n42), .Q(Current_State[2]) );
  NOR2X8M U5 ( .A(n105), .B(n17), .Y(ALU_FUN[2]) );
  INVX2M U6 ( .A(RX_P_DATA[2]), .Y(n105) );
  AOI31X1M U7 ( .A0(RX_P_DATA[4]), .A1(RX_P_DATA[0]), .A2(n43), .B0(n46), .Y(
        n40) );
  NAND3XLM U9 ( .A(RX_P_DATA[3]), .B(RX_P_DATA[2]), .C(RX_P_DATA[7]), .Y(n54)
         );
  NAND4X4M U10 ( .A(Current_State[2]), .B(n31), .C(Current_State[1]), .D(n58), 
        .Y(n24) );
  NAND4X4M U11 ( .A(Current_State[2]), .B(n38), .C(Current_State[0]), .D(n92), 
        .Y(n21) );
  NOR2X4M U12 ( .A(n113), .B(Current_State[2]), .Y(n50) );
  CLKINVX4M U13 ( .A(Current_State[2]), .Y(n94) );
  AOI31X2M U14 ( .A0(Current_State[2]), .A1(n93), .A2(n92), .B0(n56), .Y(n48)
         );
  NAND2X2M U15 ( .A(Current_State[1]), .B(n50), .Y(n11) );
  NAND4X1M U16 ( .A(n38), .B(Current_State[0]), .C(Current_State[1]), .D(n94), 
        .Y(n33) );
  NAND4X4M U17 ( .A(Current_State[2]), .B(Current_State[0]), .C(n92), .D(n93), 
        .Y(n70) );
  CLKBUFX6M U26 ( .A(n108), .Y(Address[3]) );
  OAI22X1M U27 ( .A0(n104), .A1(n70), .B0(n71), .B1(test_so), .Y(n108) );
  BUFX4M U28 ( .A(n20), .Y(n15) );
  NOR3X2M U29 ( .A(n21), .B(OUT_Valid), .C(n47), .Y(n20) );
  CLKBUFX6M U30 ( .A(n109), .Y(Address[2]) );
  OAI22X1M U31 ( .A0(n105), .A1(n70), .B0(n71), .B1(n96), .Y(n109) );
  NAND2X2M U32 ( .A(n23), .B(n17), .Y(ALU_EN) );
  NOR2X6M U33 ( .A(n107), .B(n17), .Y(ALU_FUN[0]) );
  NOR2X4M U34 ( .A(n106), .B(n17), .Y(ALU_FUN[1]) );
  NAND2X2M U35 ( .A(OUT_Valid), .B(n91), .Y(n23) );
  CLKBUFX6M U36 ( .A(n33), .Y(n17) );
  INVX2M U37 ( .A(RX_P_DATA[1]), .Y(n106) );
  NOR3X2M U38 ( .A(n69), .B(n112), .C(n31), .Y(n65) );
  OR2X2M U39 ( .A(parity_error), .B(Framing_error), .Y(n26) );
  INVX2M U40 ( .A(n32), .Y(n74) );
  INVX4M U41 ( .A(WrEn), .Y(n22) );
  INVX2M U42 ( .A(n31), .Y(n93) );
  NAND2X2M U43 ( .A(n38), .B(n87), .Y(n32) );
  INVX2M U44 ( .A(n12), .Y(WrEn) );
  NOR2X2M U45 ( .A(n74), .B(n18), .Y(n12) );
  INVX2M U46 ( .A(n39), .Y(n89) );
  NOR3X6M U47 ( .A(n92), .B(n38), .C(n58), .Y(n18) );
  AND4X2M U48 ( .A(n17), .B(n21), .C(n11), .D(n72), .Y(n71) );
  AOI211X2M U49 ( .A0(n18), .A1(n94), .B0(n51), .C0(n68), .Y(n72) );
  INVX2M U50 ( .A(n24), .Y(n51) );
  OAI22X1M U51 ( .A0(n106), .A1(n70), .B0(n71), .B1(n97), .Y(Address[1]) );
  INVX4M U52 ( .A(n29), .Y(n31) );
  INVX4M U53 ( .A(n29), .Y(n38) );
  AND2X2M U54 ( .A(n50), .B(n38), .Y(n68) );
  OAI221X1M U55 ( .A0(n71), .A1(n98), .B0(n107), .B1(n70), .C0(n32), .Y(
        Address[0]) );
  OAI211X4M U56 ( .A0(n21), .A1(n47), .B0(n23), .C0(n24), .Y(TX_D_VLD) );
  INVX2M U57 ( .A(n21), .Y(n91) );
  INVX2M U58 ( .A(n70), .Y(RdEn) );
  INVX2M U59 ( .A(n69), .Y(n87) );
  AOI31X2M U60 ( .A0(n30), .A1(n11), .A2(n48), .B0(n99), .Y(n66) );
  NOR2X2M U61 ( .A(n22), .B(n107), .Y(WrData[0]) );
  NOR2X2M U62 ( .A(n22), .B(n104), .Y(WrData[3]) );
  NOR2X2M U63 ( .A(n22), .B(n106), .Y(WrData[1]) );
  NOR2X2M U64 ( .A(n22), .B(n105), .Y(WrData[2]) );
  NOR2X2M U65 ( .A(n12), .B(n103), .Y(WrData[4]) );
  NOR2X2M U66 ( .A(n22), .B(n102), .Y(WrData[5]) );
  NOR2X2M U67 ( .A(n22), .B(n101), .Y(WrData[6]) );
  NOR2X2M U68 ( .A(n22), .B(n100), .Y(WrData[7]) );
  INVX2M U69 ( .A(n1), .Y(n88) );
  OAI22X1M U70 ( .A0(n1), .A1(n98), .B0(n88), .B1(n107), .Y(n76) );
  OAI22X1M U71 ( .A0(n1), .A1(n97), .B0(n88), .B1(n106), .Y(n78) );
  OAI22X1M U72 ( .A0(n1), .A1(n96), .B0(n88), .B1(n105), .Y(n80) );
  OAI22X1M U73 ( .A0(n1), .A1(test_so), .B0(n88), .B1(n104), .Y(n82) );
  NOR2X2M U74 ( .A(n44), .B(n68), .Y(n30) );
  INVX4M U75 ( .A(n23), .Y(n46) );
  INVX2M U76 ( .A(n48), .Y(n67) );
  INVX2M U77 ( .A(n17), .Y(n90) );
  NAND3X2M U78 ( .A(n107), .B(n103), .C(n43), .Y(n39) );
  NOR2X2M U79 ( .A(n104), .B(n17), .Y(ALU_FUN[3]) );
  INVX4M U80 ( .A(n45), .Y(n42) );
  INVX2M U81 ( .A(RST), .Y(n45) );
  INVX4M U82 ( .A(Current_State[1]), .Y(n92) );
  INVX2M U83 ( .A(Current_State[0]), .Y(n58) );
  INVX2M U84 ( .A(Current_State[3]), .Y(n29) );
  INVX4M U85 ( .A(RX_P_DATA[0]), .Y(n107) );
  INVX4M U86 ( .A(RX_P_DATA[3]), .Y(n104) );
  NAND3X2M U87 ( .A(n92), .B(n94), .C(Current_State[0]), .Y(n69) );
  INVX2M U88 ( .A(Temp_Address[2]), .Y(n96) );
  INVX2M U89 ( .A(Temp_Address[3]), .Y(test_so) );
  NOR4X4M U90 ( .A(n94), .B(n93), .C(Current_State[0]), .D(Current_State[1]), 
        .Y(n44) );
  AO22XLM U91 ( .A0(ALU_OUT[0]), .A1(n46), .B0(RdData[0]), .B1(n15), .Y(
        TX_P_DATA[0]) );
  AO22XLM U92 ( .A0(ALU_OUT[1]), .A1(n46), .B0(RdData[1]), .B1(n15), .Y(
        TX_P_DATA[1]) );
  AO22XLM U93 ( .A0(ALU_OUT[2]), .A1(n46), .B0(RdData[2]), .B1(n15), .Y(
        TX_P_DATA[2]) );
  AO22XLM U94 ( .A0(ALU_OUT[3]), .A1(n46), .B0(RdData[3]), .B1(n15), .Y(
        TX_P_DATA[3]) );
  AO22XLM U95 ( .A0(ALU_OUT[4]), .A1(n46), .B0(RdData[4]), .B1(n15), .Y(
        TX_P_DATA[4]) );
  AO22XLM U96 ( .A0(ALU_OUT[5]), .A1(n46), .B0(RdData[5]), .B1(n15), .Y(
        TX_P_DATA[5]) );
  AO22XLM U97 ( .A0(ALU_OUT[6]), .A1(n46), .B0(RdData[6]), .B1(n15), .Y(
        TX_P_DATA[6]) );
  AO22XLM U98 ( .A0(ALU_OUT[7]), .A1(n46), .B0(RdData[7]), .B1(n15), .Y(
        TX_P_DATA[7]) );
  NOR4X4M U99 ( .A(Current_State[0]), .B(n92), .C(n94), .D(n31), .Y(n56) );
  OAI221X1M U100 ( .A0(n49), .A1(n26), .B0(FIFO_FULL), .B1(n23), .C0(n39), .Y(
        Next_State[1]) );
  NOR4BX2M U101 ( .AN(n11), .B(n55), .C(n56), .D(n74), .Y(n49) );
  OAI21X2M U102 ( .A0(OUT_Valid), .A1(n17), .B0(n57), .Y(n55) );
  OAI21X2M U103 ( .A0(n87), .A1(n44), .B0(n112), .Y(n57) );
  AND2X2M U104 ( .A(n40), .B(n41), .Y(n27) );
  OAI21X2M U105 ( .A0(FIFO_FULL), .A1(n47), .B0(n91), .Y(n41) );
  OAI211X2M U106 ( .A0(n34), .A1(n26), .B0(n27), .C0(n35), .Y(Next_State[2])
         );
  AOI31X2M U107 ( .A0(n36), .A1(RX_P_DATA[4]), .A2(n37), .B0(n89), .Y(n35) );
  AOI221X2M U108 ( .A0(n44), .A1(n99), .B0(n90), .B1(OUT_Valid), .C0(n67), .Y(
        n34) );
  NOR3X2M U109 ( .A(n107), .B(RX_P_DATA[6]), .C(RX_P_DATA[2]), .Y(n37) );
  OAI21X2M U110 ( .A0(n25), .A1(n26), .B0(n27), .Y(Next_State[3]) );
  AOI211X2M U111 ( .A0(RdEn), .A1(RdData_Valid), .B0(n28), .C0(n73), .Y(n25)
         );
  INVX2M U112 ( .A(n30), .Y(n73) );
  OAI2B11X2M U113 ( .A1N(n18), .A0(n94), .B0(n32), .C0(n17), .Y(n28) );
  OAI21X2M U122 ( .A0(n59), .A1(n26), .B0(n60), .Y(Next_State[0]) );
  AOI32X1M U123 ( .A0(n36), .A1(n107), .A2(n61), .B0(n91), .B1(n62), .Y(n60)
         );
  NOR4X2M U124 ( .A(n90), .B(RdEn), .C(n65), .D(n66), .Y(n59) );
  NOR3X2M U125 ( .A(RX_P_DATA[2]), .B(RX_P_DATA[6]), .C(RX_P_DATA[4]), .Y(n61)
         );
  INVX2M U126 ( .A(RdData_Valid), .Y(n47) );
  INVX2M U127 ( .A(Temp_Address[1]), .Y(n97) );
  INVX2M U128 ( .A(Temp_Address[0]), .Y(n98) );
  INVX2M U129 ( .A(RX_D_VLD), .Y(n99) );
  OAI21BX1M U130 ( .A0(RdData_Valid), .A1(OUT_Valid), .B0N(FIFO_FULL), .Y(n62)
         );
  AND4X2M U131 ( .A(n50), .B(n92), .C(n52), .D(n53), .Y(n43) );
  NOR3X2M U132 ( .A(n31), .B(RX_P_DATA[5]), .C(RX_P_DATA[1]), .Y(n52) );
  NOR3X2M U133 ( .A(n54), .B(n101), .C(n99), .Y(n53) );
  INVX2M U134 ( .A(RX_P_DATA[4]), .Y(n103) );
  INVX2M U135 ( .A(RX_P_DATA[6]), .Y(n101) );
  AND4X2M U136 ( .A(RX_P_DATA[1]), .B(n50), .C(n63), .D(n64), .Y(n36) );
  NOR2X2M U137 ( .A(n31), .B(Current_State[1]), .Y(n63) );
  NOR4X2M U138 ( .A(n104), .B(n100), .C(n102), .D(n99), .Y(n64) );
  INVX2M U139 ( .A(RX_P_DATA[5]), .Y(n102) );
  INVX2M U140 ( .A(RX_P_DATA[7]), .Y(n100) );
  NAND2BX2M U141 ( .AN(ALU_EN), .B(n24), .Y(CLK_EN) );
  DLY1X1M U142 ( .A(RX_D_VLD), .Y(n112) );
  INVXLM U143 ( .A(n58), .Y(n113) );
  SDFFRQX2M Temp_Address_reg_3_ ( .D(n82), .SI(n96), .SE(test_se), .CK(CLK), 
        .RN(n42), .Q(Temp_Address[3]) );
  SDFFRQX2M Temp_Address_reg_2_ ( .D(n80), .SI(n97), .SE(test_se), .CK(CLK), 
        .RN(n42), .Q(Temp_Address[2]) );
  SDFFRQX2M Temp_Address_reg_1_ ( .D(n78), .SI(n98), .SE(test_se), .CK(CLK), 
        .RN(n42), .Q(Temp_Address[1]) );
  SDFFRQX2M Temp_Address_reg_0_ ( .D(n76), .SI(n93), .SE(test_se), .CK(CLK), 
        .RN(n42), .Q(Temp_Address[0]) );
  SDFFRQX2M Current_State_reg_3_ ( .D(Next_State[3]), .SI(Current_State[2]), 
        .SE(test_se), .CK(CLK), .RN(n42), .Q(Current_State[3]) );
  INVX2M U3 ( .A(1'b0), .Y(clk_div_en) );
endmodule


module RegFile_test_1 ( CLK, RST, RdEn, WrEn, Address, WrData, RdData, 
        RdData_VLD, REG0, REG1, REG2, REG3, test_si3, test_si2, test_si1, 
        test_so2, test_so1, test_se );
  input [3:0] Address;
  input [7:0] WrData;
  output [7:0] RdData;
  output [7:0] REG0;
  output [7:0] REG1;
  output [7:0] REG2;
  output [7:0] REG3;
  input CLK, RST, RdEn, WrEn, test_si3, test_si2, test_si1, test_se;
  output RdData_VLD, test_so2, test_so1;
  wire   n560, n561, n562, n563, n564, n565, n566, n3, n567, n568, n569, n570,
         regArr_4__7_, regArr_4__6_, regArr_4__5_, regArr_4__4_, regArr_4__3_,
         regArr_4__2_, regArr_4__1_, regArr_4__0_, regArr_5__7_, regArr_5__6_,
         regArr_5__5_, regArr_5__4_, regArr_5__3_, regArr_5__2_, regArr_5__1_,
         regArr_5__0_, regArr_6__7_, regArr_6__6_, regArr_6__5_, regArr_6__4_,
         regArr_6__3_, regArr_6__2_, regArr_6__1_, regArr_6__0_, regArr_7__7_,
         regArr_7__6_, regArr_7__5_, regArr_7__4_, regArr_7__3_, regArr_7__2_,
         regArr_7__1_, regArr_7__0_, regArr_8__7_, regArr_8__6_, regArr_8__5_,
         regArr_8__4_, regArr_8__3_, regArr_8__2_, regArr_8__1_, regArr_8__0_,
         regArr_9__7_, regArr_9__6_, regArr_9__5_, regArr_9__4_, regArr_9__3_,
         regArr_9__2_, regArr_9__1_, regArr_9__0_, regArr_10__7_,
         regArr_10__6_, regArr_10__5_, regArr_10__4_, regArr_10__3_,
         regArr_10__2_, regArr_10__1_, regArr_10__0_, regArr_11__7_,
         regArr_11__6_, regArr_11__5_, regArr_11__4_, regArr_11__3_,
         regArr_11__2_, regArr_11__1_, regArr_11__0_, regArr_12__7_,
         regArr_12__6_, regArr_12__5_, regArr_12__4_, regArr_12__3_,
         regArr_12__2_, regArr_12__1_, regArr_12__0_, regArr_13__7_,
         regArr_13__6_, regArr_13__5_, regArr_13__4_, regArr_13__3_,
         regArr_13__2_, regArr_13__1_, regArr_13__0_, regArr_14__7_,
         regArr_14__6_, regArr_14__5_, regArr_14__3_, regArr_14__2_,
         regArr_14__1_, regArr_14__0_, regArr_15__7_, regArr_15__6_,
         regArr_15__5_, regArr_15__4_, regArr_15__3_, regArr_15__2_,
         regArr_15__1_, regArr_15__0_, N36, N37, N38, N39, N40, N41, N42, N43,
         n150, n151, n152, n153, n154, n155, n156, n157, n158, n159, n160,
         n161, n162, n163, n164, n165, n166, n167, n168, n169, n170, n171,
         n172, n173, n174, n175, n176, n177, n178, n179, n180, n181, n182,
         n183, n184, n185, n186, n187, n188, n189, n190, n191, n192, n193,
         n194, n195, n196, n197, n198, n199, n200, n201, n202, n203, n204,
         n205, n206, n207, n208, n209, n210, n211, n212, n213, n214, n215,
         n216, n217, n218, n219, n220, n221, n222, n223, n224, n225, n226,
         n227, n228, n229, n230, n231, n232, n233, n234, n235, n236, n237,
         n238, n239, n240, n241, n242, n243, n244, n245, n246, n247, n248,
         n249, n250, n251, n252, n253, n254, n255, n256, n257, n258, n259,
         n260, n261, n262, n263, n264, n265, n266, n267, n268, n269, n270,
         n271, n272, n273, n274, n275, n276, n277, n278, n279, n280, n281,
         n282, n283, n284, n285, n286, n287, n288, n289, n290, n291, n292,
         n293, n294, n295, n296, n297, n298, n299, n300, n301, n302, n303,
         n304, n305, n306, n307, n308, n309, n310, n311, n312, n313, n314,
         n138, n140, n142, n144, n146, n148, n315, n317, n319, n321, n461,
         n462, n463, n464, n465, n466, n467, n468, n469, n470, n471, n472,
         n473, n474, n475, n476, n477, n478, n479, n480, n481, n482, n483,
         n484, n485, n486, n487, n488, n489, n490, n491, n492, n493, n494,
         n495, n496, n497, n498, n499, n500, n501, n502, n503, n504, n505,
         n506, n507, n508, n509, n510, n511, n512, n513, n514, n515, n516,
         n517, n518, n519, n520, n521, n522, n523, n524, n525, n526, n527,
         n528, n529, n530, n531, n532, n533, n534, n535, n536, n537, n538,
         n539, n540, n541, n542, n543, n544, n545, n546, n547, n548, n549,
         n550, n551, n552, n553, n554, n555, n556, n557, n558, n559, n575,
         n576, n577, n578, n579, n580, n581, n582, n583, n584, n585, n586,
         n587, n588, n589, n590, n591, n592, n593, n594, n595, n596, n597,
         n598, n599, n600, n601, n602, n603, n604, n605, n606, n607, n608,
         n609, n610, n611, n612, n613, n614, n615, n616, n617, n618, n619,
         n620, n621, n622, n623, n624, n625, n626, n627, n628, n629, n630,
         n631, n632, n633, n634, n635, n636, n637, n638, n639, n640, n641,
         n642, n643, n644, n645, n646, n647, n648, n649, n650, n651, n652,
         n653, n654, n655, n656, n658, n659, n660, n661, n662, n663, n664,
         n665, n666, n667, n668, n669, n670, n671, n672, n673, n674, n675,
         n676, n677, n678, n679, n680, n681, n682, n1;

  SDFFSQX2M regArr_reg_2__5_ ( .D(n296), .SI(REG2[4]), .SE(test_se), .CK(CLK), 
        .SN(RST), .Q(n567) );
  SDFFRQX1M regArr_reg_11__7_ ( .D(n226), .SI(n655), .SE(test_se), .CK(CLK), 
        .RN(n539), .Q(regArr_11__7_) );
  SDFFRQX1M regArr_reg_11__6_ ( .D(n225), .SI(n654), .SE(test_se), .CK(CLK), 
        .RN(n539), .Q(regArr_11__6_) );
  SDFFRQX1M regArr_reg_11__5_ ( .D(n224), .SI(n653), .SE(test_se), .CK(CLK), 
        .RN(n539), .Q(regArr_11__5_) );
  SDFFRQX1M regArr_reg_11__4_ ( .D(n223), .SI(n652), .SE(test_se), .CK(CLK), 
        .RN(n539), .Q(regArr_11__4_) );
  SDFFRQX1M regArr_reg_11__3_ ( .D(n222), .SI(n651), .SE(test_se), .CK(CLK), 
        .RN(n539), .Q(regArr_11__3_) );
  SDFFRQX1M regArr_reg_11__2_ ( .D(n221), .SI(n650), .SE(test_se), .CK(CLK), 
        .RN(n539), .Q(regArr_11__2_) );
  SDFFRQX1M regArr_reg_11__1_ ( .D(n220), .SI(n642), .SE(test_se), .CK(CLK), 
        .RN(n539), .Q(regArr_11__1_) );
  SDFFRQX1M regArr_reg_9__7_ ( .D(n242), .SI(n625), .SE(test_se), .CK(CLK), 
        .RN(n541), .Q(regArr_9__7_) );
  SDFFRQX1M regArr_reg_9__6_ ( .D(n241), .SI(n624), .SE(test_se), .CK(CLK), 
        .RN(n541), .Q(regArr_9__6_) );
  SDFFRQX1M regArr_reg_9__5_ ( .D(n240), .SI(n623), .SE(test_se), .CK(CLK), 
        .RN(n541), .Q(regArr_9__5_) );
  SDFFRQX1M regArr_reg_9__4_ ( .D(n239), .SI(n622), .SE(test_se), .CK(CLK), 
        .RN(n540), .Q(regArr_9__4_) );
  SDFFRQX1M regArr_reg_9__3_ ( .D(n238), .SI(n621), .SE(test_se), .CK(CLK), 
        .RN(n540), .Q(regArr_9__3_) );
  SDFFRQX1M regArr_reg_9__2_ ( .D(n237), .SI(n620), .SE(test_se), .CK(CLK), 
        .RN(n540), .Q(regArr_9__2_) );
  SDFFRQX1M regArr_reg_9__1_ ( .D(n236), .SI(n618), .SE(test_se), .CK(CLK), 
        .RN(n540), .Q(regArr_9__1_) );
  SDFFRQX1M regArr_reg_10__7_ ( .D(n234), .SI(n608), .SE(test_se), .CK(CLK), 
        .RN(n540), .Q(regArr_10__7_) );
  SDFFRQX1M regArr_reg_10__6_ ( .D(n233), .SI(n607), .SE(test_se), .CK(CLK), 
        .RN(n540), .Q(regArr_10__6_) );
  SDFFRQX1M regArr_reg_10__5_ ( .D(n232), .SI(n606), .SE(test_se), .CK(CLK), 
        .RN(n540), .Q(regArr_10__5_) );
  SDFFRQX1M regArr_reg_10__4_ ( .D(n231), .SI(n605), .SE(test_se), .CK(CLK), 
        .RN(n540), .Q(regArr_10__4_) );
  SDFFRQX1M regArr_reg_10__3_ ( .D(n230), .SI(n604), .SE(test_se), .CK(CLK), 
        .RN(n540), .Q(regArr_10__3_) );
  SDFFRQX1M regArr_reg_10__2_ ( .D(n229), .SI(n603), .SE(test_se), .CK(CLK), 
        .RN(n540), .Q(regArr_10__2_) );
  SDFFRQX1M regArr_reg_10__1_ ( .D(n228), .SI(n602), .SE(test_se), .CK(CLK), 
        .RN(n540), .Q(regArr_10__1_) );
  SDFFRQX1M regArr_reg_8__7_ ( .D(n250), .SI(n673), .SE(test_se), .CK(CLK), 
        .RN(n541), .Q(regArr_8__7_) );
  SDFFRQX1M regArr_reg_8__6_ ( .D(n249), .SI(n672), .SE(test_se), .CK(CLK), 
        .RN(n541), .Q(regArr_8__6_) );
  SDFFRQX1M regArr_reg_8__5_ ( .D(n248), .SI(n671), .SE(test_se), .CK(CLK), 
        .RN(n541), .Q(regArr_8__5_) );
  SDFFRQX1M regArr_reg_8__4_ ( .D(n247), .SI(n670), .SE(test_se), .CK(CLK), 
        .RN(n541), .Q(regArr_8__4_) );
  SDFFRQX1M regArr_reg_8__3_ ( .D(n246), .SI(n669), .SE(test_se), .CK(CLK), 
        .RN(n541), .Q(regArr_8__3_) );
  SDFFRQX1M regArr_reg_8__2_ ( .D(n245), .SI(n668), .SE(test_se), .CK(CLK), 
        .RN(n541), .Q(regArr_8__2_) );
  SDFFRQX1M regArr_reg_8__1_ ( .D(n244), .SI(n666), .SE(test_se), .CK(CLK), 
        .RN(n541), .Q(regArr_8__1_) );
  SDFFRQX1M regArr_reg_11__0_ ( .D(n219), .SI(n609), .SE(test_se), .CK(CLK), 
        .RN(n539), .Q(regArr_11__0_) );
  SDFFRQX1M regArr_reg_9__0_ ( .D(n235), .SI(n674), .SE(test_se), .CK(CLK), 
        .RN(n540), .Q(regArr_9__0_) );
  SDFFRQX1M regArr_reg_10__0_ ( .D(n227), .SI(n626), .SE(test_se), .CK(CLK), 
        .RN(n540), .Q(regArr_10__0_) );
  SDFFRQX1M regArr_reg_8__0_ ( .D(n243), .SI(n641), .SE(test_se), .CK(CLK), 
        .RN(n541), .Q(regArr_8__0_) );
  SDFFRQX1M RdData_reg_7_ ( .D(n185), .SI(n579), .SE(test_se), .CK(CLK), .RN(
        n542), .Q(RdData[7]) );
  SDFFRQX1M RdData_reg_5_ ( .D(n183), .SI(n581), .SE(test_se), .CK(CLK), .RN(
        n541), .Q(RdData[5]) );
  SDFFRQX1M RdData_reg_1_ ( .D(n179), .SI(n582), .SE(test_se), .CK(CLK), .RN(
        n537), .Q(RdData[1]) );
  SDFFRQX1M RdData_reg_0_ ( .D(n178), .SI(n577), .SE(test_se), .CK(CLK), .RN(
        n541), .Q(RdData[0]) );
  SDFFRQX1M regArr_reg_7__7_ ( .D(n258), .SI(n640), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(regArr_7__7_) );
  SDFFRQX1M regArr_reg_7__6_ ( .D(n257), .SI(n639), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(regArr_7__6_) );
  SDFFRQX1M regArr_reg_7__5_ ( .D(n256), .SI(n638), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(regArr_7__5_) );
  SDFFRQX1M regArr_reg_7__4_ ( .D(n255), .SI(n637), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(regArr_7__4_) );
  SDFFRQX1M regArr_reg_7__3_ ( .D(n254), .SI(n636), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(regArr_7__3_) );
  SDFFRQX1M regArr_reg_7__2_ ( .D(n253), .SI(n635), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(regArr_7__2_) );
  SDFFRQX1M regArr_reg_7__1_ ( .D(n252), .SI(n634), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(regArr_7__1_) );
  SDFFRQX1M regArr_reg_6__7_ ( .D(n266), .SI(n593), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_6__7_) );
  SDFFRQX1M regArr_reg_6__6_ ( .D(n265), .SI(n592), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_6__6_) );
  SDFFRQX1M regArr_reg_6__5_ ( .D(n264), .SI(n591), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(regArr_6__5_) );
  SDFFRQX1M regArr_reg_6__4_ ( .D(n263), .SI(n590), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(regArr_6__4_) );
  SDFFRQX1M regArr_reg_6__3_ ( .D(n262), .SI(n589), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(regArr_6__3_) );
  SDFFRQX1M regArr_reg_6__2_ ( .D(n261), .SI(n588), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(regArr_6__2_) );
  SDFFRQX1M regArr_reg_6__1_ ( .D(n260), .SI(n587), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(regArr_6__1_) );
  SDFFRQX1M regArr_reg_5__7_ ( .D(n274), .SI(n616), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_5__7_) );
  SDFFRQX1M regArr_reg_5__6_ ( .D(n273), .SI(n615), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_5__6_) );
  SDFFRQX1M regArr_reg_5__5_ ( .D(n272), .SI(n614), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_5__5_) );
  SDFFRQX1M regArr_reg_5__4_ ( .D(n271), .SI(n613), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_5__4_) );
  SDFFRQX1M regArr_reg_5__3_ ( .D(n270), .SI(n612), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_5__3_) );
  SDFFRQX1M regArr_reg_5__2_ ( .D(n269), .SI(n611), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_5__2_) );
  SDFFRQX1M regArr_reg_5__1_ ( .D(n268), .SI(n610), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_5__1_) );
  SDFFRQX1M regArr_reg_4__7_ ( .D(n282), .SI(n664), .SE(test_se), .CK(CLK), 
        .RN(n546), .Q(regArr_4__7_) );
  SDFFRQX1M regArr_reg_4__6_ ( .D(n281), .SI(n663), .SE(test_se), .CK(CLK), 
        .RN(n544), .Q(regArr_4__6_) );
  SDFFRQX1M regArr_reg_4__5_ ( .D(n280), .SI(n662), .SE(test_se), .CK(CLK), 
        .RN(n546), .Q(regArr_4__5_) );
  SDFFRQX1M regArr_reg_4__4_ ( .D(n279), .SI(n661), .SE(test_se), .CK(CLK), 
        .RN(n544), .Q(regArr_4__4_) );
  SDFFRQX1M regArr_reg_4__3_ ( .D(n278), .SI(n660), .SE(test_se), .CK(CLK), 
        .RN(n546), .Q(regArr_4__3_) );
  SDFFRQX1M regArr_reg_4__2_ ( .D(n277), .SI(n659), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_4__2_) );
  SDFFRQX1M regArr_reg_4__1_ ( .D(n276), .SI(n658), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_4__1_) );
  SDFFRQX1M regArr_reg_2__3_ ( .D(n294), .SI(REG2[2]), .SE(test_se), .CK(CLK), 
        .RN(n545), .Q(n569) );
  SDFFRQX1M regArr_reg_7__0_ ( .D(n251), .SI(n594), .SE(test_se), .CK(CLK), 
        .RN(n541), .Q(regArr_7__0_) );
  SDFFRQX1M regArr_reg_6__0_ ( .D(n259), .SI(n617), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(regArr_6__0_) );
  SDFFRQX1M regArr_reg_5__0_ ( .D(n267), .SI(n665), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_5__0_) );
  SDFFRQX1M regArr_reg_4__0_ ( .D(n275), .SI(REG3[7]), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_4__0_) );
  SDFFRQX1M RdData_reg_4_ ( .D(n182), .SI(n578), .SE(test_se), .CK(CLK), .RN(
        n538), .Q(RdData[4]) );
  SDFFRQX1M RdData_reg_2_ ( .D(n180), .SI(n583), .SE(test_se), .CK(CLK), .RN(
        n537), .Q(RdData[2]) );
  SDFFRQX1M RdData_reg_6_ ( .D(n184), .SI(n584), .SE(test_se), .CK(CLK), .RN(
        n538), .Q(RdData[6]) );
  SDFFRQX1M RdData_reg_3_ ( .D(n181), .SI(n580), .SE(test_se), .CK(CLK), .RN(
        n549), .Q(RdData[3]) );
  SDFFRQX1M regArr_reg_2__7_ ( .D(n298), .SI(REG2[6]), .SE(test_se), .CK(CLK), 
        .RN(n545), .Q(n566) );
  SDFFRQX1M regArr_reg_2__2_ ( .D(n293), .SI(n576), .SE(test_se), .CK(CLK), 
        .RN(n545), .Q(n570) );
  SDFFRQX1M regArr_reg_2__4_ ( .D(n295), .SI(REG2[3]), .SE(test_se), .CK(CLK), 
        .RN(n545), .Q(n568) );
  SDFFRQX1M regArr_reg_1__7_ ( .D(n306), .SI(REG1[6]), .SE(test_se), .CK(CLK), 
        .RN(n545), .Q(n560) );
  SDFFRQX1M regArr_reg_1__0_ ( .D(n299), .SI(REG0[7]), .SE(test_se), .CK(CLK), 
        .RN(n545), .Q(n565) );
  SDFFRQX1M regArr_reg_1__5_ ( .D(n304), .SI(REG1[4]), .SE(test_se), .CK(CLK), 
        .RN(n545), .Q(n561) );
  SDFFRQX1M regArr_reg_1__4_ ( .D(n303), .SI(REG1[3]), .SE(test_se), .CK(CLK), 
        .RN(n545), .Q(n562) );
  SDFFRQX1M regArr_reg_1__1_ ( .D(n300), .SI(REG1[0]), .SE(test_se), .CK(CLK), 
        .RN(n545), .Q(n564) );
  SDFFRQX4M regArr_reg_1__2_ ( .D(n301), .SI(REG1[1]), .SE(test_se), .CK(CLK), 
        .RN(n545), .Q(REG1[2]) );
  SDFFRQX1M regArr_reg_1__3_ ( .D(n302), .SI(REG1[2]), .SE(test_se), .CK(CLK), 
        .RN(n545), .Q(n563) );
  SDFFRQX4M regArr_reg_3__1_ ( .D(n284), .SI(n575), .SE(test_se), .CK(CLK), 
        .RN(n544), .Q(REG3[1]) );
  SDFFRQX2M RdData_VLD_reg ( .D(n186), .SI(test_si1), .SE(test_se), .CK(CLK), 
        .RN(n542), .Q(RdData_VLD) );
  SDFFRQX2M regArr_reg_2__1_ ( .D(n292), .SI(REG2[0]), .SE(test_se), .CK(CLK), 
        .RN(n546), .Q(REG2[1]) );
  SDFFRQX2M regArr_reg_3__0_ ( .D(n283), .SI(REG2[7]), .SE(test_se), .CK(CLK), 
        .RN(n544), .Q(REG3[0]) );
  SDFFRQX4M regArr_reg_3__4_ ( .D(n287), .SI(REG3[3]), .SE(test_se), .CK(CLK), 
        .RN(n544), .Q(REG3[4]) );
  SDFFSQX4M regArr_reg_2__0_ ( .D(n291), .SI(REG1[7]), .SE(test_se), .CK(CLK), 
        .SN(n537), .Q(REG2[0]) );
  SDFFRQX4M regArr_reg_3__6_ ( .D(n289), .SI(n682), .SE(test_se), .CK(CLK), 
        .RN(n544), .Q(REG3[6]) );
  SDFFRQX4M regArr_reg_3__3_ ( .D(n286), .SI(test_si2), .SE(test_se), .CK(CLK), 
        .RN(n544), .Q(REG3[3]) );
  SDFFRQX4M regArr_reg_3__2_ ( .D(n285), .SI(REG3[1]), .SE(test_se), .CK(CLK), 
        .RN(n544), .Q(REG3[2]) );
  SDFFRQX2M regArr_reg_0__7_ ( .D(n314), .SI(REG0[6]), .SE(test_se), .CK(CLK), 
        .RN(n541), .Q(REG0[7]) );
  SDFFRQX2M regArr_reg_0__5_ ( .D(n312), .SI(REG0[4]), .SE(test_se), .CK(CLK), 
        .RN(n546), .Q(REG0[5]) );
  SDFFRQX2M regArr_reg_0__4_ ( .D(n311), .SI(REG0[3]), .SE(test_se), .CK(CLK), 
        .RN(n544), .Q(REG0[4]) );
  SDFFRQX2M regArr_reg_0__0_ ( .D(n307), .SI(n585), .SE(test_se), .CK(CLK), 
        .RN(n546), .Q(REG0[0]) );
  SDFFRQX4M regArr_reg_3__7_ ( .D(n290), .SI(REG3[6]), .SE(test_se), .CK(CLK), 
        .RN(n544), .Q(REG3[7]) );
  SDFFRQX2M regArr_reg_0__3_ ( .D(n310), .SI(REG0[2]), .SE(test_se), .CK(CLK), 
        .RN(n544), .Q(REG0[3]) );
  SDFFRQX2M regArr_reg_0__2_ ( .D(n309), .SI(REG0[1]), .SE(test_se), .CK(CLK), 
        .RN(n546), .Q(REG0[2]) );
  SDFFRQX2M regArr_reg_1__6_ ( .D(n305), .SI(REG1[5]), .SE(test_se), .CK(CLK), 
        .RN(n545), .Q(REG1[6]) );
  SDFFRQX2M regArr_reg_0__1_ ( .D(n308), .SI(REG0[0]), .SE(test_se), .CK(CLK), 
        .RN(n546), .Q(REG0[1]) );
  SDFFRQX2M regArr_reg_0__6_ ( .D(n313), .SI(REG0[5]), .SE(test_se), .CK(CLK), 
        .RN(n544), .Q(REG0[6]) );
  INVX4M U140 ( .A(n138), .Y(REG1[3]) );
  MX4XLM U141 ( .A(REG0[5]), .B(REG1[5]), .C(REG2[5]), .D(REG3[5]), .S0(n499), 
        .S1(n496), .Y(n484) );
  MX4XLM U142 ( .A(REG0[7]), .B(REG1[7]), .C(REG2[7]), .D(REG3[7]), .S0(n499), 
        .S1(n495), .Y(n492) );
  MX4XLM U143 ( .A(REG0[0]), .B(REG1[0]), .C(REG2[0]), .D(REG3[0]), .S0(n497), 
        .S1(n495), .Y(n464) );
  MX4XLM U144 ( .A(REG0[1]), .B(REG1[1]), .C(REG2[1]), .D(REG3[1]), .S0(n497), 
        .S1(n496), .Y(n468) );
  INVXLM U145 ( .A(n563), .Y(n138) );
  MX4XLM U146 ( .A(REG0[2]), .B(REG1[2]), .C(REG2[2]), .D(REG3[2]), .S0(n498), 
        .S1(n496), .Y(n472) );
  INVXLM U147 ( .A(n564), .Y(n140) );
  INVX6M U148 ( .A(n140), .Y(REG1[1]) );
  INVXLM U149 ( .A(n562), .Y(n142) );
  INVX6M U150 ( .A(n142), .Y(REG1[4]) );
  INVXLM U151 ( .A(n561), .Y(n144) );
  INVX6M U152 ( .A(n144), .Y(REG1[5]) );
  INVXLM U153 ( .A(n565), .Y(n146) );
  INVX6M U154 ( .A(n146), .Y(REG1[0]) );
  INVXLM U155 ( .A(n560), .Y(n148) );
  INVX6M U156 ( .A(n148), .Y(REG1[7]) );
  INVXLM U157 ( .A(n568), .Y(n315) );
  INVX6M U158 ( .A(n315), .Y(REG2[4]) );
  INVXLM U159 ( .A(n570), .Y(n317) );
  INVX6M U160 ( .A(n317), .Y(REG2[2]) );
  INVXLM U161 ( .A(n566), .Y(n319) );
  INVX8M U162 ( .A(n319), .Y(REG2[7]) );
  INVXLM U163 ( .A(n567), .Y(n321) );
  INVX8M U164 ( .A(n321), .Y(REG2[5]) );
  BUFX10M U302 ( .A(n569), .Y(REG2[3]) );
  CLKINVX1M U303 ( .A(Address[2]), .Y(n550) );
  NOR2BX4M U304 ( .AN(n176), .B(n533), .Y(n170) );
  NOR2BX4M U305 ( .AN(n165), .B(n533), .Y(n156) );
  NOR2X4M U306 ( .A(n550), .B(n535), .Y(n158) );
  NOR2BX4M U307 ( .AN(n176), .B(n534), .Y(n168) );
  NOR2BX4M U308 ( .AN(n165), .B(n534), .Y(n154) );
  NOR2X4M U309 ( .A(n550), .B(n536), .Y(n153) );
  NOR2X4M U310 ( .A(n536), .B(Address[2]), .Y(n161) );
  NOR2X4M U311 ( .A(n535), .B(Address[2]), .Y(n164) );
  INVX2M U312 ( .A(Address[0]), .Y(n534) );
  INVX2M U313 ( .A(Address[1]), .Y(n536) );
  BUFX4M U314 ( .A(n159), .Y(n525) );
  BUFX4M U315 ( .A(n172), .Y(n509) );
  BUFX4M U316 ( .A(n159), .Y(n524) );
  BUFX4M U317 ( .A(n172), .Y(n508) );
  CLKBUFX8M U318 ( .A(n533), .Y(n498) );
  CLKBUFX8M U319 ( .A(n494), .Y(n496) );
  CLKBUFX6M U320 ( .A(Address[0]), .Y(n497) );
  BUFX4M U321 ( .A(n494), .Y(n495) );
  NAND2X2M U322 ( .A(n170), .B(n158), .Y(n172) );
  NAND2X2M U323 ( .A(n158), .B(n156), .Y(n159) );
  BUFX4M U324 ( .A(n160), .Y(n523) );
  BUFX4M U325 ( .A(n162), .Y(n521) );
  BUFX4M U326 ( .A(n163), .Y(n519) );
  BUFX4M U327 ( .A(n166), .Y(n517) );
  BUFX4M U328 ( .A(n155), .Y(n529) );
  BUFX4M U329 ( .A(n157), .Y(n527) );
  BUFX4M U330 ( .A(n167), .Y(n515) );
  BUFX4M U331 ( .A(n169), .Y(n513) );
  BUFX4M U332 ( .A(n171), .Y(n511) );
  BUFX4M U333 ( .A(n152), .Y(n531) );
  BUFX4M U334 ( .A(n160), .Y(n522) );
  BUFX4M U335 ( .A(n162), .Y(n520) );
  BUFX4M U336 ( .A(n163), .Y(n518) );
  BUFX4M U337 ( .A(n166), .Y(n516) );
  BUFX4M U338 ( .A(n155), .Y(n528) );
  BUFX4M U339 ( .A(n157), .Y(n526) );
  BUFX4M U340 ( .A(n167), .Y(n514) );
  BUFX4M U341 ( .A(n169), .Y(n512) );
  BUFX4M U342 ( .A(n171), .Y(n510) );
  BUFX4M U343 ( .A(n152), .Y(n530) );
  CLKBUFX8M U344 ( .A(n533), .Y(n499) );
  BUFX4M U345 ( .A(n173), .Y(n507) );
  BUFX4M U346 ( .A(n174), .Y(n505) );
  BUFX4M U347 ( .A(n175), .Y(n503) );
  BUFX4M U348 ( .A(n177), .Y(n501) );
  BUFX4M U349 ( .A(n173), .Y(n506) );
  BUFX4M U350 ( .A(n174), .Y(n504) );
  BUFX4M U351 ( .A(n175), .Y(n502) );
  BUFX4M U352 ( .A(n177), .Y(n500) );
  BUFX2M U353 ( .A(n493), .Y(n494) );
  CLKBUFX8M U354 ( .A(n549), .Y(n538) );
  CLKBUFX8M U355 ( .A(n547), .Y(n539) );
  CLKBUFX8M U356 ( .A(n539), .Y(n540) );
  CLKBUFX8M U357 ( .A(n548), .Y(n541) );
  CLKBUFX8M U358 ( .A(n548), .Y(n542) );
  CLKBUFX8M U359 ( .A(n548), .Y(n543) );
  CLKBUFX8M U360 ( .A(n547), .Y(n544) );
  BUFX6M U361 ( .A(n547), .Y(n545) );
  BUFX4M U363 ( .A(n547), .Y(n546) );
  NAND2X2M U364 ( .A(n161), .B(n154), .Y(n160) );
  NAND2X2M U365 ( .A(n161), .B(n156), .Y(n162) );
  NAND2X2M U366 ( .A(n164), .B(n154), .Y(n163) );
  NAND2X2M U367 ( .A(n164), .B(n156), .Y(n166) );
  NAND2X2M U368 ( .A(n156), .B(n153), .Y(n155) );
  NAND2X2M U369 ( .A(n168), .B(n153), .Y(n167) );
  NAND2X2M U370 ( .A(n170), .B(n153), .Y(n169) );
  NAND2X2M U371 ( .A(n168), .B(n158), .Y(n171) );
  NAND2X2M U372 ( .A(n153), .B(n154), .Y(n152) );
  NAND2X2M U373 ( .A(n158), .B(n154), .Y(n157) );
  NAND2X2M U374 ( .A(n168), .B(n161), .Y(n173) );
  NAND2X2M U375 ( .A(n170), .B(n161), .Y(n174) );
  NAND2X2M U376 ( .A(n168), .B(n164), .Y(n175) );
  NAND2X2M U377 ( .A(n170), .B(n164), .Y(n177) );
  BUFX2M U378 ( .A(n535), .Y(n493) );
  INVX4M U379 ( .A(n532), .Y(n559) );
  BUFX2M U380 ( .A(n549), .Y(n548) );
  BUFX2M U381 ( .A(n548), .Y(n547) );
  AND2X1M U382 ( .A(Address[3]), .B(n151), .Y(n165) );
  NOR2BX2M U383 ( .AN(n151), .B(Address[3]), .Y(n176) );
  INVX2M U384 ( .A(n534), .Y(n533) );
  INVX2M U385 ( .A(n536), .Y(n535) );
  NOR2BX4M U386 ( .AN(WrEn), .B(RdEn), .Y(n151) );
  CLKBUFX6M U387 ( .A(n150), .Y(n532) );
  NAND2BX2M U388 ( .AN(WrEn), .B(RdEn), .Y(n150) );
  INVX8M U389 ( .A(WrData[0]), .Y(n551) );
  INVX8M U390 ( .A(WrData[3]), .Y(n554) );
  INVX8M U391 ( .A(WrData[1]), .Y(n552) );
  INVX8M U392 ( .A(WrData[2]), .Y(n553) );
  INVX8M U393 ( .A(WrData[4]), .Y(n555) );
  INVX8M U394 ( .A(WrData[5]), .Y(n556) );
  INVX8M U395 ( .A(WrData[6]), .Y(n557) );
  INVX8M U396 ( .A(WrData[7]), .Y(n558) );
  BUFX2M U397 ( .A(RST), .Y(n549) );
  OAI2BB2X1M U398 ( .B0(n531), .B1(n551), .A0N(n643), .A1N(n531), .Y(n187) );
  OAI2BB2X1M U399 ( .B0(n530), .B1(n554), .A0N(n646), .A1N(n531), .Y(n190) );
  OAI2BB2X1M U400 ( .B0(n530), .B1(n552), .A0N(n644), .A1N(n531), .Y(n188) );
  OAI2BB2X1M U401 ( .B0(n530), .B1(n553), .A0N(n645), .A1N(n531), .Y(n189) );
  OAI2BB2X1M U402 ( .B0(n530), .B1(n555), .A0N(n647), .A1N(n531), .Y(n191) );
  OAI2BB2X1M U403 ( .B0(n530), .B1(n556), .A0N(n648), .A1N(n531), .Y(n192) );
  OAI2BB2X1M U404 ( .B0(n530), .B1(n557), .A0N(n649), .A1N(n531), .Y(n193) );
  OAI2BB2X1M U405 ( .B0(n530), .B1(n558), .A0N(test_so2), .A1N(n531), .Y(n194)
         );
  OAI2BB2X1M U406 ( .B0(n551), .B1(n529), .A0N(n595), .A1N(n529), .Y(n195) );
  OAI2BB2X1M U407 ( .B0(n551), .B1(n527), .A0N(n619), .A1N(n527), .Y(n203) );
  OAI2BB2X1M U408 ( .B0(n551), .B1(n525), .A0N(n667), .A1N(n525), .Y(n211) );
  OAI2BB2X1M U409 ( .B0(n551), .B1(n523), .A0N(n642), .A1N(n523), .Y(n219) );
  OAI2BB2X1M U410 ( .B0(n551), .B1(n521), .A0N(n602), .A1N(n521), .Y(n227) );
  OAI2BB2X1M U411 ( .B0(n551), .B1(n519), .A0N(n618), .A1N(n519), .Y(n235) );
  OAI2BB2X1M U412 ( .B0(n551), .B1(n517), .A0N(n666), .A1N(n517), .Y(n243) );
  OAI2BB2X1M U413 ( .B0(n551), .B1(n515), .A0N(n634), .A1N(n515), .Y(n251) );
  OAI2BB2X1M U414 ( .B0(n551), .B1(n513), .A0N(n587), .A1N(n513), .Y(n259) );
  OAI2BB2X1M U415 ( .B0(n551), .B1(n511), .A0N(n610), .A1N(n511), .Y(n267) );
  OAI2BB2X1M U416 ( .B0(n551), .B1(n509), .A0N(n658), .A1N(n509), .Y(n275) );
  OAI2BB2X1M U417 ( .B0(n554), .B1(n528), .A0N(n598), .A1N(n529), .Y(n198) );
  OAI2BB2X1M U418 ( .B0(n554), .B1(n526), .A0N(n629), .A1N(n527), .Y(n206) );
  OAI2BB2X1M U419 ( .B0(n554), .B1(n524), .A0N(n677), .A1N(n525), .Y(n214) );
  OAI2BB2X1M U420 ( .B0(n554), .B1(n522), .A0N(n652), .A1N(n523), .Y(n222) );
  OAI2BB2X1M U421 ( .B0(n554), .B1(n520), .A0N(n605), .A1N(n521), .Y(n230) );
  OAI2BB2X1M U422 ( .B0(n554), .B1(n518), .A0N(n622), .A1N(n519), .Y(n238) );
  OAI2BB2X1M U423 ( .B0(n554), .B1(n516), .A0N(n670), .A1N(n517), .Y(n246) );
  OAI2BB2X1M U424 ( .B0(n554), .B1(n514), .A0N(n637), .A1N(n515), .Y(n254) );
  OAI2BB2X1M U425 ( .B0(n554), .B1(n512), .A0N(n590), .A1N(n513), .Y(n262) );
  OAI2BB2X1M U426 ( .B0(n554), .B1(n510), .A0N(n613), .A1N(n511), .Y(n270) );
  OAI2BB2X1M U427 ( .B0(n554), .B1(n508), .A0N(n661), .A1N(n509), .Y(n278) );
  OAI2BB2X1M U428 ( .B0(n552), .B1(n528), .A0N(n596), .A1N(n529), .Y(n196) );
  OAI2BB2X1M U429 ( .B0(n553), .B1(n528), .A0N(n597), .A1N(n529), .Y(n197) );
  OAI2BB2X1M U430 ( .B0(n552), .B1(n526), .A0N(n627), .A1N(n527), .Y(n204) );
  OAI2BB2X1M U431 ( .B0(n553), .B1(n526), .A0N(n628), .A1N(n527), .Y(n205) );
  OAI2BB2X1M U432 ( .B0(n552), .B1(n524), .A0N(n675), .A1N(n525), .Y(n212) );
  OAI2BB2X1M U433 ( .B0(n553), .B1(n524), .A0N(n676), .A1N(n525), .Y(n213) );
  OAI2BB2X1M U434 ( .B0(n552), .B1(n522), .A0N(n650), .A1N(n523), .Y(n220) );
  OAI2BB2X1M U435 ( .B0(n553), .B1(n522), .A0N(n651), .A1N(n523), .Y(n221) );
  OAI2BB2X1M U436 ( .B0(n552), .B1(n520), .A0N(n603), .A1N(n521), .Y(n228) );
  OAI2BB2X1M U437 ( .B0(n553), .B1(n520), .A0N(n604), .A1N(n521), .Y(n229) );
  OAI2BB2X1M U438 ( .B0(n552), .B1(n518), .A0N(n620), .A1N(n519), .Y(n236) );
  OAI2BB2X1M U439 ( .B0(n553), .B1(n518), .A0N(n621), .A1N(n519), .Y(n237) );
  OAI2BB2X1M U440 ( .B0(n552), .B1(n516), .A0N(n668), .A1N(n517), .Y(n244) );
  OAI2BB2X1M U441 ( .B0(n553), .B1(n516), .A0N(n669), .A1N(n517), .Y(n245) );
  OAI2BB2X1M U442 ( .B0(n552), .B1(n514), .A0N(n635), .A1N(n515), .Y(n252) );
  OAI2BB2X1M U443 ( .B0(n553), .B1(n514), .A0N(n636), .A1N(n515), .Y(n253) );
  OAI2BB2X1M U444 ( .B0(n552), .B1(n512), .A0N(n588), .A1N(n513), .Y(n260) );
  OAI2BB2X1M U445 ( .B0(n553), .B1(n512), .A0N(n589), .A1N(n513), .Y(n261) );
  OAI2BB2X1M U446 ( .B0(n552), .B1(n510), .A0N(n611), .A1N(n511), .Y(n268) );
  OAI2BB2X1M U447 ( .B0(n553), .B1(n510), .A0N(n612), .A1N(n511), .Y(n269) );
  OAI2BB2X1M U448 ( .B0(n552), .B1(n508), .A0N(n659), .A1N(n509), .Y(n276) );
  OAI2BB2X1M U449 ( .B0(n553), .B1(n508), .A0N(n660), .A1N(n509), .Y(n277) );
  OAI2BB2X1M U450 ( .B0(n555), .B1(n528), .A0N(n586), .A1N(n529), .Y(n199) );
  OAI2BB2X1M U451 ( .B0(n556), .B1(n528), .A0N(n599), .A1N(n529), .Y(n200) );
  OAI2BB2X1M U452 ( .B0(n557), .B1(n528), .A0N(n600), .A1N(n529), .Y(n201) );
  OAI2BB2X1M U453 ( .B0(n558), .B1(n528), .A0N(n601), .A1N(n529), .Y(n202) );
  OAI2BB2X1M U454 ( .B0(n555), .B1(n526), .A0N(n630), .A1N(n527), .Y(n207) );
  OAI2BB2X1M U455 ( .B0(n556), .B1(n526), .A0N(n631), .A1N(n527), .Y(n208) );
  OAI2BB2X1M U456 ( .B0(n557), .B1(n526), .A0N(n632), .A1N(n527), .Y(n209) );
  OAI2BB2X1M U457 ( .B0(n558), .B1(n526), .A0N(n633), .A1N(n527), .Y(n210) );
  OAI2BB2X1M U458 ( .B0(n555), .B1(n524), .A0N(n678), .A1N(n525), .Y(n215) );
  OAI2BB2X1M U459 ( .B0(n556), .B1(n524), .A0N(n679), .A1N(n525), .Y(n216) );
  OAI2BB2X1M U460 ( .B0(n557), .B1(n524), .A0N(n680), .A1N(n525), .Y(n217) );
  OAI2BB2X1M U461 ( .B0(n558), .B1(n524), .A0N(n681), .A1N(n525), .Y(n218) );
  OAI2BB2X1M U462 ( .B0(n555), .B1(n522), .A0N(n653), .A1N(n523), .Y(n223) );
  OAI2BB2X1M U463 ( .B0(n556), .B1(n522), .A0N(n654), .A1N(n523), .Y(n224) );
  OAI2BB2X1M U464 ( .B0(n557), .B1(n522), .A0N(n655), .A1N(n523), .Y(n225) );
  OAI2BB2X1M U465 ( .B0(n558), .B1(n522), .A0N(n656), .A1N(n523), .Y(n226) );
  OAI2BB2X1M U466 ( .B0(n555), .B1(n520), .A0N(n606), .A1N(n521), .Y(n231) );
  OAI2BB2X1M U467 ( .B0(n556), .B1(n520), .A0N(n607), .A1N(n521), .Y(n232) );
  OAI2BB2X1M U468 ( .B0(n557), .B1(n520), .A0N(n608), .A1N(n521), .Y(n233) );
  OAI2BB2X1M U469 ( .B0(n558), .B1(n520), .A0N(n609), .A1N(n521), .Y(n234) );
  OAI2BB2X1M U470 ( .B0(n555), .B1(n518), .A0N(n623), .A1N(n519), .Y(n239) );
  OAI2BB2X1M U471 ( .B0(n556), .B1(n518), .A0N(n624), .A1N(n519), .Y(n240) );
  OAI2BB2X1M U472 ( .B0(n557), .B1(n518), .A0N(n625), .A1N(n519), .Y(n241) );
  OAI2BB2X1M U473 ( .B0(n558), .B1(n518), .A0N(n626), .A1N(n519), .Y(n242) );
  OAI2BB2X1M U474 ( .B0(n555), .B1(n516), .A0N(n671), .A1N(n517), .Y(n247) );
  OAI2BB2X1M U475 ( .B0(n556), .B1(n516), .A0N(n672), .A1N(n517), .Y(n248) );
  OAI2BB2X1M U476 ( .B0(n557), .B1(n516), .A0N(n673), .A1N(n517), .Y(n249) );
  OAI2BB2X1M U477 ( .B0(n558), .B1(n516), .A0N(n674), .A1N(n517), .Y(n250) );
  OAI2BB2X1M U478 ( .B0(n555), .B1(n514), .A0N(n638), .A1N(n515), .Y(n255) );
  OAI2BB2X1M U479 ( .B0(n556), .B1(n514), .A0N(n639), .A1N(n515), .Y(n256) );
  OAI2BB2X1M U480 ( .B0(n557), .B1(n514), .A0N(n640), .A1N(n515), .Y(n257) );
  OAI2BB2X1M U481 ( .B0(n558), .B1(n514), .A0N(n641), .A1N(n515), .Y(n258) );
  OAI2BB2X1M U482 ( .B0(n555), .B1(n512), .A0N(n591), .A1N(n513), .Y(n263) );
  OAI2BB2X1M U483 ( .B0(n556), .B1(n512), .A0N(n592), .A1N(n513), .Y(n264) );
  OAI2BB2X1M U484 ( .B0(n557), .B1(n512), .A0N(n593), .A1N(n513), .Y(n265) );
  OAI2BB2X1M U485 ( .B0(n558), .B1(n512), .A0N(n594), .A1N(n513), .Y(n266) );
  OAI2BB2X1M U486 ( .B0(n555), .B1(n510), .A0N(n614), .A1N(n511), .Y(n271) );
  OAI2BB2X1M U487 ( .B0(n556), .B1(n510), .A0N(n615), .A1N(n511), .Y(n272) );
  OAI2BB2X1M U488 ( .B0(n557), .B1(n510), .A0N(n616), .A1N(n511), .Y(n273) );
  OAI2BB2X1M U489 ( .B0(n558), .B1(n510), .A0N(n617), .A1N(n511), .Y(n274) );
  OAI2BB2X1M U490 ( .B0(n555), .B1(n508), .A0N(n662), .A1N(n509), .Y(n279) );
  OAI2BB2X1M U491 ( .B0(n556), .B1(n508), .A0N(n663), .A1N(n509), .Y(n280) );
  OAI2BB2X1M U492 ( .B0(n557), .B1(n508), .A0N(n664), .A1N(n509), .Y(n281) );
  OAI2BB2X1M U493 ( .B0(n558), .B1(n508), .A0N(n665), .A1N(n509), .Y(n282) );
  OAI2BB2X1M U494 ( .B0(n551), .B1(n507), .A0N(n575), .A1N(n507), .Y(n283) );
  OAI2BB2X1M U495 ( .B0(n551), .B1(n503), .A0N(REG1[0]), .A1N(n503), .Y(n299)
         );
  OAI2BB2X1M U496 ( .B0(n551), .B1(n501), .A0N(REG0[0]), .A1N(n501), .Y(n307)
         );
  OAI2BB2X1M U497 ( .B0(n554), .B1(n506), .A0N(REG3[3]), .A1N(n507), .Y(n286)
         );
  OAI2BB2X1M U498 ( .B0(n554), .B1(n504), .A0N(REG2[3]), .A1N(n505), .Y(n294)
         );
  OAI2BB2X1M U499 ( .B0(n554), .B1(n502), .A0N(REG1[3]), .A1N(n503), .Y(n302)
         );
  OAI2BB2X1M U500 ( .B0(n554), .B1(n500), .A0N(REG0[3]), .A1N(n501), .Y(n310)
         );
  OAI2BB2X1M U501 ( .B0(n552), .B1(n506), .A0N(REG3[1]), .A1N(n507), .Y(n284)
         );
  OAI2BB2X1M U502 ( .B0(n553), .B1(n506), .A0N(REG3[2]), .A1N(n507), .Y(n285)
         );
  OAI2BB2X1M U503 ( .B0(n552), .B1(n504), .A0N(n576), .A1N(n505), .Y(n292) );
  OAI2BB2X1M U504 ( .B0(n553), .B1(n504), .A0N(REG2[2]), .A1N(n505), .Y(n293)
         );
  OAI2BB2X1M U505 ( .B0(n552), .B1(n502), .A0N(REG1[1]), .A1N(n503), .Y(n300)
         );
  OAI2BB2X1M U506 ( .B0(n553), .B1(n502), .A0N(REG1[2]), .A1N(n503), .Y(n301)
         );
  OAI2BB2X1M U507 ( .B0(n552), .B1(n500), .A0N(REG0[1]), .A1N(n501), .Y(n308)
         );
  OAI2BB2X1M U508 ( .B0(n553), .B1(n500), .A0N(REG0[2]), .A1N(n501), .Y(n309)
         );
  OAI2BB2X1M U509 ( .B0(n555), .B1(n506), .A0N(REG3[4]), .A1N(n507), .Y(n287)
         );
  OAI2BB2X1M U510 ( .B0(n557), .B1(n506), .A0N(REG3[6]), .A1N(n507), .Y(n289)
         );
  OAI2BB2X1M U511 ( .B0(n558), .B1(n506), .A0N(REG3[7]), .A1N(n507), .Y(n290)
         );
  OAI2BB2X1M U512 ( .B0(n555), .B1(n504), .A0N(REG2[4]), .A1N(n505), .Y(n295)
         );
  OAI2BB2X1M U513 ( .B0(n557), .B1(n504), .A0N(REG2[6]), .A1N(n505), .Y(n297)
         );
  OAI2BB2X1M U514 ( .B0(n558), .B1(n504), .A0N(REG2[7]), .A1N(n505), .Y(n298)
         );
  OAI2BB2X1M U515 ( .B0(n555), .B1(n502), .A0N(REG1[4]), .A1N(n503), .Y(n303)
         );
  OAI2BB2X1M U516 ( .B0(n556), .B1(n502), .A0N(REG1[5]), .A1N(n503), .Y(n304)
         );
  OAI2BB2X1M U517 ( .B0(n557), .B1(n502), .A0N(REG1[6]), .A1N(n503), .Y(n305)
         );
  OAI2BB2X1M U518 ( .B0(n558), .B1(n502), .A0N(REG1[7]), .A1N(n503), .Y(n306)
         );
  OAI2BB2X1M U519 ( .B0(n555), .B1(n500), .A0N(REG0[4]), .A1N(n501), .Y(n311)
         );
  OAI2BB2X1M U520 ( .B0(n556), .B1(n500), .A0N(REG0[5]), .A1N(n501), .Y(n312)
         );
  OAI2BB2X1M U521 ( .B0(n557), .B1(n500), .A0N(REG0[6]), .A1N(n501), .Y(n313)
         );
  OAI2BB2X1M U522 ( .B0(n558), .B1(n500), .A0N(REG0[7]), .A1N(n501), .Y(n314)
         );
  OAI2BB2X1M U523 ( .B0(n551), .B1(n505), .A0N(REG2[0]), .A1N(n505), .Y(n291)
         );
  OAI2BB2X1M U524 ( .B0(n556), .B1(n506), .A0N(n682), .A1N(n507), .Y(n288) );
  OAI2BB2X1M U525 ( .B0(n556), .B1(n504), .A0N(REG2[5]), .A1N(n505), .Y(n296)
         );
  MX4XLM U526 ( .A(REG0[3]), .B(REG1[3]), .C(REG2[3]), .D(REG3[3]), .S0(n498), 
        .S1(n496), .Y(n476) );
  MX4XLM U527 ( .A(REG0[6]), .B(REG1[6]), .C(REG2[6]), .D(REG3[6]), .S0(n499), 
        .S1(n495), .Y(n488) );
  MX4X1M U528 ( .A(REG0[4]), .B(REG1[4]), .C(REG2[4]), .D(REG3[4]), .S0(n498), 
        .S1(n494), .Y(n480) );
  MX4X1M U529 ( .A(regArr_12__2_), .B(regArr_13__2_), .C(regArr_14__2_), .D(
        regArr_15__2_), .S0(n498), .S1(n496), .Y(n469) );
  MX4X1M U530 ( .A(regArr_12__3_), .B(regArr_13__3_), .C(regArr_14__3_), .D(
        regArr_15__3_), .S0(n498), .S1(n496), .Y(n473) );
  MX4X1M U531 ( .A(regArr_12__4_), .B(regArr_13__4_), .C(n586), .D(
        regArr_15__4_), .S0(n498), .S1(n496), .Y(n477) );
  MX4X1M U532 ( .A(regArr_12__5_), .B(regArr_13__5_), .C(regArr_14__5_), .D(
        regArr_15__5_), .S0(n499), .S1(Address[1]), .Y(n481) );
  MX4X1M U533 ( .A(regArr_12__6_), .B(regArr_13__6_), .C(regArr_14__6_), .D(
        regArr_15__6_), .S0(n499), .S1(Address[1]), .Y(n485) );
  MX4X1M U534 ( .A(regArr_12__7_), .B(regArr_13__7_), .C(regArr_14__7_), .D(
        regArr_15__7_), .S0(n499), .S1(Address[1]), .Y(n489) );
  MX4X1M U535 ( .A(regArr_12__0_), .B(regArr_13__0_), .C(regArr_14__0_), .D(
        regArr_15__0_), .S0(n497), .S1(n495), .Y(n461) );
  MX4X1M U536 ( .A(regArr_12__1_), .B(regArr_13__1_), .C(regArr_14__1_), .D(
        regArr_15__1_), .S0(n497), .S1(n495), .Y(n465) );
  AO22X1M U537 ( .A0(N43), .A1(n559), .B0(n582), .B1(n532), .Y(n178) );
  MX4XLM U538 ( .A(n464), .B(n462), .C(n463), .D(n461), .S0(Address[3]), .S1(
        Address[2]), .Y(N43) );
  MX4X1M U539 ( .A(regArr_8__0_), .B(regArr_9__0_), .C(regArr_10__0_), .D(
        regArr_11__0_), .S0(n497), .S1(n495), .Y(n462) );
  MX4X1M U540 ( .A(regArr_4__0_), .B(regArr_5__0_), .C(regArr_6__0_), .D(
        regArr_7__0_), .S0(n497), .S1(n495), .Y(n463) );
  AO22X1M U541 ( .A0(N42), .A1(n559), .B0(n583), .B1(n532), .Y(n179) );
  MX4XLM U542 ( .A(n468), .B(n466), .C(n467), .D(n465), .S0(Address[3]), .S1(
        Address[2]), .Y(N42) );
  MX4X1M U543 ( .A(regArr_8__1_), .B(regArr_9__1_), .C(regArr_10__1_), .D(
        regArr_11__1_), .S0(n497), .S1(n495), .Y(n466) );
  MX4X1M U544 ( .A(regArr_4__1_), .B(regArr_5__1_), .C(regArr_6__1_), .D(
        regArr_7__1_), .S0(n497), .S1(n496), .Y(n467) );
  AO22X1M U545 ( .A0(N41), .A1(n559), .B0(n580), .B1(n532), .Y(n180) );
  MX4XLM U546 ( .A(n472), .B(n470), .C(n471), .D(n469), .S0(Address[3]), .S1(
        Address[2]), .Y(N41) );
  MX4X1M U547 ( .A(regArr_8__2_), .B(regArr_9__2_), .C(regArr_10__2_), .D(
        regArr_11__2_), .S0(n498), .S1(n496), .Y(n470) );
  MX4X1M U548 ( .A(regArr_4__2_), .B(regArr_5__2_), .C(regArr_6__2_), .D(
        regArr_7__2_), .S0(n498), .S1(n496), .Y(n471) );
  AO22X1M U549 ( .A0(N40), .A1(n559), .B0(n532), .B1(n578), .Y(n181) );
  MX4XLM U550 ( .A(n476), .B(n474), .C(n475), .D(n473), .S0(Address[3]), .S1(
        Address[2]), .Y(N40) );
  MX4X1M U551 ( .A(regArr_8__3_), .B(regArr_9__3_), .C(regArr_10__3_), .D(
        regArr_11__3_), .S0(n498), .S1(n496), .Y(n474) );
  MX4X1M U552 ( .A(regArr_4__3_), .B(regArr_5__3_), .C(regArr_6__3_), .D(
        regArr_7__3_), .S0(n498), .S1(n496), .Y(n475) );
  AO22X1M U553 ( .A0(N39), .A1(n559), .B0(n581), .B1(n532), .Y(n182) );
  MX4XLM U554 ( .A(n480), .B(n478), .C(n479), .D(n477), .S0(Address[3]), .S1(
        Address[2]), .Y(N39) );
  MX4X1M U555 ( .A(regArr_8__4_), .B(regArr_9__4_), .C(regArr_10__4_), .D(
        regArr_11__4_), .S0(n498), .S1(n496), .Y(n478) );
  MX4X1M U556 ( .A(regArr_4__4_), .B(regArr_5__4_), .C(regArr_6__4_), .D(
        regArr_7__4_), .S0(n498), .S1(n496), .Y(n479) );
  AO22X1M U557 ( .A0(N38), .A1(n559), .B0(n584), .B1(n532), .Y(n183) );
  MX4XLM U558 ( .A(n484), .B(n482), .C(n483), .D(n481), .S0(Address[3]), .S1(
        Address[2]), .Y(N38) );
  MX4X1M U559 ( .A(regArr_8__5_), .B(regArr_9__5_), .C(regArr_10__5_), .D(
        regArr_11__5_), .S0(n499), .S1(n493), .Y(n482) );
  MX4X1M U560 ( .A(regArr_4__5_), .B(regArr_5__5_), .C(regArr_6__5_), .D(
        regArr_7__5_), .S0(n499), .S1(n496), .Y(n483) );
  AO22X1M U561 ( .A0(N37), .A1(n559), .B0(n532), .B1(n579), .Y(n184) );
  MX4XLM U562 ( .A(n488), .B(n486), .C(n487), .D(n485), .S0(Address[3]), .S1(
        Address[2]), .Y(N37) );
  MX4X1M U563 ( .A(regArr_8__6_), .B(regArr_9__6_), .C(regArr_10__6_), .D(
        regArr_11__6_), .S0(n499), .S1(n493), .Y(n486) );
  MX4X1M U564 ( .A(regArr_4__6_), .B(regArr_5__6_), .C(regArr_6__6_), .D(
        regArr_7__6_), .S0(n499), .S1(n493), .Y(n487) );
  AO22X1M U565 ( .A0(N36), .A1(n559), .B0(n585), .B1(n532), .Y(n185) );
  MX4XLM U566 ( .A(n492), .B(n490), .C(n491), .D(n489), .S0(Address[3]), .S1(
        Address[2]), .Y(N36) );
  MX4X1M U567 ( .A(regArr_8__7_), .B(regArr_9__7_), .C(regArr_10__7_), .D(
        regArr_11__7_), .S0(n499), .S1(n494), .Y(n490) );
  MX4X1M U568 ( .A(regArr_4__7_), .B(regArr_5__7_), .C(regArr_6__7_), .D(
        regArr_7__7_), .S0(n499), .S1(n535), .Y(n491) );
  OAI2BB1X2M U569 ( .A0N(n151), .A1N(n577), .B0(n532), .Y(n186) );
  DLY1X1M U570 ( .A(REG3[0]), .Y(n575) );
  DLY1X1M U571 ( .A(REG2[1]), .Y(n576) );
  DLY1X1M U572 ( .A(RdData_VLD), .Y(n577) );
  DLY1X1M U573 ( .A(RdData[3]), .Y(n578) );
  DLY1X1M U574 ( .A(RdData[6]), .Y(n579) );
  DLY1X1M U575 ( .A(RdData[2]), .Y(n580) );
  DLY1X1M U576 ( .A(RdData[4]), .Y(n581) );
  DLY1X1M U577 ( .A(RdData[0]), .Y(n582) );
  DLY1X1M U578 ( .A(RdData[1]), .Y(n583) );
  DLY1X1M U579 ( .A(RdData[5]), .Y(n584) );
  DLY1X1M U580 ( .A(RdData[7]), .Y(n585) );
  DLY1X1M U581 ( .A(test_so1), .Y(n586) );
  DLY1X1M U582 ( .A(regArr_6__0_), .Y(n587) );
  DLY1X1M U583 ( .A(regArr_6__1_), .Y(n588) );
  DLY1X1M U584 ( .A(regArr_6__2_), .Y(n589) );
  DLY1X1M U585 ( .A(regArr_6__3_), .Y(n590) );
  DLY1X1M U586 ( .A(regArr_6__4_), .Y(n591) );
  DLY1X1M U587 ( .A(regArr_6__5_), .Y(n592) );
  DLY1X1M U588 ( .A(regArr_6__6_), .Y(n593) );
  DLY1X1M U589 ( .A(regArr_6__7_), .Y(n594) );
  DLY1X1M U590 ( .A(regArr_14__0_), .Y(n595) );
  DLY1X1M U591 ( .A(regArr_14__1_), .Y(n596) );
  DLY1X1M U592 ( .A(regArr_14__2_), .Y(n597) );
  DLY1X1M U593 ( .A(regArr_14__3_), .Y(n598) );
  DLY1X1M U594 ( .A(regArr_14__5_), .Y(n599) );
  DLY1X1M U595 ( .A(regArr_14__6_), .Y(n600) );
  DLY1X1M U596 ( .A(regArr_14__7_), .Y(n601) );
  DLY1X1M U597 ( .A(regArr_10__0_), .Y(n602) );
  DLY1X1M U598 ( .A(regArr_10__1_), .Y(n603) );
  DLY1X1M U599 ( .A(regArr_10__2_), .Y(n604) );
  DLY1X1M U600 ( .A(regArr_10__3_), .Y(n605) );
  DLY1X1M U601 ( .A(regArr_10__4_), .Y(n606) );
  DLY1X1M U602 ( .A(regArr_10__5_), .Y(n607) );
  DLY1X1M U603 ( .A(regArr_10__6_), .Y(n608) );
  DLY1X1M U604 ( .A(regArr_10__7_), .Y(n609) );
  DLY1X1M U605 ( .A(regArr_5__0_), .Y(n610) );
  DLY1X1M U606 ( .A(regArr_5__1_), .Y(n611) );
  DLY1X1M U607 ( .A(regArr_5__2_), .Y(n612) );
  DLY1X1M U608 ( .A(regArr_5__3_), .Y(n613) );
  DLY1X1M U609 ( .A(regArr_5__4_), .Y(n614) );
  DLY1X1M U610 ( .A(regArr_5__5_), .Y(n615) );
  DLY1X1M U611 ( .A(regArr_5__6_), .Y(n616) );
  DLY1X1M U612 ( .A(regArr_5__7_), .Y(n617) );
  DLY1X1M U613 ( .A(regArr_9__0_), .Y(n618) );
  DLY1X1M U614 ( .A(regArr_13__0_), .Y(n619) );
  DLY1X1M U615 ( .A(regArr_9__1_), .Y(n620) );
  DLY1X1M U616 ( .A(regArr_9__2_), .Y(n621) );
  DLY1X1M U617 ( .A(regArr_9__3_), .Y(n622) );
  DLY1X1M U618 ( .A(regArr_9__4_), .Y(n623) );
  DLY1X1M U619 ( .A(regArr_9__5_), .Y(n624) );
  DLY1X1M U620 ( .A(regArr_9__6_), .Y(n625) );
  DLY1X1M U621 ( .A(regArr_9__7_), .Y(n626) );
  DLY1X1M U622 ( .A(regArr_13__1_), .Y(n627) );
  DLY1X1M U623 ( .A(regArr_13__2_), .Y(n628) );
  DLY1X1M U624 ( .A(regArr_13__3_), .Y(n629) );
  DLY1X1M U625 ( .A(regArr_13__4_), .Y(n630) );
  DLY1X1M U626 ( .A(regArr_13__5_), .Y(n631) );
  DLY1X1M U627 ( .A(regArr_13__6_), .Y(n632) );
  DLY1X1M U628 ( .A(regArr_13__7_), .Y(n633) );
  DLY1X1M U629 ( .A(regArr_7__0_), .Y(n634) );
  DLY1X1M U630 ( .A(regArr_7__1_), .Y(n635) );
  DLY1X1M U631 ( .A(regArr_7__2_), .Y(n636) );
  DLY1X1M U632 ( .A(regArr_7__3_), .Y(n637) );
  DLY1X1M U633 ( .A(regArr_7__4_), .Y(n638) );
  DLY1X1M U634 ( .A(regArr_7__5_), .Y(n639) );
  DLY1X1M U635 ( .A(regArr_7__6_), .Y(n640) );
  DLY1X1M U636 ( .A(regArr_7__7_), .Y(n641) );
  DLY1X1M U637 ( .A(regArr_11__0_), .Y(n642) );
  DLY1X1M U638 ( .A(regArr_15__0_), .Y(n643) );
  DLY1X1M U639 ( .A(regArr_15__1_), .Y(n644) );
  DLY1X1M U640 ( .A(regArr_15__2_), .Y(n645) );
  DLY1X1M U641 ( .A(regArr_15__3_), .Y(n646) );
  DLY1X1M U642 ( .A(regArr_15__4_), .Y(n647) );
  DLY1X1M U643 ( .A(regArr_15__5_), .Y(n648) );
  DLY1X1M U644 ( .A(regArr_15__6_), .Y(n649) );
  DLY1X1M U645 ( .A(regArr_11__1_), .Y(n650) );
  DLY1X1M U646 ( .A(regArr_11__2_), .Y(n651) );
  DLY1X1M U647 ( .A(regArr_11__3_), .Y(n652) );
  DLY1X1M U648 ( .A(regArr_11__4_), .Y(n653) );
  DLY1X1M U649 ( .A(regArr_11__5_), .Y(n654) );
  DLY1X1M U650 ( .A(regArr_11__6_), .Y(n655) );
  DLY1X1M U651 ( .A(regArr_11__7_), .Y(n656) );
  DLY1X1M U652 ( .A(regArr_15__7_), .Y(test_so2) );
  DLY1X1M U653 ( .A(regArr_4__0_), .Y(n658) );
  DLY1X1M U654 ( .A(regArr_4__1_), .Y(n659) );
  DLY1X1M U655 ( .A(regArr_4__2_), .Y(n660) );
  DLY1X1M U656 ( .A(regArr_4__3_), .Y(n661) );
  DLY1X1M U657 ( .A(regArr_4__4_), .Y(n662) );
  DLY1X1M U658 ( .A(regArr_4__5_), .Y(n663) );
  DLY1X1M U659 ( .A(regArr_4__6_), .Y(n664) );
  DLY1X1M U660 ( .A(regArr_4__7_), .Y(n665) );
  DLY1X1M U661 ( .A(regArr_8__0_), .Y(n666) );
  DLY1X1M U662 ( .A(regArr_12__0_), .Y(n667) );
  DLY1X1M U663 ( .A(regArr_8__1_), .Y(n668) );
  DLY1X1M U664 ( .A(regArr_8__2_), .Y(n669) );
  DLY1X1M U665 ( .A(regArr_8__3_), .Y(n670) );
  DLY1X1M U666 ( .A(regArr_8__4_), .Y(n671) );
  DLY1X1M U667 ( .A(regArr_8__5_), .Y(n672) );
  DLY1X1M U668 ( .A(regArr_8__6_), .Y(n673) );
  DLY1X1M U669 ( .A(regArr_8__7_), .Y(n674) );
  DLY1X1M U670 ( .A(regArr_12__1_), .Y(n675) );
  DLY1X1M U671 ( .A(regArr_12__2_), .Y(n676) );
  DLY1X1M U672 ( .A(regArr_12__3_), .Y(n677) );
  DLY1X1M U673 ( .A(regArr_12__4_), .Y(n678) );
  DLY1X1M U674 ( .A(regArr_12__5_), .Y(n679) );
  DLY1X1M U675 ( .A(regArr_12__6_), .Y(n680) );
  DLY1X1M U676 ( .A(regArr_12__7_), .Y(n681) );
  DLY1X1M U677 ( .A(REG3[5]), .Y(n682) );
  SDFFRQX2M regArr_reg_2__6_ ( .D(n297), .SI(REG2[5]), .SE(test_se), .CK(CLK), 
        .RN(n544), .Q(n3) );
  SDFFRQX2M regArr_reg_15__7_ ( .D(n194), .SI(n649), .SE(test_se), .CK(CLK), 
        .RN(n537), .Q(regArr_15__7_) );
  SDFFRQX2M regArr_reg_15__6_ ( .D(n193), .SI(n648), .SE(test_se), .CK(CLK), 
        .RN(n537), .Q(regArr_15__6_) );
  SDFFRQX2M regArr_reg_15__5_ ( .D(n192), .SI(n647), .SE(test_se), .CK(CLK), 
        .RN(n537), .Q(regArr_15__5_) );
  SDFFRQX2M regArr_reg_15__4_ ( .D(n191), .SI(n646), .SE(test_se), .CK(CLK), 
        .RN(n537), .Q(regArr_15__4_) );
  SDFFRQX2M regArr_reg_15__3_ ( .D(n190), .SI(n645), .SE(test_se), .CK(CLK), 
        .RN(n537), .Q(regArr_15__3_) );
  SDFFRQX2M regArr_reg_15__2_ ( .D(n189), .SI(n644), .SE(test_se), .CK(CLK), 
        .RN(n537), .Q(regArr_15__2_) );
  SDFFRQX2M regArr_reg_15__1_ ( .D(n188), .SI(n643), .SE(test_se), .CK(CLK), 
        .RN(n543), .Q(regArr_15__1_) );
  SDFFRQX2M regArr_reg_15__0_ ( .D(n187), .SI(n601), .SE(test_se), .CK(CLK), 
        .RN(n537), .Q(regArr_15__0_) );
  SDFFRQX2M regArr_reg_14__6_ ( .D(n201), .SI(n599), .SE(test_se), .CK(CLK), 
        .RN(n538), .Q(regArr_14__6_) );
  SDFFRQX2M regArr_reg_14__5_ ( .D(n200), .SI(test_si3), .SE(test_se), .CK(CLK), .RN(n537), .Q(regArr_14__5_) );
  SDFFRQX2M regArr_reg_14__4_ ( .D(n199), .SI(n598), .SE(test_se), .CK(CLK), 
        .RN(n537), .Q(test_so1) );
  SDFFRQX2M regArr_reg_14__3_ ( .D(n198), .SI(n597), .SE(test_se), .CK(CLK), 
        .RN(n537), .Q(regArr_14__3_) );
  SDFFRQX2M regArr_reg_14__2_ ( .D(n197), .SI(n596), .SE(test_se), .CK(CLK), 
        .RN(n537), .Q(regArr_14__2_) );
  SDFFRQX2M regArr_reg_14__1_ ( .D(n196), .SI(n595), .SE(test_se), .CK(CLK), 
        .RN(n537), .Q(regArr_14__1_) );
  SDFFRQX2M regArr_reg_14__0_ ( .D(n195), .SI(n633), .SE(test_se), .CK(CLK), 
        .RN(n537), .Q(regArr_14__0_) );
  SDFFRQX2M regArr_reg_13__7_ ( .D(n210), .SI(n632), .SE(test_se), .CK(CLK), 
        .RN(n538), .Q(regArr_13__7_) );
  SDFFRQX2M regArr_reg_13__6_ ( .D(n209), .SI(n631), .SE(test_se), .CK(CLK), 
        .RN(n538), .Q(regArr_13__6_) );
  SDFFRQX2M regArr_reg_13__5_ ( .D(n208), .SI(n630), .SE(test_se), .CK(CLK), 
        .RN(n538), .Q(regArr_13__5_) );
  SDFFRQX2M regArr_reg_13__4_ ( .D(n207), .SI(n629), .SE(test_se), .CK(CLK), 
        .RN(n538), .Q(regArr_13__4_) );
  SDFFRQX2M regArr_reg_13__3_ ( .D(n206), .SI(n628), .SE(test_se), .CK(CLK), 
        .RN(n538), .Q(regArr_13__3_) );
  SDFFRQX2M regArr_reg_13__2_ ( .D(n205), .SI(n627), .SE(test_se), .CK(CLK), 
        .RN(n538), .Q(regArr_13__2_) );
  SDFFRQX2M regArr_reg_13__1_ ( .D(n204), .SI(n619), .SE(test_se), .CK(CLK), 
        .RN(n538), .Q(regArr_13__1_) );
  SDFFRQX2M regArr_reg_13__0_ ( .D(n203), .SI(n681), .SE(test_se), .CK(CLK), 
        .RN(n538), .Q(regArr_13__0_) );
  SDFFRQX2M regArr_reg_12__7_ ( .D(n218), .SI(n680), .SE(test_se), .CK(CLK), 
        .RN(n539), .Q(regArr_12__7_) );
  SDFFRQX2M regArr_reg_12__6_ ( .D(n217), .SI(n679), .SE(test_se), .CK(CLK), 
        .RN(n539), .Q(regArr_12__6_) );
  SDFFRQX2M regArr_reg_12__5_ ( .D(n216), .SI(n678), .SE(test_se), .CK(CLK), 
        .RN(n539), .Q(regArr_12__5_) );
  SDFFRQX2M regArr_reg_12__4_ ( .D(n215), .SI(n677), .SE(test_se), .CK(CLK), 
        .RN(n539), .Q(regArr_12__4_) );
  SDFFRQX2M regArr_reg_12__3_ ( .D(n214), .SI(n676), .SE(test_se), .CK(CLK), 
        .RN(n539), .Q(regArr_12__3_) );
  SDFFRQX2M regArr_reg_12__2_ ( .D(n213), .SI(n675), .SE(test_se), .CK(CLK), 
        .RN(n538), .Q(regArr_12__2_) );
  SDFFRQX2M regArr_reg_12__1_ ( .D(n212), .SI(n667), .SE(test_se), .CK(CLK), 
        .RN(n538), .Q(regArr_12__1_) );
  SDFFRQX2M regArr_reg_12__0_ ( .D(n211), .SI(n656), .SE(test_se), .CK(CLK), 
        .RN(n538), .Q(regArr_12__0_) );
  SDFFRHQX1M regArr_reg_14__7_ ( .D(n202), .SI(n600), .SE(test_se), .CK(CLK), 
        .RN(n538), .Q(regArr_14__7_) );
  SDFFSQX4M regArr_reg_3__5_ ( .D(n288), .SI(REG3[4]), .SE(test_se), .CK(CLK), 
        .SN(n538), .Q(REG3[5]) );
  BUFX10M U3 ( .A(n549), .Y(n537) );
  INVXLM U4 ( .A(n3), .Y(n1) );
  INVX8M U5 ( .A(n1), .Y(REG2[6]) );
endmodule


module ALU_DW_div_uns_0 ( a, b, quotient, remainder, divide_by_0 );
  input [7:0] a;
  input [7:0] b;
  output [7:0] quotient;
  output [7:0] remainder;
  output divide_by_0;
  wire   u_div_SumTmp_1__0_, u_div_SumTmp_1__1_, u_div_SumTmp_1__2_,
         u_div_SumTmp_1__3_, u_div_SumTmp_1__4_, u_div_SumTmp_1__5_,
         u_div_SumTmp_1__6_, u_div_SumTmp_2__0_, u_div_SumTmp_2__1_,
         u_div_SumTmp_2__2_, u_div_SumTmp_2__3_, u_div_SumTmp_2__4_,
         u_div_SumTmp_2__5_, u_div_SumTmp_3__0_, u_div_SumTmp_3__1_,
         u_div_SumTmp_3__2_, u_div_SumTmp_3__3_, u_div_SumTmp_3__4_,
         u_div_SumTmp_4__0_, u_div_SumTmp_4__1_, u_div_SumTmp_4__2_,
         u_div_SumTmp_4__3_, u_div_SumTmp_5__0_, u_div_SumTmp_5__1_,
         u_div_SumTmp_5__2_, u_div_SumTmp_6__0_, u_div_SumTmp_6__1_,
         u_div_SumTmp_7__0_, u_div_CryTmp_0__1_, u_div_CryTmp_0__2_,
         u_div_CryTmp_0__3_, u_div_CryTmp_0__4_, u_div_CryTmp_0__5_,
         u_div_CryTmp_0__6_, u_div_CryTmp_0__7_, u_div_CryTmp_1__1_,
         u_div_CryTmp_1__2_, u_div_CryTmp_1__3_, u_div_CryTmp_1__4_,
         u_div_CryTmp_1__5_, u_div_CryTmp_1__6_, u_div_CryTmp_1__7_,
         u_div_CryTmp_2__1_, u_div_CryTmp_2__2_, u_div_CryTmp_2__3_,
         u_div_CryTmp_2__4_, u_div_CryTmp_2__5_, u_div_CryTmp_2__6_,
         u_div_CryTmp_3__1_, u_div_CryTmp_3__2_, u_div_CryTmp_3__3_,
         u_div_CryTmp_3__4_, u_div_CryTmp_3__5_, u_div_CryTmp_4__1_,
         u_div_CryTmp_4__2_, u_div_CryTmp_4__3_, u_div_CryTmp_4__4_,
         u_div_CryTmp_5__1_, u_div_CryTmp_5__2_, u_div_CryTmp_5__3_,
         u_div_CryTmp_6__1_, u_div_CryTmp_6__2_, u_div_CryTmp_7__1_,
         u_div_PartRem_1__1_, u_div_PartRem_1__2_, u_div_PartRem_1__3_,
         u_div_PartRem_1__4_, u_div_PartRem_1__5_, u_div_PartRem_1__6_,
         u_div_PartRem_1__7_, u_div_PartRem_2__1_, u_div_PartRem_2__2_,
         u_div_PartRem_2__3_, u_div_PartRem_2__4_, u_div_PartRem_2__5_,
         u_div_PartRem_2__6_, u_div_PartRem_3__1_, u_div_PartRem_3__2_,
         u_div_PartRem_3__3_, u_div_PartRem_3__4_, u_div_PartRem_3__5_,
         u_div_PartRem_4__1_, u_div_PartRem_4__2_, u_div_PartRem_4__3_,
         u_div_PartRem_4__4_, u_div_PartRem_5__1_, u_div_PartRem_5__2_,
         u_div_PartRem_5__3_, u_div_PartRem_6__1_, u_div_PartRem_6__2_,
         u_div_PartRem_7__1_, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11;

  ADDFX2M u_div_u_fa_PartRem_0_2_5 ( .A(u_div_PartRem_3__5_), .B(n3), .CI(
        u_div_CryTmp_2__5_), .CO(u_div_CryTmp_2__6_), .S(u_div_SumTmp_2__5_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_4_3 ( .A(u_div_PartRem_5__3_), .B(n5), .CI(
        u_div_CryTmp_4__3_), .CO(u_div_CryTmp_4__4_), .S(u_div_SumTmp_4__3_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_3_4 ( .A(u_div_PartRem_4__4_), .B(n4), .CI(
        u_div_CryTmp_3__4_), .CO(u_div_CryTmp_3__5_), .S(u_div_SumTmp_3__4_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_5_2 ( .A(u_div_PartRem_6__2_), .B(n6), .CI(
        u_div_CryTmp_5__2_), .CO(u_div_CryTmp_5__3_), .S(u_div_SumTmp_5__2_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_6_1 ( .A(u_div_PartRem_7__1_), .B(n7), .CI(
        u_div_CryTmp_6__1_), .CO(u_div_CryTmp_6__2_), .S(u_div_SumTmp_6__1_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_0_5 ( .A(u_div_PartRem_1__5_), .B(n3), .CI(
        u_div_CryTmp_0__5_), .CO(u_div_CryTmp_0__6_) );
  ADDFX2M u_div_u_fa_PartRem_0_0_6 ( .A(u_div_PartRem_1__6_), .B(n2), .CI(
        u_div_CryTmp_0__6_), .CO(u_div_CryTmp_0__7_) );
  ADDFX2M u_div_u_fa_PartRem_0_0_7 ( .A(u_div_PartRem_1__7_), .B(n1), .CI(
        u_div_CryTmp_0__7_), .CO(quotient[0]) );
  ADDFX2M u_div_u_fa_PartRem_0_0_2 ( .A(u_div_PartRem_1__2_), .B(n6), .CI(
        u_div_CryTmp_0__2_), .CO(u_div_CryTmp_0__3_) );
  ADDFX2M u_div_u_fa_PartRem_0_0_3 ( .A(u_div_PartRem_1__3_), .B(n5), .CI(
        u_div_CryTmp_0__3_), .CO(u_div_CryTmp_0__4_) );
  ADDFX2M u_div_u_fa_PartRem_0_0_4 ( .A(u_div_PartRem_1__4_), .B(n4), .CI(
        u_div_CryTmp_0__4_), .CO(u_div_CryTmp_0__5_) );
  ADDFX2M u_div_u_fa_PartRem_0_1_5 ( .A(u_div_PartRem_2__5_), .B(n3), .CI(
        u_div_CryTmp_1__5_), .CO(u_div_CryTmp_1__6_), .S(u_div_SumTmp_1__5_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_1_4 ( .A(u_div_PartRem_2__4_), .B(n4), .CI(
        u_div_CryTmp_1__4_), .CO(u_div_CryTmp_1__5_), .S(u_div_SumTmp_1__4_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_2_4 ( .A(u_div_PartRem_3__4_), .B(n4), .CI(
        u_div_CryTmp_2__4_), .CO(u_div_CryTmp_2__5_), .S(u_div_SumTmp_2__4_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_1_3 ( .A(u_div_PartRem_2__3_), .B(n5), .CI(
        u_div_CryTmp_1__3_), .CO(u_div_CryTmp_1__4_), .S(u_div_SumTmp_1__3_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_2_3 ( .A(u_div_PartRem_3__3_), .B(n5), .CI(
        u_div_CryTmp_2__3_), .CO(u_div_CryTmp_2__4_), .S(u_div_SumTmp_2__3_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_3_3 ( .A(u_div_PartRem_4__3_), .B(n5), .CI(
        u_div_CryTmp_3__3_), .CO(u_div_CryTmp_3__4_), .S(u_div_SumTmp_3__3_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_1_2 ( .A(u_div_PartRem_2__2_), .B(n6), .CI(
        u_div_CryTmp_1__2_), .CO(u_div_CryTmp_1__3_), .S(u_div_SumTmp_1__2_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_2_2 ( .A(u_div_PartRem_3__2_), .B(n6), .CI(
        u_div_CryTmp_2__2_), .CO(u_div_CryTmp_2__3_), .S(u_div_SumTmp_2__2_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_3_2 ( .A(u_div_PartRem_4__2_), .B(n6), .CI(
        u_div_CryTmp_3__2_), .CO(u_div_CryTmp_3__3_), .S(u_div_SumTmp_3__2_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_4_2 ( .A(u_div_PartRem_5__2_), .B(n6), .CI(
        u_div_CryTmp_4__2_), .CO(u_div_CryTmp_4__3_), .S(u_div_SumTmp_4__2_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_0_1 ( .A(u_div_PartRem_1__1_), .B(n7), .CI(
        u_div_CryTmp_0__1_), .CO(u_div_CryTmp_0__2_) );
  ADDFX2M u_div_u_fa_PartRem_0_1_1 ( .A(u_div_PartRem_2__1_), .B(n7), .CI(
        u_div_CryTmp_1__1_), .CO(u_div_CryTmp_1__2_), .S(u_div_SumTmp_1__1_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_2_1 ( .A(u_div_PartRem_3__1_), .B(n7), .CI(
        u_div_CryTmp_2__1_), .CO(u_div_CryTmp_2__2_), .S(u_div_SumTmp_2__1_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_3_1 ( .A(u_div_PartRem_4__1_), .B(n7), .CI(
        u_div_CryTmp_3__1_), .CO(u_div_CryTmp_3__2_), .S(u_div_SumTmp_3__1_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_4_1 ( .A(u_div_PartRem_5__1_), .B(n7), .CI(
        u_div_CryTmp_4__1_), .CO(u_div_CryTmp_4__2_), .S(u_div_SumTmp_4__1_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_5_1 ( .A(u_div_PartRem_6__1_), .B(n7), .CI(
        u_div_CryTmp_5__1_), .CO(u_div_CryTmp_5__2_), .S(u_div_SumTmp_5__1_)
         );
  ADDFX2M u_div_u_fa_PartRem_0_1_6 ( .A(u_div_PartRem_2__6_), .B(n2), .CI(
        u_div_CryTmp_1__6_), .CO(u_div_CryTmp_1__7_), .S(u_div_SumTmp_1__6_)
         );
  INVX8M U1 ( .A(b[0]), .Y(n8) );
  CLKINVX4M U2 ( .A(b[2]), .Y(n6) );
  NOR2X4M U3 ( .A(b[6]), .B(b[7]), .Y(n11) );
  AND3X4M U4 ( .A(n11), .B(n3), .C(u_div_CryTmp_3__5_), .Y(quotient[3]) );
  CLKAND2X4M U5 ( .A(u_div_CryTmp_4__4_), .B(n10), .Y(quotient[4]) );
  CLKAND2X4M U6 ( .A(u_div_CryTmp_2__6_), .B(n11), .Y(quotient[2]) );
  CLKAND2X4M U7 ( .A(u_div_CryTmp_1__7_), .B(n1), .Y(quotient[1]) );
  AND2X2M U8 ( .A(u_div_CryTmp_5__3_), .B(n9), .Y(quotient[5]) );
  MX2X1M U9 ( .A(u_div_PartRem_3__2_), .B(u_div_SumTmp_2__2_), .S0(quotient[2]), .Y(u_div_PartRem_2__3_) );
  MX2X1M U10 ( .A(u_div_PartRem_3__5_), .B(u_div_SumTmp_2__5_), .S0(
        quotient[2]), .Y(u_div_PartRem_2__6_) );
  MX2X1M U11 ( .A(u_div_PartRem_3__1_), .B(u_div_SumTmp_2__1_), .S0(
        quotient[2]), .Y(u_div_PartRem_2__2_) );
  MX2X1M U12 ( .A(u_div_PartRem_3__3_), .B(u_div_SumTmp_2__3_), .S0(
        quotient[2]), .Y(u_div_PartRem_2__4_) );
  MX2X1M U13 ( .A(u_div_PartRem_3__4_), .B(u_div_SumTmp_2__4_), .S0(
        quotient[2]), .Y(u_div_PartRem_2__5_) );
  MX2X1M U14 ( .A(u_div_PartRem_4__4_), .B(u_div_SumTmp_3__4_), .S0(
        quotient[3]), .Y(u_div_PartRem_3__5_) );
  MX2X1M U15 ( .A(u_div_PartRem_4__3_), .B(u_div_SumTmp_3__3_), .S0(
        quotient[3]), .Y(u_div_PartRem_3__4_) );
  MX2X1M U16 ( .A(u_div_PartRem_4__2_), .B(u_div_SumTmp_3__2_), .S0(
        quotient[3]), .Y(u_div_PartRem_3__3_) );
  MX2X1M U17 ( .A(u_div_PartRem_4__1_), .B(u_div_SumTmp_3__1_), .S0(
        quotient[3]), .Y(u_div_PartRem_3__2_) );
  MX2X1M U18 ( .A(u_div_PartRem_5__3_), .B(u_div_SumTmp_4__3_), .S0(
        quotient[4]), .Y(u_div_PartRem_4__4_) );
  MX2X1M U19 ( .A(u_div_PartRem_5__2_), .B(u_div_SumTmp_4__2_), .S0(
        quotient[4]), .Y(u_div_PartRem_4__3_) );
  MX2X1M U20 ( .A(u_div_PartRem_5__1_), .B(u_div_SumTmp_4__1_), .S0(
        quotient[4]), .Y(u_div_PartRem_4__2_) );
  MX2X1M U21 ( .A(u_div_PartRem_6__1_), .B(u_div_SumTmp_5__1_), .S0(
        quotient[5]), .Y(u_div_PartRem_5__2_) );
  MX2X1M U22 ( .A(u_div_PartRem_6__2_), .B(u_div_SumTmp_5__2_), .S0(
        quotient[5]), .Y(u_div_PartRem_5__3_) );
  MX2XLM U23 ( .A(u_div_PartRem_2__1_), .B(u_div_SumTmp_1__1_), .S0(
        quotient[1]), .Y(u_div_PartRem_1__2_) );
  MX2XLM U24 ( .A(u_div_PartRem_2__2_), .B(u_div_SumTmp_1__2_), .S0(
        quotient[1]), .Y(u_div_PartRem_1__3_) );
  MX2XLM U25 ( .A(u_div_PartRem_2__4_), .B(u_div_SumTmp_1__4_), .S0(
        quotient[1]), .Y(u_div_PartRem_1__5_) );
  MX2XLM U26 ( .A(u_div_PartRem_2__5_), .B(u_div_SumTmp_1__5_), .S0(
        quotient[1]), .Y(u_div_PartRem_1__6_) );
  AND3X2M U27 ( .A(n9), .B(n6), .C(u_div_CryTmp_6__2_), .Y(quotient[6]) );
  AND2X2M U28 ( .A(n10), .B(n5), .Y(n9) );
  INVX4M U29 ( .A(b[1]), .Y(n7) );
  OR2X2M U30 ( .A(a[7]), .B(n8), .Y(u_div_CryTmp_7__1_) );
  XNOR2X2M U31 ( .A(n8), .B(a[2]), .Y(u_div_SumTmp_2__0_) );
  XNOR2X2M U32 ( .A(n8), .B(a[3]), .Y(u_div_SumTmp_3__0_) );
  XNOR2X2M U33 ( .A(n8), .B(a[4]), .Y(u_div_SumTmp_4__0_) );
  XNOR2X2M U34 ( .A(n8), .B(a[5]), .Y(u_div_SumTmp_5__0_) );
  XNOR2X2M U35 ( .A(n8), .B(a[6]), .Y(u_div_SumTmp_6__0_) );
  XNOR2X2M U36 ( .A(n8), .B(a[7]), .Y(u_div_SumTmp_7__0_) );
  XNOR2X2M U37 ( .A(n8), .B(a[1]), .Y(u_div_SumTmp_1__0_) );
  INVX2M U38 ( .A(b[6]), .Y(n2) );
  OR2X2M U39 ( .A(a[5]), .B(n8), .Y(u_div_CryTmp_5__1_) );
  OR2X2M U40 ( .A(a[4]), .B(n8), .Y(u_div_CryTmp_4__1_) );
  OR2X2M U41 ( .A(a[3]), .B(n8), .Y(u_div_CryTmp_3__1_) );
  OR2X2M U42 ( .A(a[2]), .B(n8), .Y(u_div_CryTmp_2__1_) );
  OR2X2M U43 ( .A(a[1]), .B(n8), .Y(u_div_CryTmp_1__1_) );
  NAND2BX2M U44 ( .AN(a[0]), .B(b[0]), .Y(u_div_CryTmp_0__1_) );
  OR2X2M U45 ( .A(a[6]), .B(n8), .Y(u_div_CryTmp_6__1_) );
  INVX4M U46 ( .A(b[3]), .Y(n5) );
  INVX4M U47 ( .A(b[4]), .Y(n4) );
  INVX4M U48 ( .A(b[5]), .Y(n3) );
  INVX2M U49 ( .A(b[7]), .Y(n1) );
  CLKMX2X2M U50 ( .A(u_div_PartRem_2__6_), .B(u_div_SumTmp_1__6_), .S0(
        quotient[1]), .Y(u_div_PartRem_1__7_) );
  CLKMX2X2M U51 ( .A(u_div_PartRem_7__1_), .B(u_div_SumTmp_6__1_), .S0(
        quotient[6]), .Y(u_div_PartRem_6__2_) );
  CLKMX2X2M U52 ( .A(a[7]), .B(u_div_SumTmp_7__0_), .S0(quotient[7]), .Y(
        u_div_PartRem_7__1_) );
  CLKMX2X2M U53 ( .A(a[6]), .B(u_div_SumTmp_6__0_), .S0(quotient[6]), .Y(
        u_div_PartRem_6__1_) );
  CLKMX2X2M U54 ( .A(a[5]), .B(u_div_SumTmp_5__0_), .S0(quotient[5]), .Y(
        u_div_PartRem_5__1_) );
  CLKMX2X2M U55 ( .A(u_div_PartRem_2__3_), .B(u_div_SumTmp_1__3_), .S0(
        quotient[1]), .Y(u_div_PartRem_1__4_) );
  CLKMX2X2M U56 ( .A(a[4]), .B(u_div_SumTmp_4__0_), .S0(quotient[4]), .Y(
        u_div_PartRem_4__1_) );
  CLKMX2X2M U57 ( .A(a[3]), .B(u_div_SumTmp_3__0_), .S0(quotient[3]), .Y(
        u_div_PartRem_3__1_) );
  CLKMX2X2M U58 ( .A(a[2]), .B(u_div_SumTmp_2__0_), .S0(quotient[2]), .Y(
        u_div_PartRem_2__1_) );
  CLKMX2X2M U59 ( .A(a[1]), .B(u_div_SumTmp_1__0_), .S0(quotient[1]), .Y(
        u_div_PartRem_1__1_) );
  AND4X1M U60 ( .A(u_div_CryTmp_7__1_), .B(n9), .C(n7), .D(n6), .Y(quotient[7]) );
  AND3X1M U61 ( .A(n11), .B(n4), .C(n3), .Y(n10) );
endmodule


module ALU_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8;
  wire   [8:1] carry;

  ADDFX2M U2_7 ( .A(A[7]), .B(n1), .CI(carry[7]), .CO(carry[8]), .S(DIFF[7])
         );
  ADDFX2M U2_5 ( .A(A[5]), .B(n3), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  ADDFX2M U2_4 ( .A(A[4]), .B(n4), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4])
         );
  ADDFX2M U2_3 ( .A(A[3]), .B(n5), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3])
         );
  ADDFX2M U2_2 ( .A(A[2]), .B(n6), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2])
         );
  ADDFX2M U2_1 ( .A(A[1]), .B(n7), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1])
         );
  ADDFX2M U2_6 ( .A(A[6]), .B(n2), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6])
         );
  INVXLM U1 ( .A(B[2]), .Y(n6) );
  XNOR2X2M U2 ( .A(n8), .B(A[0]), .Y(DIFF[0]) );
  INVX2M U3 ( .A(B[6]), .Y(n2) );
  INVX2M U4 ( .A(B[0]), .Y(n8) );
  OR2X2M U5 ( .A(A[0]), .B(n8), .Y(carry[1]) );
  INVX2M U6 ( .A(B[1]), .Y(n7) );
  INVX2M U7 ( .A(B[3]), .Y(n5) );
  INVX2M U8 ( .A(B[4]), .Y(n4) );
  INVX2M U9 ( .A(B[5]), .Y(n3) );
  INVX2M U10 ( .A(B[7]), .Y(n1) );
  CLKINVX1M U11 ( .A(carry[8]), .Y(DIFF[8]) );
endmodule


module ALU_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [7:2] carry;

  ADDFX2M U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFX2M U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFX2M U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFX2M U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFX2M U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFX2M U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFX2M U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  AND2X2M U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  CLKXOR2X2M U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_DW01_add_1 ( A, B, CI, SUM, CO );
  input [13:0] A;
  input [13:0] B;
  output [13:0] SUM;
  input CI;
  output CO;
  wire   n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26;

  OAI21BX4M U2 ( .A0(n19), .A1(n20), .B0N(n21), .Y(n17) );
  AOI2BB1X2M U3 ( .A0N(n8), .A1N(n11), .B0(n10), .Y(n24) );
  NOR2X2M U4 ( .A(B[11]), .B(A[11]), .Y(n19) );
  NOR2X2M U5 ( .A(B[9]), .B(A[9]), .Y(n11) );
  NOR2X2M U6 ( .A(B[10]), .B(A[10]), .Y(n23) );
  NOR2X2M U7 ( .A(B[8]), .B(A[8]), .Y(n14) );
  CLKXOR2X2M U8 ( .A(A[7]), .B(B[7]), .Y(SUM[7]) );
  CLKXOR2X2M U9 ( .A(B[13]), .B(n16), .Y(SUM[13]) );
  NAND2X2M U10 ( .A(A[7]), .B(B[7]), .Y(n13) );
  INVX2M U11 ( .A(A[6]), .Y(n7) );
  INVX2M U12 ( .A(n7), .Y(SUM[6]) );
  BUFX2M U13 ( .A(A[0]), .Y(SUM[0]) );
  BUFX2M U14 ( .A(A[1]), .Y(SUM[1]) );
  BUFX2M U15 ( .A(A[2]), .Y(SUM[2]) );
  BUFX2M U16 ( .A(A[3]), .Y(SUM[3]) );
  BUFX2M U17 ( .A(A[4]), .Y(SUM[4]) );
  BUFX2M U18 ( .A(A[5]), .Y(SUM[5]) );
  XNOR2X1M U19 ( .A(n8), .B(n9), .Y(SUM[9]) );
  NOR2X1M U20 ( .A(n10), .B(n11), .Y(n9) );
  CLKXOR2X2M U21 ( .A(n12), .B(n13), .Y(SUM[8]) );
  NAND2BX1M U22 ( .AN(n14), .B(n15), .Y(n12) );
  OAI2BB1X1M U23 ( .A0N(n17), .A1N(A[12]), .B0(n18), .Y(n16) );
  OAI21X1M U24 ( .A0(A[12]), .A1(n17), .B0(B[12]), .Y(n18) );
  XOR3XLM U25 ( .A(B[12]), .B(A[12]), .C(n17), .Y(SUM[12]) );
  XNOR2X1M U26 ( .A(n20), .B(n22), .Y(SUM[11]) );
  NOR2X1M U27 ( .A(n21), .B(n19), .Y(n22) );
  AND2X1M U28 ( .A(B[11]), .B(A[11]), .Y(n21) );
  OA21X1M U29 ( .A0(n23), .A1(n24), .B0(n25), .Y(n20) );
  CLKXOR2X2M U30 ( .A(n26), .B(n24), .Y(SUM[10]) );
  AND2X1M U31 ( .A(B[9]), .B(A[9]), .Y(n10) );
  OA21X1M U32 ( .A0(n13), .A1(n14), .B0(n15), .Y(n8) );
  CLKNAND2X2M U33 ( .A(B[8]), .B(A[8]), .Y(n15) );
  NAND2BX1M U34 ( .AN(n23), .B(n25), .Y(n26) );
  CLKNAND2X2M U35 ( .A(B[10]), .B(A[10]), .Y(n25) );
endmodule


module ALU_DW02_mult_0 ( A, B, TC, PRODUCT );
  input [7:0] A;
  input [7:0] B;
  output [15:0] PRODUCT;
  input TC;
  wire   ab_7__7_, ab_7__6_, ab_7__5_, ab_7__4_, ab_7__3_, ab_7__2_, ab_7__1_,
         ab_7__0_, ab_6__7_, ab_6__6_, ab_6__5_, ab_6__4_, ab_6__3_, ab_6__2_,
         ab_6__1_, ab_6__0_, ab_5__7_, ab_5__6_, ab_5__5_, ab_5__4_, ab_5__3_,
         ab_5__2_, ab_5__1_, ab_5__0_, ab_4__7_, ab_4__6_, ab_4__5_, ab_4__4_,
         ab_4__3_, ab_4__2_, ab_4__1_, ab_4__0_, ab_3__7_, ab_3__6_, ab_3__5_,
         ab_3__4_, ab_3__3_, ab_3__2_, ab_3__1_, ab_3__0_, ab_2__7_, ab_2__6_,
         ab_2__5_, ab_2__4_, ab_2__3_, ab_2__2_, ab_2__1_, ab_2__0_, ab_1__7_,
         ab_1__6_, ab_1__5_, ab_1__4_, ab_1__3_, ab_1__2_, ab_1__1_, ab_1__0_,
         ab_0__7_, ab_0__6_, ab_0__5_, ab_0__4_, ab_0__3_, ab_0__2_, ab_0__1_,
         CARRYB_7__6_, CARRYB_7__5_, CARRYB_7__4_, CARRYB_7__3_, CARRYB_7__2_,
         CARRYB_7__1_, CARRYB_7__0_, CARRYB_6__6_, CARRYB_6__5_, CARRYB_6__4_,
         CARRYB_6__3_, CARRYB_6__2_, CARRYB_6__1_, CARRYB_6__0_, CARRYB_5__6_,
         CARRYB_5__5_, CARRYB_5__4_, CARRYB_5__3_, CARRYB_5__2_, CARRYB_5__1_,
         CARRYB_5__0_, CARRYB_4__6_, CARRYB_4__5_, CARRYB_4__4_, CARRYB_4__3_,
         CARRYB_4__2_, CARRYB_4__1_, CARRYB_4__0_, CARRYB_3__6_, CARRYB_3__5_,
         CARRYB_3__4_, CARRYB_3__3_, CARRYB_3__2_, CARRYB_3__1_, CARRYB_3__0_,
         CARRYB_2__6_, CARRYB_2__5_, CARRYB_2__4_, CARRYB_2__3_, CARRYB_2__2_,
         CARRYB_2__1_, CARRYB_2__0_, SUMB_7__6_, SUMB_7__5_, SUMB_7__4_,
         SUMB_7__3_, SUMB_7__2_, SUMB_7__1_, SUMB_7__0_, SUMB_6__6_,
         SUMB_6__5_, SUMB_6__4_, SUMB_6__3_, SUMB_6__2_, SUMB_6__1_,
         SUMB_5__6_, SUMB_5__5_, SUMB_5__4_, SUMB_5__3_, SUMB_5__2_,
         SUMB_5__1_, SUMB_4__6_, SUMB_4__5_, SUMB_4__4_, SUMB_4__3_,
         SUMB_4__2_, SUMB_4__1_, SUMB_3__6_, SUMB_3__5_, SUMB_3__4_,
         SUMB_3__3_, SUMB_3__2_, SUMB_3__1_, SUMB_2__6_, SUMB_2__5_,
         SUMB_2__4_, SUMB_2__3_, SUMB_2__2_, SUMB_2__1_, SUMB_1__6_,
         SUMB_1__5_, SUMB_1__4_, SUMB_1__3_, SUMB_1__2_, SUMB_1__1_, A1_12_,
         A1_11_, A1_10_, A1_9_, A1_8_, A1_7_, A1_6_, A1_4_, A1_3_, A1_2_,
         A1_1_, A1_0_, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32;

  ADDFX2M S2_6_5 ( .A(ab_6__5_), .B(CARRYB_5__5_), .CI(SUMB_5__6_), .CO(
        CARRYB_6__5_), .S(SUMB_6__5_) );
  ADDFX2M S2_6_4 ( .A(ab_6__4_), .B(CARRYB_5__4_), .CI(SUMB_5__5_), .CO(
        CARRYB_6__4_), .S(SUMB_6__4_) );
  ADDFX2M S2_5_5 ( .A(ab_5__5_), .B(CARRYB_4__5_), .CI(SUMB_4__6_), .CO(
        CARRYB_5__5_), .S(SUMB_5__5_) );
  ADDFX2M S2_6_3 ( .A(ab_6__3_), .B(CARRYB_5__3_), .CI(SUMB_5__4_), .CO(
        CARRYB_6__3_), .S(SUMB_6__3_) );
  ADDFX2M S2_5_4 ( .A(ab_5__4_), .B(CARRYB_4__4_), .CI(SUMB_4__5_), .CO(
        CARRYB_5__4_), .S(SUMB_5__4_) );
  ADDFX2M S1_6_0 ( .A(ab_6__0_), .B(CARRYB_5__0_), .CI(SUMB_5__1_), .CO(
        CARRYB_6__0_), .S(A1_4_) );
  ADDFX2M S2_6_1 ( .A(ab_6__1_), .B(CARRYB_5__1_), .CI(SUMB_5__2_), .CO(
        CARRYB_6__1_), .S(SUMB_6__1_) );
  ADDFX2M S2_6_2 ( .A(ab_6__2_), .B(CARRYB_5__2_), .CI(SUMB_5__3_), .CO(
        CARRYB_6__2_), .S(SUMB_6__2_) );
  ADDFX2M S2_4_5 ( .A(ab_4__5_), .B(CARRYB_3__5_), .CI(SUMB_3__6_), .CO(
        CARRYB_4__5_), .S(SUMB_4__5_) );
  ADDFX2M S1_5_0 ( .A(ab_5__0_), .B(CARRYB_4__0_), .CI(SUMB_4__1_), .CO(
        CARRYB_5__0_), .S(A1_3_) );
  ADDFX2M S2_5_1 ( .A(ab_5__1_), .B(CARRYB_4__1_), .CI(SUMB_4__2_), .CO(
        CARRYB_5__1_), .S(SUMB_5__1_) );
  ADDFX2M S2_5_2 ( .A(ab_5__2_), .B(CARRYB_4__2_), .CI(SUMB_4__3_), .CO(
        CARRYB_5__2_), .S(SUMB_5__2_) );
  ADDFX2M S2_5_3 ( .A(ab_5__3_), .B(CARRYB_4__3_), .CI(SUMB_4__4_), .CO(
        CARRYB_5__3_), .S(SUMB_5__3_) );
  ADDFX2M S1_4_0 ( .A(ab_4__0_), .B(CARRYB_3__0_), .CI(SUMB_3__1_), .CO(
        CARRYB_4__0_), .S(A1_2_) );
  ADDFX2M S2_4_1 ( .A(ab_4__1_), .B(CARRYB_3__1_), .CI(SUMB_3__2_), .CO(
        CARRYB_4__1_), .S(SUMB_4__1_) );
  ADDFX2M S2_4_2 ( .A(ab_4__2_), .B(CARRYB_3__2_), .CI(SUMB_3__3_), .CO(
        CARRYB_4__2_), .S(SUMB_4__2_) );
  ADDFX2M S2_4_3 ( .A(ab_4__3_), .B(CARRYB_3__3_), .CI(SUMB_3__4_), .CO(
        CARRYB_4__3_), .S(SUMB_4__3_) );
  ADDFX2M S2_4_4 ( .A(ab_4__4_), .B(CARRYB_3__4_), .CI(SUMB_3__5_), .CO(
        CARRYB_4__4_), .S(SUMB_4__4_) );
  ADDFX2M S1_3_0 ( .A(ab_3__0_), .B(CARRYB_2__0_), .CI(SUMB_2__1_), .CO(
        CARRYB_3__0_), .S(A1_1_) );
  ADDFX2M S2_3_1 ( .A(ab_3__1_), .B(CARRYB_2__1_), .CI(SUMB_2__2_), .CO(
        CARRYB_3__1_), .S(SUMB_3__1_) );
  ADDFX2M S2_3_2 ( .A(ab_3__2_), .B(CARRYB_2__2_), .CI(SUMB_2__3_), .CO(
        CARRYB_3__2_), .S(SUMB_3__2_) );
  ADDFX2M S2_3_3 ( .A(ab_3__3_), .B(CARRYB_2__3_), .CI(SUMB_2__4_), .CO(
        CARRYB_3__3_), .S(SUMB_3__3_) );
  ADDFX2M S2_3_4 ( .A(ab_3__4_), .B(CARRYB_2__4_), .CI(SUMB_2__5_), .CO(
        CARRYB_3__4_), .S(SUMB_3__4_) );
  ADDFX2M S2_3_5 ( .A(ab_3__5_), .B(CARRYB_2__5_), .CI(SUMB_2__6_), .CO(
        CARRYB_3__5_), .S(SUMB_3__5_) );
  ADDFX2M S1_2_0 ( .A(ab_2__0_), .B(n10), .CI(SUMB_1__1_), .CO(CARRYB_2__0_), 
        .S(A1_0_) );
  ADDFX2M S2_2_1 ( .A(ab_2__1_), .B(n4), .CI(SUMB_1__2_), .CO(CARRYB_2__1_), 
        .S(SUMB_2__1_) );
  ADDFX2M S2_2_2 ( .A(ab_2__2_), .B(n9), .CI(SUMB_1__3_), .CO(CARRYB_2__2_), 
        .S(SUMB_2__2_) );
  ADDFX2M S2_2_3 ( .A(ab_2__3_), .B(n8), .CI(SUMB_1__4_), .CO(CARRYB_2__3_), 
        .S(SUMB_2__3_) );
  ADDFX2M S2_2_4 ( .A(ab_2__4_), .B(n7), .CI(SUMB_1__5_), .CO(CARRYB_2__4_), 
        .S(SUMB_2__4_) );
  ADDFX2M S2_2_5 ( .A(ab_2__5_), .B(n6), .CI(SUMB_1__6_), .CO(CARRYB_2__5_), 
        .S(SUMB_2__5_) );
  ADDFX2M S3_6_6 ( .A(ab_6__6_), .B(CARRYB_5__6_), .CI(ab_5__7_), .CO(
        CARRYB_6__6_), .S(SUMB_6__6_) );
  ADDFX2M S3_5_6 ( .A(ab_5__6_), .B(CARRYB_4__6_), .CI(ab_4__7_), .CO(
        CARRYB_5__6_), .S(SUMB_5__6_) );
  ADDFX2M S3_4_6 ( .A(ab_4__6_), .B(CARRYB_3__6_), .CI(ab_3__7_), .CO(
        CARRYB_4__6_), .S(SUMB_4__6_) );
  ADDFX2M S3_3_6 ( .A(ab_3__6_), .B(CARRYB_2__6_), .CI(ab_2__7_), .CO(
        CARRYB_3__6_), .S(SUMB_3__6_) );
  ADDFX2M S3_2_6 ( .A(ab_2__6_), .B(n5), .CI(ab_1__7_), .CO(CARRYB_2__6_), .S(
        SUMB_2__6_) );
  ADDFX2M S4_5 ( .A(ab_7__5_), .B(CARRYB_6__5_), .CI(SUMB_6__6_), .CO(
        CARRYB_7__5_), .S(SUMB_7__5_) );
  ADDFX2M S4_4 ( .A(ab_7__4_), .B(CARRYB_6__4_), .CI(SUMB_6__5_), .CO(
        CARRYB_7__4_), .S(SUMB_7__4_) );
  ADDFX2M S4_3 ( .A(ab_7__3_), .B(CARRYB_6__3_), .CI(SUMB_6__4_), .CO(
        CARRYB_7__3_), .S(SUMB_7__3_) );
  ADDFX2M S4_2 ( .A(ab_7__2_), .B(CARRYB_6__2_), .CI(SUMB_6__3_), .CO(
        CARRYB_7__2_), .S(SUMB_7__2_) );
  ADDFX2M S4_0 ( .A(ab_7__0_), .B(CARRYB_6__0_), .CI(SUMB_6__1_), .CO(
        CARRYB_7__0_), .S(SUMB_7__0_) );
  ADDFX2M S4_1 ( .A(ab_7__1_), .B(CARRYB_6__1_), .CI(SUMB_6__2_), .CO(
        CARRYB_7__1_), .S(SUMB_7__1_) );
  ADDFX2M S5_6 ( .A(ab_7__6_), .B(CARRYB_6__6_), .CI(ab_6__7_), .CO(
        CARRYB_7__6_), .S(SUMB_7__6_) );
  AND2X2M U2 ( .A(CARRYB_7__6_), .B(ab_7__7_), .Y(n3) );
  AND2X2M U3 ( .A(ab_0__2_), .B(ab_1__1_), .Y(n4) );
  AND2X2M U4 ( .A(ab_0__7_), .B(ab_1__6_), .Y(n5) );
  AND2X2M U5 ( .A(ab_0__6_), .B(ab_1__5_), .Y(n6) );
  AND2X2M U6 ( .A(ab_0__5_), .B(ab_1__4_), .Y(n7) );
  AND2X2M U7 ( .A(ab_0__4_), .B(ab_1__3_), .Y(n8) );
  AND2X2M U8 ( .A(ab_0__3_), .B(ab_1__2_), .Y(n9) );
  AND2X2M U9 ( .A(ab_0__1_), .B(ab_1__0_), .Y(n10) );
  CLKINVX4M U10 ( .A(B[2]), .Y(n30) );
  NOR2X2M U11 ( .A(n26), .B(n24), .Y(ab_0__6_) );
  NOR2X2M U12 ( .A(n26), .B(n23), .Y(ab_1__6_) );
  NOR2X2M U13 ( .A(n25), .B(n24), .Y(ab_0__7_) );
  NOR2X2M U14 ( .A(n27), .B(n24), .Y(ab_0__5_) );
  NOR2X2M U15 ( .A(n28), .B(n24), .Y(ab_0__4_) );
  NOR2X2M U16 ( .A(n29), .B(n24), .Y(ab_0__3_) );
  NOR2X2M U17 ( .A(n30), .B(n24), .Y(ab_0__2_) );
  NOR2X2M U18 ( .A(n31), .B(n24), .Y(ab_0__1_) );
  NOR2X2M U19 ( .A(n17), .B(n25), .Y(ab_7__7_) );
  NOR2X2M U20 ( .A(n27), .B(n23), .Y(ab_1__5_) );
  NOR2X2M U21 ( .A(n28), .B(n23), .Y(ab_1__4_) );
  NOR2X2M U22 ( .A(n29), .B(n23), .Y(ab_1__3_) );
  NOR2X2M U23 ( .A(n30), .B(n23), .Y(ab_1__2_) );
  NOR2X2M U24 ( .A(n31), .B(n23), .Y(ab_1__1_) );
  NOR2X2M U25 ( .A(n32), .B(n23), .Y(ab_1__0_) );
  CLKXOR2X2M U26 ( .A(CARRYB_7__6_), .B(ab_7__7_), .Y(A1_12_) );
  CLKXOR2X2M U27 ( .A(CARRYB_7__1_), .B(SUMB_7__2_), .Y(A1_7_) );
  CLKXOR2X2M U28 ( .A(CARRYB_7__2_), .B(SUMB_7__3_), .Y(A1_8_) );
  CLKXOR2X2M U29 ( .A(CARRYB_7__4_), .B(SUMB_7__5_), .Y(A1_10_) );
  CLKXOR2X2M U30 ( .A(CARRYB_7__3_), .B(SUMB_7__4_), .Y(A1_9_) );
  CLKXOR2X2M U31 ( .A(CARRYB_7__5_), .B(SUMB_7__6_), .Y(A1_11_) );
  XOR2X1M U32 ( .A(ab_1__0_), .B(ab_0__1_), .Y(PRODUCT[1]) );
  INVX4M U33 ( .A(A[7]), .Y(n17) );
  INVX4M U34 ( .A(A[1]), .Y(n23) );
  INVX4M U35 ( .A(A[2]), .Y(n22) );
  INVX4M U36 ( .A(A[3]), .Y(n21) );
  INVX4M U37 ( .A(A[4]), .Y(n20) );
  INVX4M U38 ( .A(A[5]), .Y(n19) );
  INVX4M U39 ( .A(A[6]), .Y(n18) );
  AND2X2M U40 ( .A(CARRYB_7__0_), .B(SUMB_7__1_), .Y(n11) );
  CLKXOR2X2M U41 ( .A(CARRYB_7__0_), .B(SUMB_7__1_), .Y(A1_6_) );
  AND2X2M U42 ( .A(CARRYB_7__1_), .B(SUMB_7__2_), .Y(n12) );
  AND2X2M U43 ( .A(CARRYB_7__3_), .B(SUMB_7__4_), .Y(n13) );
  AND2X2M U44 ( .A(CARRYB_7__5_), .B(SUMB_7__6_), .Y(n14) );
  AND2X2M U45 ( .A(CARRYB_7__2_), .B(SUMB_7__3_), .Y(n15) );
  AND2X2M U46 ( .A(CARRYB_7__4_), .B(SUMB_7__5_), .Y(n16) );
  INVX4M U47 ( .A(B[6]), .Y(n26) );
  INVX4M U48 ( .A(A[0]), .Y(n24) );
  XOR2X1M U49 ( .A(ab_1__6_), .B(ab_0__7_), .Y(SUMB_1__6_) );
  XOR2X1M U50 ( .A(ab_1__5_), .B(ab_0__6_), .Y(SUMB_1__5_) );
  XOR2X1M U51 ( .A(ab_1__4_), .B(ab_0__5_), .Y(SUMB_1__4_) );
  XOR2X1M U52 ( .A(ab_1__3_), .B(ab_0__4_), .Y(SUMB_1__3_) );
  XOR2X1M U53 ( .A(ab_1__2_), .B(ab_0__3_), .Y(SUMB_1__2_) );
  XOR2X1M U54 ( .A(ab_1__1_), .B(ab_0__2_), .Y(SUMB_1__1_) );
  INVX4M U55 ( .A(B[7]), .Y(n25) );
  INVX4M U56 ( .A(B[0]), .Y(n32) );
  INVX4M U57 ( .A(B[4]), .Y(n28) );
  INVX4M U58 ( .A(B[5]), .Y(n27) );
  INVX4M U59 ( .A(B[1]), .Y(n31) );
  INVX4M U60 ( .A(B[3]), .Y(n29) );
  NOR2X1M U62 ( .A(n17), .B(n26), .Y(ab_7__6_) );
  NOR2X1M U63 ( .A(n17), .B(n27), .Y(ab_7__5_) );
  NOR2X1M U64 ( .A(n17), .B(n28), .Y(ab_7__4_) );
  NOR2X1M U65 ( .A(n17), .B(n29), .Y(ab_7__3_) );
  NOR2X1M U66 ( .A(n17), .B(n30), .Y(ab_7__2_) );
  NOR2X1M U67 ( .A(n17), .B(n31), .Y(ab_7__1_) );
  NOR2X1M U68 ( .A(n17), .B(n32), .Y(ab_7__0_) );
  NOR2X1M U69 ( .A(n25), .B(n18), .Y(ab_6__7_) );
  NOR2X1M U70 ( .A(n26), .B(n18), .Y(ab_6__6_) );
  NOR2X1M U71 ( .A(n27), .B(n18), .Y(ab_6__5_) );
  NOR2X1M U72 ( .A(n28), .B(n18), .Y(ab_6__4_) );
  NOR2X1M U73 ( .A(n29), .B(n18), .Y(ab_6__3_) );
  NOR2X1M U74 ( .A(n30), .B(n18), .Y(ab_6__2_) );
  NOR2X1M U75 ( .A(n31), .B(n18), .Y(ab_6__1_) );
  NOR2X1M U76 ( .A(n32), .B(n18), .Y(ab_6__0_) );
  NOR2X1M U77 ( .A(n25), .B(n19), .Y(ab_5__7_) );
  NOR2X1M U78 ( .A(n26), .B(n19), .Y(ab_5__6_) );
  NOR2X1M U79 ( .A(n27), .B(n19), .Y(ab_5__5_) );
  NOR2X1M U80 ( .A(n28), .B(n19), .Y(ab_5__4_) );
  NOR2X1M U81 ( .A(n29), .B(n19), .Y(ab_5__3_) );
  NOR2X1M U82 ( .A(n30), .B(n19), .Y(ab_5__2_) );
  NOR2X1M U83 ( .A(n31), .B(n19), .Y(ab_5__1_) );
  NOR2X1M U84 ( .A(n32), .B(n19), .Y(ab_5__0_) );
  NOR2X1M U85 ( .A(n25), .B(n20), .Y(ab_4__7_) );
  NOR2X1M U86 ( .A(n26), .B(n20), .Y(ab_4__6_) );
  NOR2X1M U87 ( .A(n27), .B(n20), .Y(ab_4__5_) );
  NOR2X1M U88 ( .A(n28), .B(n20), .Y(ab_4__4_) );
  NOR2X1M U89 ( .A(n29), .B(n20), .Y(ab_4__3_) );
  NOR2X1M U90 ( .A(n30), .B(n20), .Y(ab_4__2_) );
  NOR2X1M U91 ( .A(n31), .B(n20), .Y(ab_4__1_) );
  NOR2X1M U92 ( .A(n32), .B(n20), .Y(ab_4__0_) );
  NOR2X1M U93 ( .A(n25), .B(n21), .Y(ab_3__7_) );
  NOR2X1M U94 ( .A(n26), .B(n21), .Y(ab_3__6_) );
  NOR2X1M U95 ( .A(n27), .B(n21), .Y(ab_3__5_) );
  NOR2X1M U96 ( .A(n28), .B(n21), .Y(ab_3__4_) );
  NOR2X1M U97 ( .A(n29), .B(n21), .Y(ab_3__3_) );
  NOR2X1M U98 ( .A(n30), .B(n21), .Y(ab_3__2_) );
  NOR2X1M U99 ( .A(n31), .B(n21), .Y(ab_3__1_) );
  NOR2X1M U100 ( .A(n32), .B(n21), .Y(ab_3__0_) );
  NOR2X1M U101 ( .A(n25), .B(n22), .Y(ab_2__7_) );
  NOR2X1M U102 ( .A(n26), .B(n22), .Y(ab_2__6_) );
  NOR2X1M U103 ( .A(n27), .B(n22), .Y(ab_2__5_) );
  NOR2X1M U104 ( .A(n28), .B(n22), .Y(ab_2__4_) );
  NOR2X1M U105 ( .A(n29), .B(n22), .Y(ab_2__3_) );
  NOR2X1M U106 ( .A(n30), .B(n22), .Y(ab_2__2_) );
  NOR2X1M U107 ( .A(n31), .B(n22), .Y(ab_2__1_) );
  NOR2X1M U108 ( .A(n32), .B(n22), .Y(ab_2__0_) );
  NOR2X1M U109 ( .A(n25), .B(n23), .Y(ab_1__7_) );
  NOR2X1M U110 ( .A(n32), .B(n24), .Y(PRODUCT[0]) );
  ALU_DW01_add_1 FS_1 ( .A({1'b0, A1_12_, A1_11_, A1_10_, A1_9_, A1_8_, A1_7_, 
        A1_6_, SUMB_7__0_, A1_4_, A1_3_, A1_2_, A1_1_, A1_0_}), .B({n3, n14, 
        n16, n13, n15, n12, n11, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), 
        .CI(1'b0), .SUM(PRODUCT[15:2]) );
endmodule


module ALU_test_1 ( A, B, EN, ALU_FUN, CLK, RST, ALU_OUT, OUT_VALID, test_si, 
        test_se );
  input [7:0] A;
  input [7:0] B;
  input [3:0] ALU_FUN;
  output [15:0] ALU_OUT;
  input EN, CLK, RST, test_si, test_se;
  output OUT_VALID;
  wire   N91, N92, N93, N94, N95, N96, N97, N98, N99, N100, N101, N102, N103,
         N104, N105, N106, N107, N108, N109, N110, N111, N112, N113, N114,
         N115, N116, N117, N118, N119, N120, N121, N122, N123, N124, N125,
         N126, N127, N128, N129, N130, N131, N132, N157, N158, N159, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79,
         n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93,
         n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121, n122, n123, n124, n3, n4, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n58, n59, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151,
         n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162,
         n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, n173,
         n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184,
         n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195,
         n196, n197, n198, n199, n200, SYNOPSYS_UNCONNECTED_1,
         SYNOPSYS_UNCONNECTED_2, SYNOPSYS_UNCONNECTED_3,
         SYNOPSYS_UNCONNECTED_4, SYNOPSYS_UNCONNECTED_5,
         SYNOPSYS_UNCONNECTED_6, SYNOPSYS_UNCONNECTED_7,
         SYNOPSYS_UNCONNECTED_8;
  wire   [15:0] ALU_OUT_Comb;

  OAI2BB1X4M U94 ( .A0N(n117), .A1N(n116), .B0(n118), .Y(n65) );
  SDFFRQX1M ALU_OUT_reg_8_ ( .D(ALU_OUT_Comb[8]), .SI(ALU_OUT[7]), .SE(test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[8]) );
  SDFFRQX1M ALU_OUT_reg_7_ ( .D(ALU_OUT_Comb[7]), .SI(ALU_OUT[6]), .SE(test_se), .CK(CLK), .RN(n148), .Q(ALU_OUT[7]) );
  SDFFRQX1M ALU_OUT_reg_6_ ( .D(ALU_OUT_Comb[6]), .SI(ALU_OUT[5]), .SE(test_se), .CK(CLK), .RN(n148), .Q(ALU_OUT[6]) );
  SDFFRQX1M ALU_OUT_reg_0_ ( .D(ALU_OUT_Comb[0]), .SI(test_si), .SE(test_se), 
        .CK(CLK), .RN(n149), .Q(ALU_OUT[0]) );
  SDFFRQX1M ALU_OUT_reg_4_ ( .D(ALU_OUT_Comb[4]), .SI(ALU_OUT[3]), .SE(test_se), .CK(CLK), .RN(n148), .Q(ALU_OUT[4]) );
  SDFFRQX1M ALU_OUT_reg_3_ ( .D(ALU_OUT_Comb[3]), .SI(ALU_OUT[2]), .SE(test_se), .CK(CLK), .RN(n149), .Q(ALU_OUT[3]) );
  SDFFRQX1M ALU_OUT_reg_2_ ( .D(ALU_OUT_Comb[2]), .SI(ALU_OUT[1]), .SE(test_se), .CK(CLK), .RN(n149), .Q(ALU_OUT[2]) );
  SDFFRQX1M ALU_OUT_reg_5_ ( .D(ALU_OUT_Comb[5]), .SI(ALU_OUT[4]), .SE(test_se), .CK(CLK), .RN(n148), .Q(ALU_OUT[5]) );
  SDFFRQX1M ALU_OUT_reg_1_ ( .D(ALU_OUT_Comb[1]), .SI(ALU_OUT[0]), .SE(test_se), .CK(CLK), .RN(n149), .Q(ALU_OUT[1]) );
  SDFFRQX1M ALU_OUT_reg_15_ ( .D(ALU_OUT_Comb[15]), .SI(ALU_OUT[14]), .SE(
        test_se), .CK(CLK), .RN(n148), .Q(ALU_OUT[15]) );
  SDFFRQX1M ALU_OUT_reg_14_ ( .D(ALU_OUT_Comb[14]), .SI(ALU_OUT[13]), .SE(
        test_se), .CK(CLK), .RN(n148), .Q(ALU_OUT[14]) );
  SDFFRQX1M ALU_OUT_reg_13_ ( .D(ALU_OUT_Comb[13]), .SI(ALU_OUT[12]), .SE(
        test_se), .CK(CLK), .RN(n148), .Q(ALU_OUT[13]) );
  SDFFRQX1M ALU_OUT_reg_12_ ( .D(ALU_OUT_Comb[12]), .SI(ALU_OUT[11]), .SE(
        test_se), .CK(CLK), .RN(n148), .Q(ALU_OUT[12]) );
  SDFFRQX1M ALU_OUT_reg_11_ ( .D(ALU_OUT_Comb[11]), .SI(ALU_OUT[10]), .SE(
        test_se), .CK(CLK), .RN(n148), .Q(ALU_OUT[11]) );
  SDFFRQX1M ALU_OUT_reg_10_ ( .D(ALU_OUT_Comb[10]), .SI(ALU_OUT[9]), .SE(
        test_se), .CK(CLK), .RN(n148), .Q(ALU_OUT[10]) );
  SDFFRQX1M ALU_OUT_reg_9_ ( .D(ALU_OUT_Comb[9]), .SI(ALU_OUT[8]), .SE(test_se), .CK(CLK), .RN(n148), .Q(ALU_OUT[9]) );
  SDFFRHQX4M OUT_VALID_reg ( .D(EN), .SI(ALU_OUT[15]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(OUT_VALID) );
  INVX2M U7 ( .A(n150), .Y(n149) );
  AOI2B1X1M U23 ( .A1N(n175), .A0(n174), .B0(n173), .Y(n176) );
  INVX2M U24 ( .A(n176), .Y(N158) );
  OR2X2M U25 ( .A(n124), .B(n197), .Y(n3) );
  NAND2X2M U26 ( .A(n116), .B(n122), .Y(n4) );
  XNOR2X4M U44 ( .A(n135), .B(n41), .Y(n170) );
  OAI31X2M U45 ( .A0(n163), .A1(n154), .A2(n153), .B0(n164), .Y(n156) );
  AOI211X2M U46 ( .A0(n45), .A1(n181), .B0(n160), .C0(n152), .Y(n153) );
  AOI211X2M U47 ( .A0(n161), .A1(n43), .B0(n160), .C0(n159), .Y(n162) );
  NAND2BX2M U48 ( .AN(n154), .B(n165), .Y(n160) );
  OAI21X2M U49 ( .A0(n173), .A1(n158), .B0(n174), .Y(N159) );
  BUFX4M U50 ( .A(n66), .Y(n39) );
  AOI222X2M U51 ( .A0(N114), .A1(n140), .B0(n132), .B1(n142), .C0(N130), .C1(
        n39), .Y(n75) );
  AOI222X2M U52 ( .A0(N113), .A1(n140), .B0(n129), .B1(n141), .C0(N129), .C1(
        n39), .Y(n81) );
  AOI222X2M U53 ( .A0(N112), .A1(n140), .B0(n126), .B1(n142), .C0(N128), .C1(
        n39), .Y(n87) );
  AOI222X2M U54 ( .A0(N111), .A1(n140), .B0(n58), .B1(n141), .C0(N127), .C1(
        n39), .Y(n93) );
  AOI222X2M U55 ( .A0(N126), .A1(n39), .B0(n143), .B1(n191), .C0(n45), .C1(
        n141), .Y(n99) );
  NOR3BX2M U56 ( .AN(n122), .B(n199), .C(ALU_FUN[2]), .Y(n66) );
  NOR2X2M U57 ( .A(n179), .B(n126), .Y(n163) );
  NOR2X2M U58 ( .A(n178), .B(n58), .Y(n154) );
  NOR2X2M U59 ( .A(n177), .B(n42), .Y(n151) );
  NOR2X2M U60 ( .A(n136), .B(B[7]), .Y(n173) );
  INVX4M U61 ( .A(n4), .Y(n142) );
  INVX4M U62 ( .A(n4), .Y(n141) );
  NOR2X4M U63 ( .A(n196), .B(n40), .Y(n122) );
  NOR2X2M U64 ( .A(n40), .B(ALU_FUN[0]), .Y(n117) );
  AND2X2M U65 ( .A(ALU_FUN[2]), .B(n199), .Y(n116) );
  AOI31X1M U66 ( .A0(n98), .A1(n99), .A2(n100), .B0(n184), .Y(ALU_OUT_Comb[1])
         );
  AOI31X1M U67 ( .A0(n92), .A1(n93), .A2(n94), .B0(n184), .Y(ALU_OUT_Comb[2])
         );
  AOI31X1M U68 ( .A0(n86), .A1(n87), .A2(n88), .B0(n184), .Y(ALU_OUT_Comb[3])
         );
  AOI31X1M U69 ( .A0(n80), .A1(n81), .A2(n82), .B0(n184), .Y(ALU_OUT_Comb[4])
         );
  AOI31X1M U70 ( .A0(n74), .A1(n75), .A2(n76), .B0(n184), .Y(ALU_OUT_Comb[5])
         );
  CLKBUFX6M U71 ( .A(B[6]), .Y(n41) );
  BUFX6M U72 ( .A(A[0]), .Y(n42) );
  INVX4M U73 ( .A(n3), .Y(n144) );
  INVX4M U74 ( .A(n3), .Y(n143) );
  NOR2BX8M U75 ( .AN(n140), .B(n184), .Y(n48) );
  OAI2BB1X2M U76 ( .A0N(N118), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[9]) );
  OAI2BB1X2M U77 ( .A0N(N119), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[10]) );
  OAI2BB1X2M U78 ( .A0N(N120), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[11]) );
  OAI2BB1X2M U79 ( .A0N(N121), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[12]) );
  OAI2BB1X2M U80 ( .A0N(N122), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[13]) );
  OAI2BB1X2M U81 ( .A0N(N123), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[14]) );
  OAI2BB1X2M U82 ( .A0N(N124), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[15]) );
  CLKAND2X6M U83 ( .A(n123), .B(n122), .Y(n67) );
  INVX4M U84 ( .A(n108), .Y(n198) );
  INVX2M U85 ( .A(n117), .Y(n197) );
  CLKBUFX6M U86 ( .A(n54), .Y(n139) );
  NOR2BX2M U87 ( .AN(n123), .B(n197), .Y(n54) );
  CLKBUFX6M U88 ( .A(n64), .Y(n147) );
  OAI2BB1X2M U89 ( .A0N(n200), .A1N(n122), .B0(n118), .Y(n64) );
  INVX2M U90 ( .A(n124), .Y(n200) );
  BUFX4M U91 ( .A(n63), .Y(n145) );
  BUFX4M U92 ( .A(n63), .Y(n146) );
  AOI31X2M U93 ( .A0(n68), .A1(n69), .A2(n70), .B0(n184), .Y(ALU_OUT_Comb[6])
         );
  AOI22X1M U95 ( .A0(N106), .A1(n67), .B0(N97), .B1(n139), .Y(n68) );
  AOI221X2M U96 ( .A0(n198), .A1(n138), .B0(n144), .B1(n186), .C0(n71), .Y(n70) );
  AOI222X2M U97 ( .A0(N115), .A1(n140), .B0(n141), .B1(n135), .C0(N131), .C1(
        n39), .Y(n69) );
  NAND2X4M U98 ( .A(EN), .B(n183), .Y(n49) );
  INVX6M U99 ( .A(EN), .Y(n184) );
  NOR2X4M U100 ( .A(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n123) );
  NAND3X4M U101 ( .A(n200), .B(n196), .C(n40), .Y(n53) );
  INVX4M U102 ( .A(ALU_FUN[0]), .Y(n196) );
  INVX4M U103 ( .A(ALU_FUN[1]), .Y(n199) );
  NAND2X2M U104 ( .A(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n124) );
  INVX4M U105 ( .A(n45), .Y(n191) );
  NAND3X2M U106 ( .A(n40), .B(ALU_FUN[0]), .C(n116), .Y(n108) );
  INVX2M U107 ( .A(n138), .Y(n185) );
  INVX2M U108 ( .A(n58), .Y(n190) );
  INVX2M U109 ( .A(n126), .Y(n189) );
  INVX2M U110 ( .A(n129), .Y(n188) );
  INVX2M U111 ( .A(n132), .Y(n187) );
  INVX2M U112 ( .A(n135), .Y(n186) );
  NAND3X2M U113 ( .A(n123), .B(ALU_FUN[0]), .C(n40), .Y(n118) );
  CLKBUFX6M U114 ( .A(n52), .Y(n140) );
  NOR3X2M U115 ( .A(n197), .B(ALU_FUN[2]), .C(n199), .Y(n52) );
  AND4X1M U116 ( .A(N159), .B(n116), .C(n40), .D(n196), .Y(n107) );
  INVX6M U117 ( .A(n150), .Y(n148) );
  AND3X2M U118 ( .A(n123), .B(n196), .C(n40), .Y(n63) );
  AOI211X2M U119 ( .A0(n58), .A1(n198), .B0(n101), .C0(n102), .Y(n100) );
  AOI222X2M U120 ( .A0(N92), .A1(n139), .B0(N110), .B1(n140), .C0(N101), .C1(
        n67), .Y(n98) );
  AOI31X2M U121 ( .A0(n110), .A1(n111), .A2(n112), .B0(n184), .Y(
        ALU_OUT_Comb[0]) );
  AOI22X1M U122 ( .A0(N100), .A1(n67), .B0(N91), .B1(n139), .Y(n110) );
  AOI211X2M U123 ( .A0(n144), .A1(n192), .B0(n113), .C0(n114), .Y(n112) );
  AOI222X2M U124 ( .A0(N109), .A1(n140), .B0(n42), .B1(n142), .C0(N125), .C1(
        n39), .Y(n111) );
  AOI22X1M U125 ( .A0(N102), .A1(n67), .B0(N93), .B1(n139), .Y(n92) );
  AOI221X2M U126 ( .A0(n126), .A1(n198), .B0(n144), .B1(n190), .C0(n95), .Y(
        n94) );
  AOI22X1M U127 ( .A0(N103), .A1(n67), .B0(N94), .B1(n139), .Y(n86) );
  AOI221X2M U128 ( .A0(n129), .A1(n198), .B0(n144), .B1(n189), .C0(n89), .Y(
        n88) );
  AOI22X1M U129 ( .A0(N104), .A1(n67), .B0(N95), .B1(n139), .Y(n80) );
  AOI221X2M U130 ( .A0(n198), .A1(n132), .B0(n144), .B1(n188), .C0(n83), .Y(
        n82) );
  AOI22X1M U131 ( .A0(N105), .A1(n67), .B0(N96), .B1(n139), .Y(n74) );
  AOI221X2M U132 ( .A0(n198), .A1(n135), .B0(n144), .B1(n187), .C0(n77), .Y(
        n76) );
  AOI31X2M U133 ( .A0(n55), .A1(n56), .A2(n57), .B0(n184), .Y(ALU_OUT_Comb[7])
         );
  AOI22X1M U134 ( .A0(N107), .A1(n67), .B0(N98), .B1(n139), .Y(n55) );
  AOI221X2M U135 ( .A0(n144), .A1(n185), .B0(n142), .B1(n138), .C0(n60), .Y(
        n57) );
  AOI22X1M U136 ( .A0(N132), .A1(n39), .B0(N116), .B1(n140), .Y(n56) );
  AOI21X2M U137 ( .A0(n50), .A1(n51), .B0(n184), .Y(ALU_OUT_Comb[8]) );
  AOI21X2M U138 ( .A0(N99), .A1(n139), .B0(n183), .Y(n50) );
  AOI2BB2X2M U139 ( .B0(N117), .B1(n140), .A0N(n185), .A1N(n53), .Y(n51) );
  INVX2M U140 ( .A(n41), .Y(n180) );
  OAI222X1M U141 ( .A0(n72), .A1(n180), .B0(n41), .B1(n73), .C0(n53), .C1(n187), .Y(n71) );
  AOI221X2M U142 ( .A0(n135), .A1(n145), .B0(n147), .B1(n186), .C0(n143), .Y(
        n73) );
  AOI221X2M U143 ( .A0(n146), .A1(n186), .B0(n135), .B1(n65), .C0(n142), .Y(
        n72) );
  INVX2M U144 ( .A(n109), .Y(n183) );
  AOI211X2M U145 ( .A0(N108), .A1(n67), .B0(n144), .C0(n147), .Y(n109) );
  INVX2M U146 ( .A(n42), .Y(n192) );
  CLKBUFX6M U147 ( .A(ALU_FUN[3]), .Y(n40) );
  INVX4M U148 ( .A(n133), .Y(n134) );
  INVX4M U149 ( .A(n46), .Y(n47) );
  INVX4M U150 ( .A(n59), .Y(n125) );
  INVX4M U151 ( .A(n127), .Y(n128) );
  INVX4M U152 ( .A(n130), .Y(n131) );
  INVX4M U153 ( .A(n43), .Y(n44) );
  INVX4M U154 ( .A(n136), .Y(n137) );
  INVX4M U155 ( .A(n59), .Y(n126) );
  INVX4M U156 ( .A(n46), .Y(n58) );
  INVX4M U157 ( .A(n133), .Y(n135) );
  INVX4M U158 ( .A(n130), .Y(n132) );
  INVX4M U159 ( .A(n127), .Y(n129) );
  INVX4M U160 ( .A(n136), .Y(n138) );
  INVX4M U161 ( .A(n43), .Y(n45) );
  INVX2M U162 ( .A(RST), .Y(n150) );
  INVXLM U163 ( .A(n151), .Y(n181) );
  INVXLM U164 ( .A(n162), .Y(n182) );
  OAI222X1M U165 ( .A0(n61), .A1(n193), .B0(B[7]), .B1(n62), .C0(n53), .C1(
        n186), .Y(n60) );
  INVX2M U166 ( .A(B[7]), .Y(n193) );
  AOI221X2M U167 ( .A0(n146), .A1(n138), .B0(n147), .B1(n185), .C0(n144), .Y(
        n62) );
  AOI221X2M U168 ( .A0(n146), .A1(n185), .B0(n138), .B1(n65), .C0(n141), .Y(
        n61) );
  OAI222X1M U169 ( .A0(n84), .A1(n195), .B0(B[4]), .B1(n85), .C0(n53), .C1(
        n189), .Y(n83) );
  INVX2M U170 ( .A(B[4]), .Y(n195) );
  AOI221X2M U171 ( .A0(n129), .A1(n145), .B0(n147), .B1(n188), .C0(n143), .Y(
        n85) );
  AOI221X2M U172 ( .A0(n146), .A1(n188), .B0(n129), .B1(n65), .C0(n142), .Y(
        n84) );
  OAI222X1M U173 ( .A0(n78), .A1(n194), .B0(B[5]), .B1(n79), .C0(n53), .C1(
        n188), .Y(n77) );
  INVX2M U174 ( .A(B[5]), .Y(n194) );
  AOI221X2M U175 ( .A0(n132), .A1(n145), .B0(n147), .B1(n187), .C0(n143), .Y(
        n79) );
  AOI221X2M U176 ( .A0(n146), .A1(n187), .B0(n132), .B1(n65), .C0(n141), .Y(
        n78) );
  OAI222X1M U177 ( .A0(n96), .A1(n178), .B0(B[2]), .B1(n97), .C0(n53), .C1(
        n191), .Y(n95) );
  AOI221X2M U178 ( .A0(n58), .A1(n145), .B0(n147), .B1(n190), .C0(n143), .Y(
        n97) );
  AOI221X2M U179 ( .A0(n146), .A1(n190), .B0(n58), .B1(n65), .C0(n142), .Y(n96) );
  OAI222X1M U180 ( .A0(n90), .A1(n179), .B0(B[3]), .B1(n91), .C0(n53), .C1(
        n190), .Y(n89) );
  AOI221X2M U181 ( .A0(n126), .A1(n145), .B0(n147), .B1(n189), .C0(n143), .Y(
        n91) );
  AOI221X2M U182 ( .A0(n146), .A1(n189), .B0(n126), .B1(n65), .C0(n141), .Y(
        n90) );
  OAI2B2X1M U183 ( .A1N(B[1]), .A0(n103), .B0(n53), .B1(n192), .Y(n102) );
  AOI221X2M U184 ( .A0(n146), .A1(n191), .B0(n45), .B1(n65), .C0(n141), .Y(
        n103) );
  OAI2B2X1M U185 ( .A1N(B[0]), .A0(n115), .B0(n108), .B1(n191), .Y(n114) );
  AOI221X2M U186 ( .A0(n145), .A1(n192), .B0(n42), .B1(n65), .C0(n142), .Y(
        n115) );
  OAI21X2M U187 ( .A0(B[0]), .A1(n119), .B0(n120), .Y(n113) );
  AOI31X2M U188 ( .A0(N157), .A1(n40), .A2(n121), .B0(n107), .Y(n120) );
  AOI221X2M U189 ( .A0(n42), .A1(n145), .B0(n147), .B1(n192), .C0(n143), .Y(
        n119) );
  NOR3X2M U190 ( .A(n199), .B(ALU_FUN[2]), .C(ALU_FUN[0]), .Y(n121) );
  OAI21X2M U191 ( .A0(B[1]), .A1(n104), .B0(n105), .Y(n101) );
  AOI31X2M U192 ( .A0(N158), .A1(n40), .A2(n106), .B0(n107), .Y(n105) );
  AOI221X2M U193 ( .A0(n45), .A1(n145), .B0(n147), .B1(n191), .C0(n143), .Y(
        n104) );
  NOR3X2M U194 ( .A(n196), .B(ALU_FUN[2]), .C(n199), .Y(n106) );
  INVX2M U195 ( .A(B[0]), .Y(n177) );
  INVX2M U196 ( .A(B[2]), .Y(n178) );
  INVX2M U197 ( .A(B[3]), .Y(n179) );
  INVX2M U198 ( .A(A[2]), .Y(n46) );
  INVX2M U199 ( .A(A[3]), .Y(n59) );
  INVX2M U200 ( .A(A[4]), .Y(n127) );
  INVX2M U201 ( .A(A[5]), .Y(n130) );
  INVX2M U202 ( .A(A[1]), .Y(n43) );
  INVX2M U203 ( .A(A[6]), .Y(n133) );
  INVX2M U204 ( .A(A[7]), .Y(n136) );
  NAND2BX1M U205 ( .AN(B[4]), .B(n129), .Y(n166) );
  NAND2BX1M U206 ( .AN(n129), .B(B[4]), .Y(n155) );
  CLKNAND2X2M U207 ( .A(n166), .B(n155), .Y(n168) );
  CLKNAND2X2M U208 ( .A(n58), .B(n178), .Y(n165) );
  AOI21X1M U209 ( .A0(n151), .A1(n43), .B0(B[1]), .Y(n152) );
  CLKNAND2X2M U210 ( .A(n126), .B(n179), .Y(n164) );
  NAND2BX1M U211 ( .AN(n132), .B(B[5]), .Y(n171) );
  OAI211X1M U212 ( .A0(n168), .A1(n156), .B0(n155), .C0(n171), .Y(n157) );
  NAND2BX1M U213 ( .AN(B[5]), .B(n132), .Y(n167) );
  AOI32X1M U214 ( .A0(n157), .A1(n167), .A2(n170), .B0(n41), .B1(n133), .Y(
        n158) );
  CLKNAND2X2M U215 ( .A(B[7]), .B(n136), .Y(n174) );
  CLKNAND2X2M U216 ( .A(n42), .B(n177), .Y(n161) );
  OA21X1M U217 ( .A0(n161), .A1(n191), .B0(B[1]), .Y(n159) );
  AOI31X1M U218 ( .A0(n182), .A1(n165), .A2(n164), .B0(n163), .Y(n169) );
  OAI2B11X1M U219 ( .A1N(n169), .A0(n168), .B0(n167), .C0(n166), .Y(n172) );
  AOI32X1M U220 ( .A0(n172), .A1(n171), .A2(n170), .B0(n135), .B1(n180), .Y(
        n175) );
  NOR2X1M U221 ( .A(N159), .B(N158), .Y(N157) );
  ALU_DW_div_uns_0 div_50 ( .a({n137, n134, n131, n128, n125, n47, n44, n42}), 
        .b({B[7], n41, B[5:0]}), .quotient({N132, N131, N130, N129, N128, N127, 
        N126, N125}), .remainder({SYNOPSYS_UNCONNECTED_1, 
        SYNOPSYS_UNCONNECTED_2, SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4, 
        SYNOPSYS_UNCONNECTED_5, SYNOPSYS_UNCONNECTED_6, SYNOPSYS_UNCONNECTED_7, 
        SYNOPSYS_UNCONNECTED_8}) );
  ALU_DW01_sub_0 sub_44 ( .A({1'b0, n137, n134, n131, n128, n125, n47, n44, 
        n42}), .B({1'b0, B[7], n41, B[5:0]}), .CI(1'b0), .DIFF({N108, N107, 
        N106, N105, N104, N103, N102, N101, N100}) );
  ALU_DW01_add_0 add_41 ( .A({1'b0, n137, n134, n131, n128, n125, n47, n44, 
        n42}), .B({1'b0, B[7], n41, B[5:0]}), .CI(1'b0), .SUM({N99, N98, N97, 
        N96, N95, N94, N93, N92, N91}) );
  ALU_DW02_mult_0 mult_47 ( .A({n137, n134, n131, n128, n125, n47, n44, n42}), 
        .B({B[7], n41, B[5:0]}), .TC(1'b0), .PRODUCT({N124, N123, N122, N121, 
        N120, N119, N118, N117, N116, N115, N114, N113, N112, N111, N110, N109}) );
endmodule


module CLK_GATE ( CLK_EN, CLK, GATED_CLK );
  input CLK_EN, CLK;
  output GATED_CLK;


  TLATNCAX12M U0_TLATNCAX12M ( .E(CLK_EN), .CK(CLK), .ECK(GATED_CLK) );
endmodule


module RST_SYNC_test_0 ( CLK, RST, SYNC_RST, test_si, test_se );
  input CLK, RST, test_si, test_se;
  output SYNC_RST;
  wire   sync_reg_0_;

  SDFFRQX2M sync_reg_reg_0_ ( .D(1'b1), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(sync_reg_0_) );
  SDFFRQX1M sync_reg_reg_1_ ( .D(sync_reg_0_), .SI(sync_reg_0_), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(SYNC_RST) );
endmodule


module RST_SYNC_test_1 ( CLK, RST, SYNC_RST, test_si, test_se );
  input CLK, RST, test_si, test_se;
  output SYNC_RST;
  wire   sync_reg_0_;

  SDFFRQX1M sync_reg_reg_0_ ( .D(1'b1), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(sync_reg_0_) );
  SDFFRQX1M sync_reg_reg_1_ ( .D(sync_reg_0_), .SI(sync_reg_0_), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(SYNC_RST) );
endmodule


module FIFO_MEM_CNTRL_test_1 ( Wdata, Winc, Rinc, W_CLK, W_RST, Wfull, W_addr, 
        R_addr, Rdata, test_si2, test_si1, test_so2, test_so1, test_se );
  input [7:0] Wdata;
  input [3:0] W_addr;
  input [3:0] R_addr;
  output [7:0] Rdata;
  input Winc, Rinc, W_CLK, W_RST, Wfull, test_si2, test_si1, test_se;
  output test_so2, test_so1;
  wire   FIFO_MEM_0__7_, FIFO_MEM_0__6_, FIFO_MEM_0__5_, FIFO_MEM_0__4_,
         FIFO_MEM_0__3_, FIFO_MEM_0__2_, FIFO_MEM_0__1_, FIFO_MEM_0__0_,
         FIFO_MEM_1__7_, FIFO_MEM_1__6_, FIFO_MEM_1__5_, FIFO_MEM_1__4_,
         FIFO_MEM_1__3_, FIFO_MEM_1__2_, FIFO_MEM_1__1_, FIFO_MEM_1__0_,
         FIFO_MEM_2__7_, FIFO_MEM_2__6_, FIFO_MEM_2__5_, FIFO_MEM_2__4_,
         FIFO_MEM_2__3_, FIFO_MEM_2__2_, FIFO_MEM_2__1_, FIFO_MEM_2__0_,
         FIFO_MEM_3__7_, FIFO_MEM_3__6_, FIFO_MEM_3__5_, FIFO_MEM_3__4_,
         FIFO_MEM_3__2_, FIFO_MEM_3__1_, FIFO_MEM_3__0_, FIFO_MEM_4__7_,
         FIFO_MEM_4__6_, FIFO_MEM_4__5_, FIFO_MEM_4__4_, FIFO_MEM_4__3_,
         FIFO_MEM_4__2_, FIFO_MEM_4__1_, FIFO_MEM_4__0_, FIFO_MEM_5__7_,
         FIFO_MEM_5__6_, FIFO_MEM_5__5_, FIFO_MEM_5__4_, FIFO_MEM_5__3_,
         FIFO_MEM_5__2_, FIFO_MEM_5__1_, FIFO_MEM_5__0_, FIFO_MEM_6__7_,
         FIFO_MEM_6__6_, FIFO_MEM_6__5_, FIFO_MEM_6__4_, FIFO_MEM_6__3_,
         FIFO_MEM_6__2_, FIFO_MEM_6__1_, FIFO_MEM_6__0_, FIFO_MEM_7__7_,
         FIFO_MEM_7__6_, FIFO_MEM_7__5_, FIFO_MEM_7__4_, FIFO_MEM_7__3_,
         FIFO_MEM_7__2_, FIFO_MEM_7__1_, FIFO_MEM_7__0_, n77, n79, n83, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n150, n197, n198, n199, n200, n201,
         n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n212,
         n213, n214, n215, n216, n217, n218, n219, n220, n221, n222, n223,
         n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n264, n265, n266, n267, n268, n269, n270,
         n271, n272, n273, n274, n275, n276, n277, n278, n279, n280, n281,
         n282, n283, n284, n285, n286, n287, n288, n289, n290, n291, n292,
         n293, n294, n295, n296, n297, n298, n299, n300, n301, n302, n303,
         n304, n305, n306, n307, n308, n309, n310, n312, n313, n314, n315,
         n316, n317, n318, n319, n320, n321, n322, n323, n324, n325, n326,
         n327;

  SDFFRQX1M FIFO_MEM_reg_4__7_ ( .D(n118), .SI(n326), .SE(test_se), .CK(W_CLK), 
        .RN(n245), .Q(FIFO_MEM_4__7_) );
  SDFFRQX1M FIFO_MEM_reg_4__6_ ( .D(n117), .SI(n325), .SE(test_se), .CK(W_CLK), 
        .RN(n245), .Q(FIFO_MEM_4__6_) );
  SDFFRQX1M FIFO_MEM_reg_4__5_ ( .D(n116), .SI(n324), .SE(test_se), .CK(W_CLK), 
        .RN(n245), .Q(FIFO_MEM_4__5_) );
  SDFFRQX1M FIFO_MEM_reg_4__4_ ( .D(n115), .SI(n323), .SE(test_se), .CK(W_CLK), 
        .RN(n245), .Q(FIFO_MEM_4__4_) );
  SDFFRQX1M FIFO_MEM_reg_4__3_ ( .D(n114), .SI(n322), .SE(test_se), .CK(W_CLK), 
        .RN(n246), .Q(FIFO_MEM_4__3_) );
  SDFFRQX1M FIFO_MEM_reg_4__2_ ( .D(n113), .SI(n321), .SE(test_se), .CK(W_CLK), 
        .RN(n246), .Q(FIFO_MEM_4__2_) );
  SDFFRQX1M FIFO_MEM_reg_4__1_ ( .D(n112), .SI(n320), .SE(test_se), .CK(W_CLK), 
        .RN(n246), .Q(FIFO_MEM_4__1_) );
  SDFFRQX1M FIFO_MEM_reg_4__0_ ( .D(n111), .SI(n303), .SE(test_se), .CK(W_CLK), 
        .RN(n246), .Q(FIFO_MEM_4__0_) );
  SDFFRQX1M FIFO_MEM_reg_7__7_ ( .D(n94), .SI(n310), .SE(test_se), .CK(W_CLK), 
        .RN(n247), .Q(FIFO_MEM_7__7_) );
  SDFFRQX1M FIFO_MEM_reg_7__6_ ( .D(n93), .SI(n309), .SE(test_se), .CK(W_CLK), 
        .RN(n247), .Q(FIFO_MEM_7__6_) );
  SDFFRQX1M FIFO_MEM_reg_7__5_ ( .D(n92), .SI(n308), .SE(test_se), .CK(W_CLK), 
        .RN(n247), .Q(FIFO_MEM_7__5_) );
  SDFFRQX1M FIFO_MEM_reg_7__4_ ( .D(n91), .SI(n307), .SE(test_se), .CK(W_CLK), 
        .RN(n247), .Q(FIFO_MEM_7__4_) );
  SDFFRQX1M FIFO_MEM_reg_7__3_ ( .D(n90), .SI(n306), .SE(test_se), .CK(W_CLK), 
        .RN(n248), .Q(FIFO_MEM_7__3_) );
  SDFFRQX1M FIFO_MEM_reg_7__2_ ( .D(n89), .SI(n305), .SE(test_se), .CK(W_CLK), 
        .RN(n248), .Q(FIFO_MEM_7__2_) );
  SDFFRQX1M FIFO_MEM_reg_7__1_ ( .D(n88), .SI(n304), .SE(test_se), .CK(W_CLK), 
        .RN(n248), .Q(FIFO_MEM_7__1_) );
  SDFFRQX1M FIFO_MEM_reg_7__0_ ( .D(n87), .SI(n280), .SE(test_se), .CK(W_CLK), 
        .RN(n248), .Q(FIFO_MEM_7__0_) );
  SDFFRQX1M FIFO_MEM_reg_6__7_ ( .D(n102), .SI(n279), .SE(test_se), .CK(W_CLK), 
        .RN(n247), .Q(FIFO_MEM_6__7_) );
  SDFFRQX1M FIFO_MEM_reg_6__6_ ( .D(n101), .SI(n278), .SE(test_se), .CK(W_CLK), 
        .RN(n247), .Q(FIFO_MEM_6__6_) );
  SDFFRQX1M FIFO_MEM_reg_6__5_ ( .D(n100), .SI(n277), .SE(test_se), .CK(W_CLK), 
        .RN(n247), .Q(FIFO_MEM_6__5_) );
  SDFFRQX1M FIFO_MEM_reg_6__4_ ( .D(n99), .SI(n276), .SE(test_se), .CK(W_CLK), 
        .RN(n247), .Q(FIFO_MEM_6__4_) );
  SDFFRQX1M FIFO_MEM_reg_6__3_ ( .D(n98), .SI(n275), .SE(test_se), .CK(W_CLK), 
        .RN(n247), .Q(FIFO_MEM_6__3_) );
  SDFFRQX1M FIFO_MEM_reg_6__2_ ( .D(n97), .SI(n274), .SE(test_se), .CK(W_CLK), 
        .RN(n247), .Q(FIFO_MEM_6__2_) );
  SDFFRQX1M FIFO_MEM_reg_6__1_ ( .D(n96), .SI(n273), .SE(test_se), .CK(W_CLK), 
        .RN(n247), .Q(FIFO_MEM_6__1_) );
  SDFFRQX1M FIFO_MEM_reg_6__0_ ( .D(n95), .SI(n296), .SE(test_se), .CK(W_CLK), 
        .RN(n247), .Q(FIFO_MEM_6__0_) );
  SDFFRQX1M FIFO_MEM_reg_5__7_ ( .D(n110), .SI(n295), .SE(test_se), .CK(W_CLK), 
        .RN(n246), .Q(FIFO_MEM_5__7_) );
  SDFFRQX1M FIFO_MEM_reg_5__6_ ( .D(n109), .SI(n294), .SE(test_se), .CK(W_CLK), 
        .RN(n246), .Q(FIFO_MEM_5__6_) );
  SDFFRQX1M FIFO_MEM_reg_5__5_ ( .D(n108), .SI(n293), .SE(test_se), .CK(W_CLK), 
        .RN(n246), .Q(FIFO_MEM_5__5_) );
  SDFFRQX1M FIFO_MEM_reg_5__4_ ( .D(n107), .SI(n292), .SE(test_se), .CK(W_CLK), 
        .RN(n246), .Q(FIFO_MEM_5__4_) );
  SDFFRQX1M FIFO_MEM_reg_5__3_ ( .D(n106), .SI(n291), .SE(test_se), .CK(W_CLK), 
        .RN(n246), .Q(FIFO_MEM_5__3_) );
  SDFFRQX1M FIFO_MEM_reg_5__2_ ( .D(n105), .SI(n290), .SE(test_se), .CK(W_CLK), 
        .RN(n246), .Q(FIFO_MEM_5__2_) );
  SDFFRQX1M FIFO_MEM_reg_5__1_ ( .D(n104), .SI(n289), .SE(test_se), .CK(W_CLK), 
        .RN(n246), .Q(FIFO_MEM_5__1_) );
  SDFFRQX1M FIFO_MEM_reg_5__0_ ( .D(n103), .SI(n327), .SE(test_se), .CK(W_CLK), 
        .RN(n246), .Q(FIFO_MEM_5__0_) );
  SDFFRQX1M FIFO_MEM_reg_1__7_ ( .D(n142), .SI(n287), .SE(test_se), .CK(W_CLK), 
        .RN(n243), .Q(FIFO_MEM_1__7_) );
  SDFFRQX1M FIFO_MEM_reg_1__6_ ( .D(n141), .SI(n286), .SE(test_se), .CK(W_CLK), 
        .RN(n243), .Q(FIFO_MEM_1__6_) );
  SDFFRQX1M FIFO_MEM_reg_1__5_ ( .D(n140), .SI(n285), .SE(test_se), .CK(W_CLK), 
        .RN(n243), .Q(FIFO_MEM_1__5_) );
  SDFFRQX1M FIFO_MEM_reg_1__4_ ( .D(n139), .SI(n284), .SE(test_se), .CK(W_CLK), 
        .RN(n243), .Q(FIFO_MEM_1__4_) );
  SDFFRQX1M FIFO_MEM_reg_1__3_ ( .D(n138), .SI(n283), .SE(test_se), .CK(W_CLK), 
        .RN(n244), .Q(FIFO_MEM_1__3_) );
  SDFFRQX1M FIFO_MEM_reg_1__2_ ( .D(n137), .SI(n282), .SE(test_se), .CK(W_CLK), 
        .RN(n244), .Q(FIFO_MEM_1__2_) );
  SDFFRQX1M FIFO_MEM_reg_1__1_ ( .D(n136), .SI(n281), .SE(test_se), .CK(W_CLK), 
        .RN(n244), .Q(FIFO_MEM_1__1_) );
  SDFFRQX1M FIFO_MEM_reg_1__0_ ( .D(n135), .SI(n319), .SE(test_se), .CK(W_CLK), 
        .RN(n244), .Q(FIFO_MEM_1__0_) );
  SDFFRQX1M FIFO_MEM_reg_0__7_ ( .D(n150), .SI(n318), .SE(test_se), .CK(W_CLK), 
        .RN(n243), .Q(FIFO_MEM_0__7_) );
  SDFFRQX1M FIFO_MEM_reg_0__6_ ( .D(n149), .SI(n317), .SE(test_se), .CK(W_CLK), 
        .RN(n243), .Q(FIFO_MEM_0__6_) );
  SDFFRQX1M FIFO_MEM_reg_0__5_ ( .D(n148), .SI(n316), .SE(test_se), .CK(W_CLK), 
        .RN(n243), .Q(FIFO_MEM_0__5_) );
  SDFFRQX1M FIFO_MEM_reg_0__4_ ( .D(n147), .SI(n315), .SE(test_se), .CK(W_CLK), 
        .RN(n243), .Q(FIFO_MEM_0__4_) );
  SDFFRQX1M FIFO_MEM_reg_0__3_ ( .D(n146), .SI(n314), .SE(test_se), .CK(W_CLK), 
        .RN(n243), .Q(FIFO_MEM_0__3_) );
  SDFFRQX1M FIFO_MEM_reg_0__2_ ( .D(n145), .SI(n313), .SE(test_se), .CK(W_CLK), 
        .RN(n243), .Q(FIFO_MEM_0__2_) );
  SDFFRQX1M FIFO_MEM_reg_0__1_ ( .D(n144), .SI(n312), .SE(test_se), .CK(W_CLK), 
        .RN(n243), .Q(FIFO_MEM_0__1_) );
  SDFFRQX1M FIFO_MEM_reg_0__0_ ( .D(n143), .SI(test_si1), .SE(test_se), .CK(
        W_CLK), .RN(n243), .Q(FIFO_MEM_0__0_) );
  SDFFRQX1M FIFO_MEM_reg_3__7_ ( .D(n126), .SI(n302), .SE(test_se), .CK(W_CLK), 
        .RN(n245), .Q(FIFO_MEM_3__7_) );
  SDFFRQX1M FIFO_MEM_reg_3__6_ ( .D(n125), .SI(n301), .SE(test_se), .CK(W_CLK), 
        .RN(n245), .Q(FIFO_MEM_3__6_) );
  SDFFRQX1M FIFO_MEM_reg_3__5_ ( .D(n124), .SI(n300), .SE(test_se), .CK(W_CLK), 
        .RN(n245), .Q(FIFO_MEM_3__5_) );
  SDFFRQX1M FIFO_MEM_reg_3__4_ ( .D(n123), .SI(test_si2), .SE(test_se), .CK(
        W_CLK), .RN(n245), .Q(FIFO_MEM_3__4_) );
  SDFFRQX1M FIFO_MEM_reg_3__3_ ( .D(n122), .SI(n299), .SE(test_se), .CK(W_CLK), 
        .RN(n245), .Q(test_so1) );
  SDFFRQX1M FIFO_MEM_reg_3__2_ ( .D(n121), .SI(n298), .SE(test_se), .CK(W_CLK), 
        .RN(n245), .Q(FIFO_MEM_3__2_) );
  SDFFRQX1M FIFO_MEM_reg_3__1_ ( .D(n120), .SI(n297), .SE(test_se), .CK(W_CLK), 
        .RN(n245), .Q(FIFO_MEM_3__1_) );
  SDFFRQX1M FIFO_MEM_reg_3__0_ ( .D(n119), .SI(n272), .SE(test_se), .CK(W_CLK), 
        .RN(n245), .Q(FIFO_MEM_3__0_) );
  SDFFRQX1M FIFO_MEM_reg_2__7_ ( .D(n134), .SI(n271), .SE(test_se), .CK(W_CLK), 
        .RN(n244), .Q(FIFO_MEM_2__7_) );
  SDFFRQX1M FIFO_MEM_reg_2__6_ ( .D(n133), .SI(n270), .SE(test_se), .CK(W_CLK), 
        .RN(n244), .Q(FIFO_MEM_2__6_) );
  SDFFRQX1M FIFO_MEM_reg_2__5_ ( .D(n132), .SI(n269), .SE(test_se), .CK(W_CLK), 
        .RN(n244), .Q(FIFO_MEM_2__5_) );
  SDFFRQX1M FIFO_MEM_reg_2__4_ ( .D(n131), .SI(n268), .SE(test_se), .CK(W_CLK), 
        .RN(n244), .Q(FIFO_MEM_2__4_) );
  SDFFRQX1M FIFO_MEM_reg_2__3_ ( .D(n130), .SI(n267), .SE(test_se), .CK(W_CLK), 
        .RN(n244), .Q(FIFO_MEM_2__3_) );
  SDFFRQX1M FIFO_MEM_reg_2__2_ ( .D(n129), .SI(n266), .SE(test_se), .CK(W_CLK), 
        .RN(n244), .Q(FIFO_MEM_2__2_) );
  SDFFRQX1M FIFO_MEM_reg_2__1_ ( .D(n128), .SI(n265), .SE(test_se), .CK(W_CLK), 
        .RN(n244), .Q(FIFO_MEM_2__1_) );
  SDFFRQX1M FIFO_MEM_reg_2__0_ ( .D(n127), .SI(n288), .SE(test_se), .CK(W_CLK), 
        .RN(n244), .Q(FIFO_MEM_2__0_) );
  NOR2X1M U66 ( .A(Wfull), .B(W_addr[3]), .Y(n86) );
  AND3X1M U67 ( .A(W_addr[0]), .B(n77), .C(W_addr[1]), .Y(n202) );
  CLKINVX2M U68 ( .A(W_addr[0]), .Y(n251) );
  AND3X1M U69 ( .A(n79), .B(W_addr[0]), .C(W_addr[1]), .Y(n201) );
  AND3X1M U70 ( .A(n77), .B(n252), .C(W_addr[0]), .Y(n203) );
  NOR2BX4M U135 ( .AN(n83), .B(W_addr[2]), .Y(n79) );
  AND2X2M U136 ( .A(W_addr[2]), .B(n83), .Y(n77) );
  INVX2M U137 ( .A(W_addr[1]), .Y(n252) );
  BUFX6M U138 ( .A(n250), .Y(n247) );
  BUFX6M U139 ( .A(n249), .Y(n246) );
  BUFX6M U140 ( .A(n249), .Y(n245) );
  BUFX6M U141 ( .A(n250), .Y(n244) );
  BUFX6M U142 ( .A(n250), .Y(n243) );
  BUFX2M U143 ( .A(n249), .Y(n248) );
  BUFX2M U144 ( .A(n250), .Y(n249) );
  INVX4M U145 ( .A(n197), .Y(n234) );
  INVX4M U146 ( .A(n197), .Y(n233) );
  INVX4M U147 ( .A(n198), .Y(n242) );
  INVX4M U148 ( .A(n198), .Y(n241) );
  BUFX2M U149 ( .A(W_RST), .Y(n250) );
  INVX4M U150 ( .A(n201), .Y(n240) );
  INVX4M U151 ( .A(n201), .Y(n239) );
  INVX4M U152 ( .A(n199), .Y(n238) );
  INVX4M U153 ( .A(n199), .Y(n237) );
  INVX4M U154 ( .A(n200), .Y(n236) );
  INVX4M U155 ( .A(n200), .Y(n235) );
  AND3X2M U156 ( .A(n251), .B(n252), .C(n79), .Y(n197) );
  INVX4M U157 ( .A(n204), .Y(n230) );
  INVX4M U158 ( .A(n204), .Y(n229) );
  INVX4M U159 ( .A(n202), .Y(n232) );
  INVX4M U160 ( .A(n202), .Y(n231) );
  INVX4M U161 ( .A(n203), .Y(n228) );
  INVX4M U162 ( .A(n203), .Y(n227) );
  AND3X2M U163 ( .A(n251), .B(n252), .C(n77), .Y(n198) );
  INVX6M U164 ( .A(n223), .Y(n222) );
  INVX6M U165 ( .A(n223), .Y(n221) );
  INVX4M U166 ( .A(n226), .Y(n225) );
  INVX4M U167 ( .A(n226), .Y(n224) );
  OAI2BB2X1M U168 ( .B0(n260), .B1(n240), .A0N(n297), .A1N(n240), .Y(n119) );
  OAI2BB2X1M U169 ( .B0(n259), .B1(n239), .A0N(n298), .A1N(n239), .Y(n120) );
  OAI2BB2X1M U170 ( .B0(n260), .B1(n238), .A0N(n265), .A1N(n238), .Y(n127) );
  OAI2BB2X1M U171 ( .B0(n259), .B1(n237), .A0N(n266), .A1N(n237), .Y(n128) );
  OAI2BB2X1M U172 ( .B0(n260), .B1(n236), .A0N(n281), .A1N(n236), .Y(n135) );
  OAI2BB2X1M U173 ( .B0(n259), .B1(n235), .A0N(n282), .A1N(n235), .Y(n136) );
  OAI2BB2X1M U174 ( .B0(n260), .B1(n234), .A0N(n312), .A1N(n234), .Y(n143) );
  OAI2BB2X1M U175 ( .B0(n259), .B1(n233), .A0N(n313), .A1N(n233), .Y(n144) );
  OAI2BB2X1M U176 ( .B0(n258), .B1(n240), .A0N(n299), .A1N(n240), .Y(n121) );
  OAI2BB2X1M U177 ( .B0(n257), .B1(n239), .A0N(n264), .A1N(n239), .Y(n122) );
  OAI2BB2X1M U178 ( .B0(n256), .B1(n240), .A0N(n300), .A1N(n240), .Y(n123) );
  OAI2BB2X1M U179 ( .B0(n255), .B1(n239), .A0N(n301), .A1N(n239), .Y(n124) );
  OAI2BB2X1M U180 ( .B0(n254), .B1(n240), .A0N(n302), .A1N(n240), .Y(n125) );
  OAI2BB2X1M U181 ( .B0(n253), .B1(n239), .A0N(n303), .A1N(n239), .Y(n126) );
  OAI2BB2X1M U182 ( .B0(n258), .B1(n238), .A0N(n267), .A1N(n238), .Y(n129) );
  OAI2BB2X1M U183 ( .B0(n257), .B1(n237), .A0N(n268), .A1N(n237), .Y(n130) );
  OAI2BB2X1M U184 ( .B0(n256), .B1(n238), .A0N(n269), .A1N(n238), .Y(n131) );
  OAI2BB2X1M U185 ( .B0(n255), .B1(n237), .A0N(n270), .A1N(n237), .Y(n132) );
  OAI2BB2X1M U186 ( .B0(n254), .B1(n238), .A0N(n271), .A1N(n238), .Y(n133) );
  OAI2BB2X1M U187 ( .B0(n253), .B1(n237), .A0N(n272), .A1N(n237), .Y(n134) );
  OAI2BB2X1M U188 ( .B0(n258), .B1(n236), .A0N(n283), .A1N(n236), .Y(n137) );
  OAI2BB2X1M U189 ( .B0(n257), .B1(n235), .A0N(n284), .A1N(n235), .Y(n138) );
  OAI2BB2X1M U190 ( .B0(n256), .B1(n236), .A0N(n285), .A1N(n236), .Y(n139) );
  OAI2BB2X1M U191 ( .B0(n255), .B1(n235), .A0N(n286), .A1N(n235), .Y(n140) );
  OAI2BB2X1M U192 ( .B0(n254), .B1(n236), .A0N(n287), .A1N(n236), .Y(n141) );
  OAI2BB2X1M U193 ( .B0(n253), .B1(n235), .A0N(n288), .A1N(n235), .Y(n142) );
  OAI2BB2X1M U194 ( .B0(n258), .B1(n234), .A0N(n314), .A1N(n234), .Y(n145) );
  OAI2BB2X1M U195 ( .B0(n257), .B1(n233), .A0N(n315), .A1N(n233), .Y(n146) );
  OAI2BB2X1M U196 ( .B0(n256), .B1(n234), .A0N(n316), .A1N(n234), .Y(n147) );
  OAI2BB2X1M U197 ( .B0(n255), .B1(n233), .A0N(n317), .A1N(n233), .Y(n148) );
  OAI2BB2X1M U198 ( .B0(n254), .B1(n234), .A0N(n318), .A1N(n234), .Y(n149) );
  OAI2BB2X1M U199 ( .B0(n253), .B1(n233), .A0N(n319), .A1N(n233), .Y(n150) );
  AND3X2M U200 ( .A(n79), .B(n251), .C(W_addr[1]), .Y(n199) );
  AND3X2M U201 ( .A(W_addr[0]), .B(n252), .C(n79), .Y(n200) );
  AND2X2M U202 ( .A(n86), .B(Winc), .Y(n83) );
  INVX4M U203 ( .A(Wdata[0]), .Y(n260) );
  INVX4M U204 ( .A(Wdata[1]), .Y(n259) );
  INVX4M U205 ( .A(Wdata[2]), .Y(n258) );
  INVX4M U206 ( .A(Wdata[3]), .Y(n257) );
  INVX4M U207 ( .A(Wdata[4]), .Y(n256) );
  INVX4M U208 ( .A(Wdata[5]), .Y(n255) );
  INVX4M U209 ( .A(Wdata[6]), .Y(n254) );
  INVX4M U210 ( .A(Wdata[7]), .Y(n253) );
  OAI2BB2X1M U211 ( .B0(n260), .B1(n232), .A0N(n304), .A1N(n232), .Y(n87) );
  OAI2BB2X1M U212 ( .B0(n259), .B1(n231), .A0N(n305), .A1N(n231), .Y(n88) );
  OAI2BB2X1M U213 ( .B0(n260), .B1(n230), .A0N(n273), .A1N(n230), .Y(n95) );
  OAI2BB2X1M U214 ( .B0(n259), .B1(n229), .A0N(n274), .A1N(n229), .Y(n96) );
  OAI2BB2X1M U215 ( .B0(n258), .B1(n232), .A0N(n306), .A1N(n232), .Y(n89) );
  OAI2BB2X1M U216 ( .B0(n257), .B1(n231), .A0N(n307), .A1N(n231), .Y(n90) );
  OAI2BB2X1M U217 ( .B0(n256), .B1(n232), .A0N(n308), .A1N(n232), .Y(n91) );
  OAI2BB2X1M U218 ( .B0(n255), .B1(n231), .A0N(n309), .A1N(n231), .Y(n92) );
  OAI2BB2X1M U219 ( .B0(n254), .B1(n232), .A0N(n310), .A1N(n232), .Y(n93) );
  OAI2BB2X1M U220 ( .B0(n253), .B1(n231), .A0N(test_so2), .A1N(n231), .Y(n94)
         );
  OAI2BB2X1M U221 ( .B0(n258), .B1(n230), .A0N(n275), .A1N(n230), .Y(n97) );
  OAI2BB2X1M U222 ( .B0(n257), .B1(n229), .A0N(n276), .A1N(n229), .Y(n98) );
  OAI2BB2X1M U223 ( .B0(n256), .B1(n230), .A0N(n277), .A1N(n230), .Y(n99) );
  OAI2BB2X1M U224 ( .B0(n255), .B1(n229), .A0N(n278), .A1N(n229), .Y(n100) );
  OAI2BB2X1M U225 ( .B0(n254), .B1(n230), .A0N(n279), .A1N(n230), .Y(n101) );
  OAI2BB2X1M U226 ( .B0(n253), .B1(n229), .A0N(n280), .A1N(n229), .Y(n102) );
  OAI2BB2X1M U227 ( .B0(n258), .B1(n242), .A0N(n322), .A1N(n242), .Y(n113) );
  OAI2BB2X1M U228 ( .B0(n257), .B1(n241), .A0N(n323), .A1N(n241), .Y(n114) );
  OAI2BB2X1M U229 ( .B0(n256), .B1(n242), .A0N(n324), .A1N(n242), .Y(n115) );
  OAI2BB2X1M U230 ( .B0(n255), .B1(n241), .A0N(n325), .A1N(n241), .Y(n116) );
  OAI2BB2X1M U231 ( .B0(n254), .B1(n242), .A0N(n326), .A1N(n242), .Y(n117) );
  OAI2BB2X1M U232 ( .B0(n253), .B1(n241), .A0N(n327), .A1N(n241), .Y(n118) );
  OAI2BB2X1M U233 ( .B0(n228), .B1(n260), .A0N(n289), .A1N(n228), .Y(n103) );
  OAI2BB2X1M U234 ( .B0(n227), .B1(n259), .A0N(n290), .A1N(n227), .Y(n104) );
  OAI2BB2X1M U235 ( .B0(n242), .B1(n260), .A0N(n320), .A1N(n242), .Y(n111) );
  OAI2BB2X1M U236 ( .B0(n241), .B1(n259), .A0N(n321), .A1N(n241), .Y(n112) );
  OAI2BB2X1M U237 ( .B0(n228), .B1(n258), .A0N(n291), .A1N(n228), .Y(n105) );
  OAI2BB2X1M U238 ( .B0(n227), .B1(n257), .A0N(n292), .A1N(n227), .Y(n106) );
  OAI2BB2X1M U239 ( .B0(n228), .B1(n256), .A0N(n293), .A1N(n228), .Y(n107) );
  OAI2BB2X1M U240 ( .B0(n227), .B1(n255), .A0N(n294), .A1N(n227), .Y(n108) );
  OAI2BB2X1M U241 ( .B0(n228), .B1(n254), .A0N(n295), .A1N(n228), .Y(n109) );
  OAI2BB2X1M U242 ( .B0(n227), .B1(n253), .A0N(n296), .A1N(n227), .Y(n110) );
  AND3X2M U243 ( .A(n77), .B(n251), .C(W_addr[1]), .Y(n204) );
  MX2X2M U244 ( .A(n206), .B(n205), .S0(R_addr[2]), .Y(Rdata[0]) );
  MX4X1M U245 ( .A(FIFO_MEM_4__0_), .B(FIFO_MEM_5__0_), .C(FIFO_MEM_6__0_), 
        .D(FIFO_MEM_7__0_), .S0(n221), .S1(n224), .Y(n205) );
  MX4X1M U246 ( .A(FIFO_MEM_0__0_), .B(FIFO_MEM_1__0_), .C(FIFO_MEM_2__0_), 
        .D(FIFO_MEM_3__0_), .S0(n222), .S1(n225), .Y(n206) );
  MX2X2M U247 ( .A(n208), .B(n207), .S0(R_addr[2]), .Y(Rdata[1]) );
  MX4X1M U248 ( .A(FIFO_MEM_4__1_), .B(FIFO_MEM_5__1_), .C(FIFO_MEM_6__1_), 
        .D(FIFO_MEM_7__1_), .S0(n221), .S1(n224), .Y(n207) );
  MX4X1M U249 ( .A(FIFO_MEM_0__1_), .B(FIFO_MEM_1__1_), .C(FIFO_MEM_2__1_), 
        .D(FIFO_MEM_3__1_), .S0(n222), .S1(n225), .Y(n208) );
  MX2X2M U250 ( .A(n210), .B(n209), .S0(R_addr[2]), .Y(Rdata[2]) );
  MX4X1M U251 ( .A(FIFO_MEM_4__2_), .B(FIFO_MEM_5__2_), .C(FIFO_MEM_6__2_), 
        .D(FIFO_MEM_7__2_), .S0(n221), .S1(n224), .Y(n209) );
  MX4X1M U252 ( .A(FIFO_MEM_0__2_), .B(FIFO_MEM_1__2_), .C(FIFO_MEM_2__2_), 
        .D(FIFO_MEM_3__2_), .S0(n222), .S1(n225), .Y(n210) );
  MX2X2M U253 ( .A(n212), .B(n211), .S0(R_addr[2]), .Y(Rdata[3]) );
  MX4X1M U254 ( .A(FIFO_MEM_4__3_), .B(FIFO_MEM_5__3_), .C(FIFO_MEM_6__3_), 
        .D(FIFO_MEM_7__3_), .S0(n221), .S1(n224), .Y(n211) );
  MX4X1M U255 ( .A(FIFO_MEM_0__3_), .B(FIFO_MEM_1__3_), .C(FIFO_MEM_2__3_), 
        .D(n264), .S0(n222), .S1(n225), .Y(n212) );
  MX2X2M U256 ( .A(n214), .B(n213), .S0(R_addr[2]), .Y(Rdata[4]) );
  MX4X1M U257 ( .A(FIFO_MEM_4__4_), .B(FIFO_MEM_5__4_), .C(FIFO_MEM_6__4_), 
        .D(FIFO_MEM_7__4_), .S0(n221), .S1(n224), .Y(n213) );
  MX4X1M U258 ( .A(FIFO_MEM_0__4_), .B(FIFO_MEM_1__4_), .C(FIFO_MEM_2__4_), 
        .D(FIFO_MEM_3__4_), .S0(n222), .S1(n225), .Y(n214) );
  MX2X2M U259 ( .A(n216), .B(n215), .S0(R_addr[2]), .Y(Rdata[5]) );
  MX4X1M U260 ( .A(FIFO_MEM_4__5_), .B(FIFO_MEM_5__5_), .C(FIFO_MEM_6__5_), 
        .D(FIFO_MEM_7__5_), .S0(n221), .S1(n224), .Y(n215) );
  MX4X1M U261 ( .A(FIFO_MEM_0__5_), .B(FIFO_MEM_1__5_), .C(FIFO_MEM_2__5_), 
        .D(FIFO_MEM_3__5_), .S0(n222), .S1(n225), .Y(n216) );
  MX2X2M U262 ( .A(n218), .B(n217), .S0(R_addr[2]), .Y(Rdata[6]) );
  MX4X1M U263 ( .A(FIFO_MEM_4__6_), .B(FIFO_MEM_5__6_), .C(FIFO_MEM_6__6_), 
        .D(FIFO_MEM_7__6_), .S0(n221), .S1(n224), .Y(n217) );
  MX4X1M U264 ( .A(FIFO_MEM_0__6_), .B(FIFO_MEM_1__6_), .C(FIFO_MEM_2__6_), 
        .D(FIFO_MEM_3__6_), .S0(n222), .S1(n225), .Y(n218) );
  MX2X2M U265 ( .A(n220), .B(n219), .S0(R_addr[2]), .Y(Rdata[7]) );
  MX4X1M U266 ( .A(FIFO_MEM_4__7_), .B(FIFO_MEM_5__7_), .C(FIFO_MEM_6__7_), 
        .D(FIFO_MEM_7__7_), .S0(n221), .S1(n224), .Y(n219) );
  MX4X1M U267 ( .A(FIFO_MEM_0__7_), .B(FIFO_MEM_1__7_), .C(FIFO_MEM_2__7_), 
        .D(FIFO_MEM_3__7_), .S0(n222), .S1(n225), .Y(n220) );
  INVX2M U268 ( .A(R_addr[0]), .Y(n223) );
  INVX2M U269 ( .A(R_addr[1]), .Y(n226) );
  DLY1X1M U270 ( .A(test_so1), .Y(n264) );
  DLY1X1M U271 ( .A(FIFO_MEM_2__0_), .Y(n265) );
  DLY1X1M U272 ( .A(FIFO_MEM_2__1_), .Y(n266) );
  DLY1X1M U273 ( .A(FIFO_MEM_2__2_), .Y(n267) );
  DLY1X1M U274 ( .A(FIFO_MEM_2__3_), .Y(n268) );
  DLY1X1M U275 ( .A(FIFO_MEM_2__4_), .Y(n269) );
  DLY1X1M U276 ( .A(FIFO_MEM_2__5_), .Y(n270) );
  DLY1X1M U277 ( .A(FIFO_MEM_2__6_), .Y(n271) );
  DLY1X1M U278 ( .A(FIFO_MEM_2__7_), .Y(n272) );
  DLY1X1M U279 ( .A(FIFO_MEM_6__0_), .Y(n273) );
  DLY1X1M U280 ( .A(FIFO_MEM_6__1_), .Y(n274) );
  DLY1X1M U281 ( .A(FIFO_MEM_6__2_), .Y(n275) );
  DLY1X1M U282 ( .A(FIFO_MEM_6__3_), .Y(n276) );
  DLY1X1M U283 ( .A(FIFO_MEM_6__4_), .Y(n277) );
  DLY1X1M U284 ( .A(FIFO_MEM_6__5_), .Y(n278) );
  DLY1X1M U285 ( .A(FIFO_MEM_6__6_), .Y(n279) );
  DLY1X1M U286 ( .A(FIFO_MEM_6__7_), .Y(n280) );
  DLY1X1M U287 ( .A(FIFO_MEM_1__0_), .Y(n281) );
  DLY1X1M U288 ( .A(FIFO_MEM_1__1_), .Y(n282) );
  DLY1X1M U289 ( .A(FIFO_MEM_1__2_), .Y(n283) );
  DLY1X1M U290 ( .A(FIFO_MEM_1__3_), .Y(n284) );
  DLY1X1M U291 ( .A(FIFO_MEM_1__4_), .Y(n285) );
  DLY1X1M U292 ( .A(FIFO_MEM_1__5_), .Y(n286) );
  DLY1X1M U293 ( .A(FIFO_MEM_1__6_), .Y(n287) );
  DLY1X1M U294 ( .A(FIFO_MEM_1__7_), .Y(n288) );
  DLY1X1M U295 ( .A(FIFO_MEM_5__0_), .Y(n289) );
  DLY1X1M U296 ( .A(FIFO_MEM_5__1_), .Y(n290) );
  DLY1X1M U297 ( .A(FIFO_MEM_5__2_), .Y(n291) );
  DLY1X1M U298 ( .A(FIFO_MEM_5__3_), .Y(n292) );
  DLY1X1M U299 ( .A(FIFO_MEM_5__4_), .Y(n293) );
  DLY1X1M U300 ( .A(FIFO_MEM_5__5_), .Y(n294) );
  DLY1X1M U301 ( .A(FIFO_MEM_5__6_), .Y(n295) );
  DLY1X1M U302 ( .A(FIFO_MEM_5__7_), .Y(n296) );
  DLY1X1M U303 ( .A(FIFO_MEM_3__0_), .Y(n297) );
  DLY1X1M U304 ( .A(FIFO_MEM_3__1_), .Y(n298) );
  DLY1X1M U305 ( .A(FIFO_MEM_3__2_), .Y(n299) );
  DLY1X1M U306 ( .A(FIFO_MEM_3__4_), .Y(n300) );
  DLY1X1M U307 ( .A(FIFO_MEM_3__5_), .Y(n301) );
  DLY1X1M U308 ( .A(FIFO_MEM_3__6_), .Y(n302) );
  DLY1X1M U309 ( .A(FIFO_MEM_3__7_), .Y(n303) );
  DLY1X1M U310 ( .A(FIFO_MEM_7__0_), .Y(n304) );
  DLY1X1M U311 ( .A(FIFO_MEM_7__1_), .Y(n305) );
  DLY1X1M U312 ( .A(FIFO_MEM_7__2_), .Y(n306) );
  DLY1X1M U313 ( .A(FIFO_MEM_7__3_), .Y(n307) );
  DLY1X1M U314 ( .A(FIFO_MEM_7__4_), .Y(n308) );
  DLY1X1M U315 ( .A(FIFO_MEM_7__5_), .Y(n309) );
  DLY1X1M U316 ( .A(FIFO_MEM_7__6_), .Y(n310) );
  DLY1X1M U317 ( .A(FIFO_MEM_7__7_), .Y(test_so2) );
  DLY1X1M U318 ( .A(FIFO_MEM_0__0_), .Y(n312) );
  DLY1X1M U319 ( .A(FIFO_MEM_0__1_), .Y(n313) );
  DLY1X1M U320 ( .A(FIFO_MEM_0__2_), .Y(n314) );
  DLY1X1M U321 ( .A(FIFO_MEM_0__3_), .Y(n315) );
  DLY1X1M U322 ( .A(FIFO_MEM_0__4_), .Y(n316) );
  DLY1X1M U323 ( .A(FIFO_MEM_0__5_), .Y(n317) );
  DLY1X1M U324 ( .A(FIFO_MEM_0__6_), .Y(n318) );
  DLY1X1M U325 ( .A(FIFO_MEM_0__7_), .Y(n319) );
  DLY1X1M U326 ( .A(FIFO_MEM_4__0_), .Y(n320) );
  DLY1X1M U327 ( .A(FIFO_MEM_4__1_), .Y(n321) );
  DLY1X1M U328 ( .A(FIFO_MEM_4__2_), .Y(n322) );
  DLY1X1M U329 ( .A(FIFO_MEM_4__3_), .Y(n323) );
  DLY1X1M U330 ( .A(FIFO_MEM_4__4_), .Y(n324) );
  DLY1X1M U331 ( .A(FIFO_MEM_4__5_), .Y(n325) );
  DLY1X1M U332 ( .A(FIFO_MEM_4__6_), .Y(n326) );
  DLY1X1M U333 ( .A(FIFO_MEM_4__7_), .Y(n327) );
endmodule


module FIFO_WR_test_1 ( W_CLK, W_RST, Winc, wq2_rptr, Wptr, Waddr, FULL, 
        test_si, test_se );
  input [3:0] wq2_rptr;
  output [3:0] Wptr;
  output [3:0] Waddr;
  input W_CLK, W_RST, Winc, test_si, test_se;
  output FULL;
  wire   n50, N7, N8, N9, N21, n5, n6, n9, n11, n12, n14, n15, n17, n18, n22,
         n23, n24, n25, n26, n28, n30, n32, n34, n36, n38, n40, n42, n1, n20,
         n21, n43, n44, n45, n46, n47, n48, n49, n53;
  wire   [3:2] r58_carry;

  SDFFRQX2M Waddr_reg_3_ ( .D(n34), .SI(n47), .SE(test_se), .CK(W_CLK), .RN(
        n20), .Q(Waddr[3]) );
  SDFFRQX2M Waddr_reg_2_ ( .D(n36), .SI(Waddr[1]), .SE(test_se), .CK(W_CLK), 
        .RN(n20), .Q(Waddr[2]) );
  SDFFRQX1M gray_wr_ptr_reg_2_ ( .D(n28), .SI(n48), .SE(test_se), .CK(W_CLK), 
        .RN(n20), .Q(Wptr[2]) );
  SDFFRQX4M Waddr_reg_1_ ( .D(n40), .SI(n45), .SE(test_se), .CK(W_CLK), .RN(
        n20), .Q(Waddr[1]) );
  SDFFRQX2M gray_wr_ptr_reg_1_ ( .D(n30), .SI(Wptr[0]), .SE(test_se), .CK(
        W_CLK), .RN(n20), .Q(Wptr[1]) );
  SDFFRQX2M gray_wr_ptr_reg_0_ ( .D(n32), .SI(n53), .SE(test_se), .CK(W_CLK), 
        .RN(n20), .Q(Wptr[0]) );
  SDFFRQX2M gray_wr_ptr_reg_3_ ( .D(n38), .SI(n49), .SE(test_se), .CK(W_CLK), 
        .RN(n20), .Q(Wptr[3]) );
  SDFFRQX2M Waddr_reg_0_ ( .D(n42), .SI(test_si), .SE(test_se), .CK(W_CLK), 
        .RN(n20), .Q(n50) );
  INVX4M U3 ( .A(n1), .Y(Waddr[0]) );
  INVX2M U4 ( .A(Waddr[0]), .Y(n45) );
  ADDHX4M U5 ( .A(r58_carry[3]), .B(Waddr[3]), .CO(N21), .S(N9) );
  INVXLM U6 ( .A(n50), .Y(n1) );
  ADDHX4M U7 ( .A(Waddr[1]), .B(Waddr[0]), .CO(r58_carry[2]), .S(N7) );
  CLKINVX1M U8 ( .A(Waddr[1]), .Y(n46) );
  INVX4M U17 ( .A(n11), .Y(n43) );
  INVX4M U18 ( .A(n21), .Y(n20) );
  INVX2M U19 ( .A(W_RST), .Y(n21) );
  OAI222X1M U20 ( .A0(N8), .A1(n5), .B0(N9), .B1(n6), .C0(n43), .C1(n49), .Y(
        n28) );
  NAND2X4M U21 ( .A(Winc), .B(n22), .Y(n11) );
  NAND2X2M U22 ( .A(N9), .B(n43), .Y(n5) );
  OAI22X1M U23 ( .A0(n43), .A1(n47), .B0(n17), .B1(n6), .Y(n36) );
  OAI22X1M U24 ( .A0(n43), .A1(n46), .B0(n17), .B1(n9), .Y(n40) );
  NAND2X2M U25 ( .A(N7), .B(n43), .Y(n9) );
  NAND2X2M U26 ( .A(N8), .B(n43), .Y(n6) );
  INVX2M U27 ( .A(n22), .Y(FULL) );
  NOR3X4M U28 ( .A(n46), .B(n45), .C(n47), .Y(n15) );
  OAI222X1M U29 ( .A0(N7), .A1(n6), .B0(N8), .B1(n9), .C0(n43), .C1(n48), .Y(
        n30) );
  INVX2M U30 ( .A(Wptr[1]), .Y(n48) );
  OAI2B2X1M U31 ( .A1N(n53), .A0(n14), .B0(n15), .B1(n5), .Y(n34) );
  NOR2X2M U32 ( .A(N9), .B(n11), .Y(n14) );
  AO21XLM U33 ( .A0(n11), .A1(Wptr[0]), .B0(n12), .Y(n32) );
  OAI32X2M U34 ( .A0(n11), .A1(N7), .A2(Waddr[0]), .B0(n9), .B1(n45), .Y(n12)
         );
  AO21XLM U43 ( .A0(n11), .A1(Wptr[3]), .B0(n18), .Y(n38) );
  OAI32X2M U44 ( .A0(n11), .A1(N9), .A2(n44), .B0(n5), .B1(N21), .Y(n18) );
  INVX2M U45 ( .A(N21), .Y(n44) );
  OAI32X2M U46 ( .A0(Waddr[0]), .A1(n17), .A2(n11), .B0(n43), .B1(n45), .Y(n42) );
  XNOR2X2M U47 ( .A(wq2_rptr[2]), .B(n49), .Y(n25) );
  NAND4X2M U48 ( .A(n23), .B(n24), .C(n25), .D(n26), .Y(n22) );
  XNOR2X2M U49 ( .A(Wptr[0]), .B(wq2_rptr[0]), .Y(n23) );
  XNOR2X2M U50 ( .A(Wptr[1]), .B(wq2_rptr[1]), .Y(n24) );
  CLKXOR2X2M U51 ( .A(wq2_rptr[3]), .B(Wptr[3]), .Y(n26) );
  INVX2M U52 ( .A(Wptr[2]), .Y(n49) );
  NOR2BX4M U53 ( .AN(n15), .B(Waddr[3]), .Y(n17) );
  INVX2M U54 ( .A(Waddr[2]), .Y(n47) );
  ADDHX4M U55 ( .A(Waddr[2]), .B(r58_carry[2]), .CO(r58_carry[3]), .S(N8) );
  DLY1X1M U56 ( .A(Waddr[3]), .Y(n53) );
endmodule


module FIFO_RD_test_1 ( R_CLK, R_RST, Rinc, rq2_wptr, rptr, raddr, EMPTY, 
        test_si, test_so, test_se );
  input [3:0] rq2_wptr;
  output [3:0] rptr;
  output [3:0] raddr;
  input R_CLK, R_RST, Rinc, test_si, test_se;
  output EMPTY, test_so;
  wire   n42, N6, N7, N8, N9, N21, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n1, n36, n37, n38, n39, n40, n41,
         n45, n47, n48, n49, n50, n51;
  wire   [3:0] gray_rd_ptr;
  wire   [3:2] r58_carry;

  SDFFRQX2M raddr_reg_2_ ( .D(n29), .SI(n45), .SE(test_se), .CK(R_CLK), .RN(
        n36), .Q(n42) );
  SDFFRQX1M gray_rd_ptr_reg_3_ ( .D(n31), .SI(n48), .SE(test_se), .CK(R_CLK), 
        .RN(n36), .Q(gray_rd_ptr[3]) );
  SDFFRQX1M gray_rd_ptr_reg_1_ ( .D(n27), .SI(n47), .SE(test_se), .CK(R_CLK), 
        .RN(n36), .Q(gray_rd_ptr[1]) );
  SDFFRQX1M gray_rd_ptr_reg_0_ ( .D(n28), .SI(test_si), .SE(test_se), .CK(
        R_CLK), .RN(n36), .Q(gray_rd_ptr[0]) );
  SDFFRQX1M gray_rd_ptr_reg_2_ ( .D(n26), .SI(n49), .SE(test_se), .CK(R_CLK), 
        .RN(n36), .Q(gray_rd_ptr[2]) );
  SDFFRQX2M raddr_reg_1_ ( .D(n30), .SI(N6), .SE(test_se), .CK(R_CLK), .RN(n36), .Q(raddr[1]) );
  SDFFRQX4M raddr_reg_0_ ( .D(n33), .SI(n50), .SE(test_se), .CK(R_CLK), .RN(
        n36), .Q(raddr[0]) );
  NAND4X1M U5 ( .A(raddr[2]), .B(raddr[1]), .C(raddr[0]), .D(test_so), .Y(n20)
         );
  INVXLM U12 ( .A(n42), .Y(n1) );
  INVX6M U13 ( .A(n1), .Y(raddr[2]) );
  ADDHX1M U22 ( .A(raddr[3]), .B(r58_carry[3]), .CO(N21), .S(N9) );
  ADDHX1M U23 ( .A(raddr[2]), .B(r58_carry[2]), .CO(r58_carry[3]), .S(N8) );
  ADDHX2M U24 ( .A(raddr[0]), .B(raddr[1]), .CO(r58_carry[2]), .S(N7) );
  CLKXOR2X2M U25 ( .A(n41), .B(n40), .Y(rptr[1]) );
  CLKXOR2X2M U26 ( .A(n40), .B(n39), .Y(rptr[2]) );
  INVX4M U27 ( .A(n37), .Y(n36) );
  INVX2M U28 ( .A(R_RST), .Y(n37) );
  CLKXOR2X2M U29 ( .A(N7), .B(n51), .Y(rptr[0]) );
  XNOR2X4M U30 ( .A(n39), .B(N21), .Y(rptr[3]) );
  INVX4M U31 ( .A(n18), .Y(n38) );
  INVX2M U32 ( .A(n21), .Y(EMPTY) );
  INVX2M U33 ( .A(N9), .Y(n39) );
  INVX2M U34 ( .A(N8), .Y(n40) );
  INVX2M U35 ( .A(N7), .Y(n41) );
  NAND2X4M U36 ( .A(Rinc), .B(n21), .Y(n18) );
  XNOR2X2M U37 ( .A(gray_rd_ptr[1]), .B(rq2_wptr[1]), .Y(n22) );
  OAI22X1M U38 ( .A0(n38), .A1(test_so), .B0(n39), .B1(n19), .Y(n32) );
  NAND2X2M U39 ( .A(n38), .B(n20), .Y(n19) );
  NAND4X2M U40 ( .A(n22), .B(n23), .C(n24), .D(n25), .Y(n21) );
  XNOR2X2M U41 ( .A(gray_rd_ptr[3]), .B(rq2_wptr[3]), .Y(n24) );
  XNOR2X2M U42 ( .A(gray_rd_ptr[2]), .B(rq2_wptr[2]), .Y(n25) );
  XNOR2X2M U43 ( .A(gray_rd_ptr[0]), .B(rq2_wptr[0]), .Y(n23) );
  OAI2BB2X1M U44 ( .B0(n41), .B1(n19), .A0N(n18), .A1N(n45), .Y(n30) );
  OAI2BB2X1M U45 ( .B0(n40), .B1(n19), .A0N(n18), .A1N(raddr[2]), .Y(n29) );
  AO2B2X2M U46 ( .B0(n18), .B1(raddr[0]), .A0(N6), .A1N(n19), .Y(n33) );
  AO22X1M U47 ( .A0(rptr[0]), .A1(n38), .B0(n18), .B1(n47), .Y(n28) );
  AO22X1M U48 ( .A0(rptr[1]), .A1(n38), .B0(n18), .B1(n49), .Y(n27) );
  AO22X1M U49 ( .A0(rptr[2]), .A1(n38), .B0(n18), .B1(n48), .Y(n26) );
  AO22X1M U50 ( .A0(rptr[3]), .A1(n38), .B0(n18), .B1(n50), .Y(n31) );
  CLKINVX1M U51 ( .A(raddr[0]), .Y(N6) );
  DLY1X1M U52 ( .A(raddr[1]), .Y(n45) );
  DLY1X1M U54 ( .A(gray_rd_ptr[0]), .Y(n47) );
  DLY1X1M U55 ( .A(gray_rd_ptr[2]), .Y(n48) );
  DLY1X1M U56 ( .A(gray_rd_ptr[1]), .Y(n49) );
  DLY1X1M U57 ( .A(gray_rd_ptr[3]), .Y(n50) );
  INVXLM U58 ( .A(raddr[0]), .Y(n51) );
  SDFFSRX2M raddr_reg_3_ ( .D(n32), .SI(raddr[2]), .SE(test_se), .CK(R_CLK), 
        .SN(1'b1), .RN(R_RST), .Q(raddr[3]), .QN(test_so) );
endmodule


module DF_SYNC_test_1 ( CLK, RST, ASYNC_IN, SYNC_OUT, test_si, test_se );
  input [3:0] ASYNC_IN;
  output [3:0] SYNC_OUT;
  input CLK, RST, test_si, test_se;
  wire   sync_reg_3__0_, sync_reg_2__0_, sync_reg_1__0_, sync_reg_0__0_, n17,
         n18;

  SDFFRQX1M sync_reg_reg_3__1_ ( .D(sync_reg_3__0_), .SI(sync_reg_3__0_), .SE(
        test_se), .CK(CLK), .RN(n17), .Q(SYNC_OUT[3]) );
  SDFFRQX1M sync_reg_reg_2__1_ ( .D(sync_reg_2__0_), .SI(sync_reg_2__0_), .SE(
        test_se), .CK(CLK), .RN(n17), .Q(SYNC_OUT[2]) );
  SDFFRQX1M sync_reg_reg_1__1_ ( .D(sync_reg_1__0_), .SI(sync_reg_1__0_), .SE(
        test_se), .CK(CLK), .RN(n17), .Q(SYNC_OUT[1]) );
  SDFFRQX1M sync_reg_reg_0__1_ ( .D(sync_reg_0__0_), .SI(sync_reg_0__0_), .SE(
        test_se), .CK(CLK), .RN(n17), .Q(SYNC_OUT[0]) );
  SDFFRQX1M sync_reg_reg_2__0_ ( .D(ASYNC_IN[2]), .SI(SYNC_OUT[1]), .SE(
        test_se), .CK(CLK), .RN(n17), .Q(sync_reg_2__0_) );
  SDFFRQX1M sync_reg_reg_3__0_ ( .D(ASYNC_IN[3]), .SI(SYNC_OUT[2]), .SE(
        test_se), .CK(CLK), .RN(n17), .Q(sync_reg_3__0_) );
  SDFFRQX1M sync_reg_reg_0__0_ ( .D(ASYNC_IN[0]), .SI(test_si), .SE(test_se), 
        .CK(CLK), .RN(n17), .Q(sync_reg_0__0_) );
  SDFFRQX1M sync_reg_reg_1__0_ ( .D(ASYNC_IN[1]), .SI(SYNC_OUT[0]), .SE(
        test_se), .CK(CLK), .RN(n17), .Q(sync_reg_1__0_) );
  INVX4M U19 ( .A(n18), .Y(n17) );
  INVX2M U20 ( .A(RST), .Y(n18) );
endmodule


module DF_SYNC_test_0 ( CLK, RST, ASYNC_IN, SYNC_OUT, test_si, test_se );
  input [3:0] ASYNC_IN;
  output [3:0] SYNC_OUT;
  input CLK, RST, test_si, test_se;
  wire   sync_reg_3__0_, sync_reg_2__0_, sync_reg_1__0_, sync_reg_0__0_, n17,
         n18;

  SDFFRQX1M sync_reg_reg_3__1_ ( .D(sync_reg_3__0_), .SI(sync_reg_3__0_), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(SYNC_OUT[3]) );
  SDFFRQX1M sync_reg_reg_2__1_ ( .D(sync_reg_2__0_), .SI(sync_reg_2__0_), .SE(
        test_se), .CK(CLK), .RN(n17), .Q(SYNC_OUT[2]) );
  SDFFRQX1M sync_reg_reg_1__1_ ( .D(sync_reg_1__0_), .SI(sync_reg_1__0_), .SE(
        test_se), .CK(CLK), .RN(n17), .Q(SYNC_OUT[1]) );
  SDFFRQX1M sync_reg_reg_0__1_ ( .D(sync_reg_0__0_), .SI(sync_reg_0__0_), .SE(
        test_se), .CK(CLK), .RN(n17), .Q(SYNC_OUT[0]) );
  SDFFRQX1M sync_reg_reg_0__0_ ( .D(ASYNC_IN[0]), .SI(test_si), .SE(test_se), 
        .CK(CLK), .RN(n17), .Q(sync_reg_0__0_) );
  SDFFRQX1M sync_reg_reg_1__0_ ( .D(ASYNC_IN[1]), .SI(SYNC_OUT[0]), .SE(
        test_se), .CK(CLK), .RN(n17), .Q(sync_reg_1__0_) );
  SDFFRQX1M sync_reg_reg_3__0_ ( .D(ASYNC_IN[3]), .SI(SYNC_OUT[2]), .SE(
        test_se), .CK(CLK), .RN(n17), .Q(sync_reg_3__0_) );
  SDFFRQX1M sync_reg_reg_2__0_ ( .D(ASYNC_IN[2]), .SI(SYNC_OUT[1]), .SE(
        test_se), .CK(CLK), .RN(n17), .Q(sync_reg_2__0_) );
  INVX4M U19 ( .A(n18), .Y(n17) );
  INVX2M U20 ( .A(RST), .Y(n18) );
endmodule


module ASYNC_FIFO_test_1 ( W_CLK, W_RST, W_INC, R_CLK, R_RST, R_INC, WR_DATA, 
        FULL, RD_DATA, EMPTY, test_si2, test_si1, test_so2, test_so1, test_se
 );
  input [7:0] WR_DATA;
  output [7:0] RD_DATA;
  input W_CLK, W_RST, W_INC, R_CLK, R_RST, R_INC, test_si2, test_si1, test_se;
  output FULL, EMPTY, test_so2, test_so1;
  wire   W_ptr_2_, W_ptr_1_, W_ptr_0_, n1, n2, n3, n4, n5, n6;
  wire   [3:0] W_addr;
  wire   [3:0] R_addr;
  wire   [3:0] sync_Rd_ptr;
  wire   [3:0] sync_Wr_ptr;
  wire   [3:0] R_ptr;

  INVX2M U1 ( .A(n4), .Y(n3) );
  INVX2M U2 ( .A(W_RST), .Y(n4) );
  INVX2M U3 ( .A(n2), .Y(n1) );
  INVX2M U4 ( .A(R_RST), .Y(n2) );
  FIFO_MEM_CNTRL_test_1 DUT_fifo_mem ( .Wdata(WR_DATA), .Winc(W_INC), .Rinc(
        R_INC), .W_CLK(W_CLK), .W_RST(n3), .Wfull(FULL), .W_addr(W_addr), 
        .R_addr(R_addr), .Rdata(RD_DATA), .test_si2(test_si2), .test_si1(
        sync_Wr_ptr[3]), .test_so2(n6), .test_so1(test_so1), .test_se(test_se)
         );
  FIFO_WR_test_1 DUT_fifo_wr ( .W_CLK(W_CLK), .W_RST(n3), .Winc(W_INC), 
        .wq2_rptr(sync_Rd_ptr), .Wptr({test_so2, W_ptr_2_, W_ptr_1_, W_ptr_0_}), .Waddr(W_addr), .FULL(FULL), .test_si(n5), .test_se(test_se) );
  FIFO_RD_test_1 DUT_fifo_rd ( .R_CLK(R_CLK), .R_RST(n1), .Rinc(R_INC), 
        .rq2_wptr(sync_Wr_ptr), .rptr(R_ptr), .raddr(R_addr), .EMPTY(EMPTY), 
        .test_si(n6), .test_so(n5), .test_se(test_se) );
  DF_SYNC_test_1 DUT_W2R ( .CLK(R_CLK), .RST(n1), .ASYNC_IN({test_so2, 
        W_ptr_2_, W_ptr_1_, W_ptr_0_}), .SYNC_OUT(sync_Wr_ptr), .test_si(
        sync_Rd_ptr[3]), .test_se(test_se) );
  DF_SYNC_test_0 DUT_R2W ( .CLK(W_CLK), .RST(n3), .ASYNC_IN(R_ptr), .SYNC_OUT(
        sync_Rd_ptr), .test_si(test_si1), .test_se(test_se) );
endmodule


module CLKDiv_0_DW01_inc_0 ( A, SUM );
  input [6:0] A;
  output [6:0] SUM;

  wire   [6:2] carry;

  ADDHX1M U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1M U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1M U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1M U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1M U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  CLKXOR2X2M U1 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
  CLKINVX1M U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module CLKDiv_test_1 ( I_ref_clk, I_rst_n, I_clk_en, I_div_ratio, O_div_clk, 
        test_si, test_so, test_se );
  input [7:0] I_div_ratio;
  input I_ref_clk, I_rst_n, I_clk_en, test_si, test_se;
  output O_div_clk, test_so;
  wire   N2, div_clk, N16, N17, N18, N19, N20, N21, N22, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n1, n2, n3, n4, n5, n15, n25, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51,
         n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n72, n73, n74, n75;
  wire   [6:0] count;
  wire   [6:0] edge_flip_half;

  SDFFSQX2M odd_edge_tog_reg ( .D(n26), .SI(div_clk), .SE(test_se), .CK(
        I_ref_clk), .SN(n35), .Q(test_so) );
  SDFFRQX2M div_clk_reg ( .D(n27), .SI(n15), .SE(test_se), .CK(I_ref_clk), 
        .RN(n35), .Q(div_clk) );
  SDFFRQX1M count_reg_6_ ( .D(n28), .SI(n73), .SE(test_se), .CK(I_ref_clk), 
        .RN(n35), .Q(count[6]) );
  SDFFRQX1M count_reg_4_ ( .D(n30), .SI(n72), .SE(test_se), .CK(I_ref_clk), 
        .RN(n35), .Q(count[4]) );
  SDFFRQX2M count_reg_5_ ( .D(n29), .SI(n4), .SE(test_se), .CK(I_ref_clk), 
        .RN(n35), .Q(count[5]) );
  SDFFRQX2M count_reg_3_ ( .D(n31), .SI(n75), .SE(test_se), .CK(I_ref_clk), 
        .RN(n35), .Q(count[3]) );
  SDFFRQX1M count_reg_0_ ( .D(n34), .SI(test_si), .SE(test_se), .CK(I_ref_clk), 
        .RN(n35), .Q(count[0]) );
  SDFFRQX2M count_reg_2_ ( .D(n32), .SI(n74), .SE(test_se), .CK(I_ref_clk), 
        .RN(n35), .Q(count[2]) );
  SDFFRQX2M count_reg_1_ ( .D(n33), .SI(n2), .SE(test_se), .CK(I_ref_clk), 
        .RN(n35), .Q(count[1]) );
  INVXLM U5 ( .A(count[0]), .Y(n1) );
  INVX4M U6 ( .A(n1), .Y(n2) );
  CLKXOR2X2M U11 ( .A(I_div_ratio[2]), .B(count[1]), .Y(n66) );
  CLKXOR2X2M U15 ( .A(I_div_ratio[3]), .B(count[2]), .Y(n67) );
  XNOR2X2M U16 ( .A(count[5]), .B(I_div_ratio[6]), .Y(n61) );
  XNOR2X2M U17 ( .A(count[3]), .B(I_div_ratio[4]), .Y(n60) );
  INVXLM U18 ( .A(count[4]), .Y(n3) );
  INVX2M U19 ( .A(n3), .Y(n4) );
  INVXLM U20 ( .A(count[6]), .Y(n5) );
  INVX2M U21 ( .A(n5), .Y(n15) );
  OAI2BB1XLM U22 ( .A0N(I_div_ratio[1]), .A1N(I_div_ratio[2]), .B0(n37), .Y(
        edge_flip_half[1]) );
  XOR2X1M U23 ( .A(n2), .B(I_div_ratio[1]), .Y(n65) );
  NOR4X2M U33 ( .A(n56), .B(n57), .C(n58), .D(n59), .Y(n55) );
  NOR2X4M U34 ( .A(n38), .B(I_div_ratio[4]), .Y(n39) );
  AND3X4M U35 ( .A(n45), .B(n46), .C(N2), .Y(n44) );
  NAND4X2M U36 ( .A(n52), .B(n53), .C(n54), .D(n55), .Y(n48) );
  OR2X2M U37 ( .A(n37), .B(I_div_ratio[3]), .Y(n38) );
  AO22XLM U38 ( .A0(n25), .A1(n74), .B0(N17), .B1(n44), .Y(n33) );
  AO22XLM U39 ( .A0(n25), .A1(n75), .B0(N18), .B1(n44), .Y(n32) );
  AO22XLM U40 ( .A0(n25), .A1(n72), .B0(N19), .B1(n44), .Y(n31) );
  AO22XLM U41 ( .A0(n25), .A1(n4), .B0(N20), .B1(n44), .Y(n30) );
  AO22XLM U42 ( .A0(n25), .A1(n73), .B0(N21), .B1(n44), .Y(n29) );
  AO22XLM U43 ( .A0(n25), .A1(n15), .B0(N22), .B1(n44), .Y(n28) );
  AO22XLM U44 ( .A0(n25), .A1(n2), .B0(N16), .B1(n44), .Y(n34) );
  OAI2BB1XLM U45 ( .A0N(n37), .A1N(I_div_ratio[3]), .B0(n38), .Y(
        edge_flip_half[2]) );
  INVX6M U46 ( .A(n36), .Y(n35) );
  INVX2M U47 ( .A(I_rst_n), .Y(n36) );
  OR2X2M U48 ( .A(I_div_ratio[2]), .B(I_div_ratio[1]), .Y(n37) );
  INVX2M U49 ( .A(I_div_ratio[5]), .Y(n42) );
  CLKBUFX6M U50 ( .A(n43), .Y(n25) );
  OAI21X2M U51 ( .A0(n68), .A1(n69), .B0(I_clk_en), .Y(n43) );
  MX2XLM U52 ( .A(I_ref_clk), .B(div_clk), .S0(N2), .Y(O_div_clk) );
  CLKINVX1M U53 ( .A(I_div_ratio[1]), .Y(edge_flip_half[0]) );
  AO21XLM U54 ( .A0(n38), .A1(I_div_ratio[4]), .B0(n39), .Y(edge_flip_half[3])
         );
  CLKNAND2X2M U55 ( .A(n39), .B(n42), .Y(n40) );
  OAI21X1M U56 ( .A0(n39), .A1(n42), .B0(n40), .Y(edge_flip_half[4]) );
  XNOR2X1M U57 ( .A(I_div_ratio[6]), .B(n40), .Y(edge_flip_half[5]) );
  NOR2X1M U58 ( .A(I_div_ratio[6]), .B(n40), .Y(n41) );
  CLKXOR2X2M U59 ( .A(I_div_ratio[7]), .B(n41), .Y(edge_flip_half[6]) );
  CLKXOR2X2M U60 ( .A(div_clk), .B(n47), .Y(n27) );
  AOI21X1M U61 ( .A0(n46), .A1(n45), .B0(n25), .Y(n47) );
  OR2X1M U62 ( .A(n48), .B(I_div_ratio[0]), .Y(n45) );
  XNOR2X1M U63 ( .A(test_so), .B(n49), .Y(n26) );
  OR2X1M U64 ( .A(n46), .B(n25), .Y(n49) );
  CLKNAND2X2M U65 ( .A(n50), .B(I_div_ratio[0]), .Y(n46) );
  MXI2X1M U66 ( .A(n51), .B(n48), .S0(test_so), .Y(n50) );
  CLKXOR2X2M U67 ( .A(edge_flip_half[2]), .B(count[2]), .Y(n59) );
  CLKXOR2X2M U68 ( .A(edge_flip_half[1]), .B(count[1]), .Y(n58) );
  CLKXOR2X2M U69 ( .A(edge_flip_half[0]), .B(n2), .Y(n57) );
  CLKXOR2X2M U70 ( .A(edge_flip_half[6]), .B(n15), .Y(n56) );
  XNOR2X1M U71 ( .A(n4), .B(edge_flip_half[4]), .Y(n54) );
  XNOR2X1M U72 ( .A(count[5]), .B(edge_flip_half[5]), .Y(n53) );
  XNOR2X1M U73 ( .A(count[3]), .B(edge_flip_half[3]), .Y(n52) );
  NAND4X1M U74 ( .A(n60), .B(n61), .C(n62), .D(n63), .Y(n51) );
  NOR4X1M U75 ( .A(n64), .B(n65), .C(n66), .D(n67), .Y(n63) );
  CLKXOR2X2M U76 ( .A(n15), .B(I_div_ratio[7]), .Y(n64) );
  XNOR2X1M U77 ( .A(I_div_ratio[5]), .B(n4), .Y(n62) );
  CLKINVX1M U78 ( .A(n25), .Y(N2) );
  OR3X1M U79 ( .A(I_div_ratio[2]), .B(I_div_ratio[3]), .C(I_div_ratio[1]), .Y(
        n69) );
  OR4X1M U80 ( .A(I_div_ratio[7]), .B(I_div_ratio[4]), .C(I_div_ratio[5]), .D(
        I_div_ratio[6]), .Y(n68) );
  DLY1X1M U81 ( .A(count[3]), .Y(n72) );
  DLY1X1M U82 ( .A(count[5]), .Y(n73) );
  DLY1X1M U83 ( .A(count[1]), .Y(n74) );
  DLY1X1M U84 ( .A(count[2]), .Y(n75) );
  CLKDiv_0_DW01_inc_0 add_44 ( .A({n15, count[5], n4, count[3:1], n2}), .SUM({
        N22, N21, N20, N19, N18, N17, N16}) );
endmodule


module CLKDiv_1_DW01_inc_0 ( A, SUM );
  input [6:0] A;
  output [6:0] SUM;

  wire   [6:2] carry;

  ADDHX1M U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1M U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1M U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1M U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1M U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  CLKXOR2X2M U1 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
  CLKINVX1M U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module CLKDiv_test_0 ( I_ref_clk, I_rst_n, I_clk_en, I_div_ratio, O_div_clk, 
        test_si, test_so, test_se );
  input [7:0] I_div_ratio;
  input I_ref_clk, I_rst_n, I_clk_en, test_si, test_se;
  output O_div_clk, test_so;
  wire   N2, div_clk, odd_edge_tog, N16, N17, N18, N19, N20, N21, N22, n1, n2,
         n3, n4, n5, n15, n16, n17, n18, n19, n20, n21, n22, n23, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85,
         n86, n87, n99;
  wire   [6:0] count;
  wire   [6:1] edge_flip_half;

  SDFFSQX1M odd_edge_tog_reg ( .D(n87), .SI(n99), .SE(test_se), .CK(I_ref_clk), 
        .SN(I_rst_n), .Q(odd_edge_tog) );
  SDFFRQX1M div_clk_reg ( .D(n86), .SI(n17), .SE(test_se), .CK(I_ref_clk), 
        .RN(n43), .Q(div_clk) );
  SDFFRQX1M count_reg_0_ ( .D(n79), .SI(test_si), .SE(test_se), .CK(I_ref_clk), 
        .RN(n43), .Q(count[0]) );
  SDFFRQX1M count_reg_6_ ( .D(n85), .SI(n15), .SE(test_se), .CK(I_ref_clk), 
        .RN(n43), .Q(count[6]) );
  SDFFRQX1M count_reg_5_ ( .D(n84), .SI(n4), .SE(test_se), .CK(I_ref_clk), 
        .RN(n43), .Q(count[5]) );
  SDFFRQX1M count_reg_4_ ( .D(n83), .SI(n2), .SE(test_se), .CK(I_ref_clk), 
        .RN(n43), .Q(count[4]) );
  SDFFRQX1M count_reg_3_ ( .D(n82), .SI(n21), .SE(test_se), .CK(I_ref_clk), 
        .RN(n43), .Q(count[3]) );
  SDFFRQX1M count_reg_2_ ( .D(n81), .SI(n19), .SE(test_se), .CK(I_ref_clk), 
        .RN(n43), .Q(count[2]) );
  SDFFRQX1M count_reg_1_ ( .D(n80), .SI(n23), .SE(test_se), .CK(I_ref_clk), 
        .RN(n43), .Q(count[1]) );
  INVX4M U5 ( .A(n44), .Y(n43) );
  NOR4X2M U6 ( .A(n65), .B(n66), .C(n67), .D(n68), .Y(n64) );
  INVXLM U11 ( .A(count[3]), .Y(n1) );
  INVX2M U15 ( .A(n1), .Y(n2) );
  INVXLM U16 ( .A(count[4]), .Y(n3) );
  INVX2M U17 ( .A(n3), .Y(n4) );
  INVXLM U18 ( .A(count[5]), .Y(n5) );
  INVX2M U19 ( .A(n5), .Y(n15) );
  INVXLM U20 ( .A(count[6]), .Y(n16) );
  INVX2M U21 ( .A(n16), .Y(n17) );
  INVXLM U22 ( .A(count[1]), .Y(n18) );
  INVX2M U23 ( .A(n18), .Y(n19) );
  INVXLM U24 ( .A(count[2]), .Y(n20) );
  INVX2M U25 ( .A(n20), .Y(n21) );
  INVXLM U26 ( .A(count[0]), .Y(n22) );
  INVX4M U27 ( .A(n22), .Y(n23) );
  NAND2BX2M U37 ( .AN(I_div_ratio[2]), .B(n50), .Y(n45) );
  NOR2X4M U38 ( .A(n46), .B(I_div_ratio[4]), .Y(n47) );
  AND3X4M U39 ( .A(n54), .B(n55), .C(N2), .Y(n53) );
  OR2X2M U40 ( .A(n45), .B(I_div_ratio[3]), .Y(n46) );
  OAI2BB1XLM U41 ( .A0N(n45), .A1N(I_div_ratio[3]), .B0(n46), .Y(
        edge_flip_half[2]) );
  OAI2BB1XLM U42 ( .A0N(I_div_ratio[1]), .A1N(I_div_ratio[2]), .B0(n45), .Y(
        edge_flip_half[1]) );
  NAND4X2M U43 ( .A(n61), .B(n62), .C(n63), .D(n64), .Y(n57) );
  AO22XLM U44 ( .A0(n42), .A1(n19), .B0(N17), .B1(n53), .Y(n80) );
  AO22XLM U45 ( .A0(n42), .A1(n21), .B0(N18), .B1(n53), .Y(n81) );
  AO22XLM U46 ( .A0(n42), .A1(n2), .B0(N19), .B1(n53), .Y(n82) );
  AO22XLM U47 ( .A0(n42), .A1(n4), .B0(N20), .B1(n53), .Y(n83) );
  AO22XLM U48 ( .A0(n42), .A1(n15), .B0(N21), .B1(n53), .Y(n84) );
  AO22XLM U49 ( .A0(n42), .A1(n17), .B0(N22), .B1(n53), .Y(n85) );
  AO22XLM U50 ( .A0(n42), .A1(n23), .B0(N16), .B1(n53), .Y(n79) );
  INVX2M U51 ( .A(I_div_ratio[1]), .Y(n50) );
  INVX2M U52 ( .A(I_rst_n), .Y(n44) );
  CLKBUFX6M U53 ( .A(n52), .Y(n42) );
  OAI21X2M U54 ( .A0(n77), .A1(n78), .B0(I_clk_en), .Y(n52) );
  INVX2M U55 ( .A(I_div_ratio[5]), .Y(n51) );
  MX2XLM U56 ( .A(I_ref_clk), .B(n99), .S0(N2), .Y(O_div_clk) );
  AO21XLM U57 ( .A0(n46), .A1(I_div_ratio[4]), .B0(n47), .Y(edge_flip_half[3])
         );
  CLKNAND2X2M U58 ( .A(n47), .B(n51), .Y(n48) );
  OAI21X1M U59 ( .A0(n47), .A1(n51), .B0(n48), .Y(edge_flip_half[4]) );
  XNOR2X1M U60 ( .A(I_div_ratio[6]), .B(n48), .Y(edge_flip_half[5]) );
  NOR2X1M U61 ( .A(I_div_ratio[6]), .B(n48), .Y(n49) );
  CLKXOR2X2M U62 ( .A(I_div_ratio[7]), .B(n49), .Y(edge_flip_half[6]) );
  CLKXOR2X2M U63 ( .A(n56), .B(div_clk), .Y(n86) );
  AOI21X1M U64 ( .A0(n55), .A1(n54), .B0(n42), .Y(n56) );
  OR2X1M U65 ( .A(n57), .B(I_div_ratio[0]), .Y(n54) );
  XNOR2X1M U66 ( .A(test_so), .B(n58), .Y(n87) );
  OR2X1M U67 ( .A(n55), .B(n42), .Y(n58) );
  CLKNAND2X2M U68 ( .A(n59), .B(I_div_ratio[0]), .Y(n55) );
  MXI2X1M U69 ( .A(n60), .B(n57), .S0(odd_edge_tog), .Y(n59) );
  CLKXOR2X2M U70 ( .A(edge_flip_half[2]), .B(n21), .Y(n68) );
  CLKXOR2X2M U71 ( .A(edge_flip_half[1]), .B(n19), .Y(n67) );
  CLKXOR2X2M U72 ( .A(n50), .B(n23), .Y(n66) );
  CLKXOR2X2M U73 ( .A(edge_flip_half[6]), .B(n17), .Y(n65) );
  XNOR2X1M U74 ( .A(n4), .B(edge_flip_half[4]), .Y(n63) );
  XNOR2X1M U75 ( .A(n15), .B(edge_flip_half[5]), .Y(n62) );
  XNOR2X1M U76 ( .A(n2), .B(edge_flip_half[3]), .Y(n61) );
  NAND4X1M U77 ( .A(n69), .B(n70), .C(n71), .D(n72), .Y(n60) );
  NOR4X1M U78 ( .A(n73), .B(n74), .C(n75), .D(n76), .Y(n72) );
  CLKXOR2X2M U79 ( .A(I_div_ratio[3]), .B(n21), .Y(n76) );
  CLKXOR2X2M U80 ( .A(I_div_ratio[2]), .B(n19), .Y(n75) );
  CLKXOR2X2M U81 ( .A(n23), .B(I_div_ratio[1]), .Y(n74) );
  CLKXOR2X2M U82 ( .A(n17), .B(I_div_ratio[7]), .Y(n73) );
  XNOR2X1M U83 ( .A(I_div_ratio[5]), .B(n4), .Y(n71) );
  XNOR2X1M U84 ( .A(I_div_ratio[6]), .B(n15), .Y(n70) );
  XNOR2X1M U85 ( .A(I_div_ratio[4]), .B(n2), .Y(n69) );
  CLKINVX1M U86 ( .A(n42), .Y(N2) );
  OR3X1M U87 ( .A(I_div_ratio[2]), .B(I_div_ratio[3]), .C(I_div_ratio[1]), .Y(
        n78) );
  OR4X1M U88 ( .A(I_div_ratio[7]), .B(I_div_ratio[4]), .C(I_div_ratio[5]), .D(
        I_div_ratio[6]), .Y(n77) );
  DLY1X1M U89 ( .A(div_clk), .Y(n99) );
  DLY1X1M U90 ( .A(odd_edge_tog), .Y(test_so) );
  CLKDiv_1_DW01_inc_0 add_44 ( .A({n17, n15, n4, n2, n21, n19, n23}), .SUM({
        N22, N21, N20, N19, N18, N17, N16}) );
endmodule


module CLKDIV_MUX ( IN, OUT );
  input [5:0] IN;
  output [7:0] OUT;
  wire   n5, n6, n7, n8, n9, n15, n16, n17, n18, n19, n20;

  AND2X2M U11 ( .A(n17), .B(n15), .Y(OUT[2]) );
  INVX2M U12 ( .A(IN[1]), .Y(n20) );
  AND2X2M U13 ( .A(n16), .B(n20), .Y(n15) );
  INVX2M U14 ( .A(IN[0]), .Y(n16) );
  NOR4X6M U15 ( .A(n5), .B(IN[3]), .C(IN[5]), .D(IN[4]), .Y(OUT[3]) );
  NOR4X2M U16 ( .A(IN[5]), .B(IN[4]), .C(IN[3]), .D(n19), .Y(n8) );
  NOR3X8M U17 ( .A(n7), .B(IN[1]), .C(IN[0]), .Y(OUT[1]) );
  INVXLM U18 ( .A(n6), .Y(n17) );
  OAI211X2M U19 ( .A0(n8), .A1(n9), .B0(n16), .C0(n20), .Y(OUT[0]) );
  NAND4BX2M U20 ( .AN(IN[3]), .B(IN[4]), .C(n19), .D(n18), .Y(n7) );
  NAND4BX2M U21 ( .AN(IN[4]), .B(IN[3]), .C(n19), .D(n18), .Y(n6) );
  INVX2M U22 ( .A(IN[2]), .Y(n19) );
  INVX2M U23 ( .A(IN[5]), .Y(n18) );
  NAND3X2M U24 ( .A(n16), .B(n20), .C(IN[2]), .Y(n5) );
  NAND2X2M U25 ( .A(n7), .B(n6), .Y(n9) );
  INVX2M U3 ( .A(1'b1), .Y(OUT[4]) );
  INVX2M U5 ( .A(1'b1), .Y(OUT[5]) );
  INVX2M U7 ( .A(1'b1), .Y(OUT[6]) );
  INVX2M U9 ( .A(1'b1), .Y(OUT[7]) );
endmodule


module System_TOP ( scan_clk, scan_rst, test_mode, SE, SI, SO, RST, UART_CLK, 
        REF_CLK, RX_IN, TX_OUT, parity_error, framing_error );
  input [3:0] SI;
  output [3:0] SO;
  input scan_clk, scan_rst, test_mode, SE, RST, UART_CLK, REF_CLK, RX_IN;
  output TX_OUT, parity_error, framing_error;
  wire   REF_SCAN_CLK, UART_SCAN_CLK, UART_RX_CLK, UART_RX_SCAN_CLK,
         UART_TX_CLK, UART_TX_SCAN_CLK, RSTN_SCAN_RST, SYNC_REF_RST,
         SYNC_REF_SCAN_RST, SYNC_UART_RST, SYNC_UART_SCAN_RST, UART_TX_Busy,
         UART_RX_V_OUT, UART_TX_V_SYNC, UART_RX_V_SYNC, UART_TX_Busy_PULSE,
         ALU_OUT_VLD, RF_RdData_VLD, FIFO_FULL, ALU_EN, CLKG_EN, RF_WrEn,
         RF_RdEn, UART_TX_VLD, DIV_RATIO_7_, DIV_RATIO_6_, DIV_RATIO_5_,
         DIV_RATIO_4_, DIV_RATIO_3_, DIV_RATIO_1_, DIV_RATIO_0_, ALU_CLK,
         n_1_net_, n1, n2, n3, n4, n5, n6, n7, n8, n10, n11, n15, n16, n19,
         n20, n21, SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2,
         SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4;
  wire   [7:0] UART_Config;
  wire   [7:0] UART_TX_SYNC;
  wire   [7:0] UART_RX_OUT;
  wire   [7:0] UART_RX_SYNC;
  wire   [15:0] ALU_OUT;
  wire   [7:0] RF_RdData;
  wire   [3:0] ALU_FUN;
  wire   [3:0] RF_Address;
  wire   [7:0] RF_WrData;
  wire   [7:0] UART_TX_IN;
  wire   [7:0] Operand_A;
  wire   [7:0] Operand_B;
  wire   [7:0] DIV_RATIO_RX;

  INVX2M U3 ( .A(UART_TX_V_SYNC), .Y(n1) );
  INVX4M U4 ( .A(n8), .Y(n7) );
  INVX4M U5 ( .A(n6), .Y(n5) );
  BUFX2M U6 ( .A(RF_Address[1]), .Y(n4) );
  BUFX2M U7 ( .A(RF_Address[0]), .Y(n3) );
  INVX2M U8 ( .A(SYNC_REF_SCAN_RST), .Y(n8) );
  INVX2M U9 ( .A(SYNC_UART_SCAN_RST), .Y(n6) );
  OR2X2M U10 ( .A(CLKG_EN), .B(test_mode), .Y(n_1_net_) );
  BUFX2M U11 ( .A(RX_IN), .Y(n2) );
  CLKBUFX40M U17 ( .A(SO[0]), .Y(TX_OUT) );
  mux2X1_1 U0_mux2X1 ( .IN_0(REF_CLK), .IN_1(scan_clk), .SEL(test_mode), .OUT(
        REF_SCAN_CLK) );
  mux2X1_4 U1_mux2X1 ( .IN_0(UART_CLK), .IN_1(scan_clk), .SEL(test_mode), 
        .OUT(UART_SCAN_CLK) );
  mux2X1_3 U2_mux2X1 ( .IN_0(UART_RX_CLK), .IN_1(scan_clk), .SEL(test_mode), 
        .OUT(UART_RX_SCAN_CLK) );
  mux2X1_2 U3_mux2X1 ( .IN_0(UART_TX_CLK), .IN_1(scan_clk), .SEL(test_mode), 
        .OUT(UART_TX_SCAN_CLK) );
  mux2X1_0 U4_mux2X1 ( .IN_0(1'b0), .IN_1(scan_rst), .SEL(test_mode), .OUT(
        RSTN_SCAN_RST) );
  mux2X1_6 U5_mux2X1 ( .IN_0(SYNC_REF_RST), .IN_1(scan_rst), .SEL(test_mode), 
        .OUT(SYNC_REF_SCAN_RST) );
  mux2X1_5 U6_mux2X1 ( .IN_0(SYNC_UART_RST), .IN_1(scan_rst), .SEL(test_mode), 
        .OUT(SYNC_UART_SCAN_RST) );
  UART_test_1 DUT_UART ( .PAR_EN(UART_Config[0]), .PAR_TYP(UART_Config[1]), 
        .RST(n5), .TX_CLK(UART_TX_SCAN_CLK), .TX_IN_VLD(n1), .TX_IN_P(
        UART_TX_SYNC), .TX_OUT_S(SO[0]), .TX_OUT_VLD(UART_TX_Busy), .RX_CLK(
        UART_RX_SCAN_CLK), .prescale(UART_Config[7:2]), .RX_IN_S(n2), 
        .RX_OUT_P(UART_RX_OUT), .RX_OUT_VLD(UART_RX_V_OUT), .parr_err(
        parity_error), .Framing_error(framing_error), .test_si(n10), .test_se(
        SE) );
  DATA_SYNC_test_1 DUT_DATA_SYNC ( .CLK(REF_SCAN_CLK), .RST(n7), .bus_enable(
        UART_RX_V_OUT), .Unsync_bus(UART_RX_OUT), .sync_bus(UART_RX_SYNC), 
        .enable_pulse(UART_RX_V_SYNC), .test_si(n20), .test_so(n19), .test_se(
        SE) );
  PULSE_GEN_test_1 DUT_PULSE_GEN ( .CLK(UART_TX_SCAN_CLK), .RST(n5), .LVL_SIG(
        UART_TX_Busy), .PULSE_SIG(UART_TX_Busy_PULSE), .test_si(n16), 
        .test_so(n15), .test_se(SE) );
  SYS_CTRL_test_1 DUT_SYS_CTRL ( .CLK(REF_SCAN_CLK), .RST(n7), .ALU_OUT(
        ALU_OUT), .OUT_Valid(ALU_OUT_VLD), .RdData(RF_RdData), .RdData_Valid(
        RF_RdData_VLD), .RX_P_DATA(UART_RX_SYNC), .RX_D_VLD(UART_RX_V_SYNC), 
        .FIFO_FULL(FIFO_FULL), .parity_error(parity_error), .Framing_error(
        framing_error), .ALU_FUN(ALU_FUN), .ALU_EN(ALU_EN), .CLK_EN(CLKG_EN), 
        .Address(RF_Address), .WrEn(RF_WrEn), .RdEn(RF_RdEn), .WrData(
        RF_WrData), .TX_P_DATA(UART_TX_IN), .TX_D_VLD(UART_TX_VLD), .test_si(
        SYNC_UART_RST), .test_so(n10), .test_se(SE) );
  RegFile_test_1 DUT_REGFILE ( .CLK(REF_SCAN_CLK), .RST(n7), .RdEn(RF_RdEn), 
        .WrEn(RF_WrEn), .Address({RF_Address[3:2], n4, n3}), .WrData(RF_WrData), .RdData(RF_RdData), .RdData_VLD(RF_RdData_VLD), .REG0(Operand_A), .REG1(
        Operand_B), .REG2(UART_Config), .REG3({DIV_RATIO_7_, DIV_RATIO_6_, 
        DIV_RATIO_5_, DIV_RATIO_4_, DIV_RATIO_3_, SO[2], DIV_RATIO_1_, 
        DIV_RATIO_0_}), .test_si3(SI[0]), .test_si2(SI[1]), .test_si1(n15), 
        .test_so2(n11), .test_so1(SO[1]), .test_se(SE) );
  ALU_test_1 DUT_ALU ( .A(Operand_A), .B(Operand_B), .EN(ALU_EN), .ALU_FUN(
        ALU_FUN), .CLK(ALU_CLK), .RST(n7), .ALU_OUT(ALU_OUT), .OUT_VALID(
        ALU_OUT_VLD), .test_si(SI[3]), .test_se(SE) );
  CLK_GATE DUT_CLK_GATE ( .CLK_EN(n_1_net_), .CLK(REF_SCAN_CLK), .GATED_CLK(
        ALU_CLK) );
  RST_SYNC_test_0 DUT_RST_SYNC_1 ( .CLK(REF_SCAN_CLK), .RST(RSTN_SCAN_RST), 
        .SYNC_RST(SYNC_REF_RST), .test_si(n11), .test_se(SE) );
  RST_SYNC_test_1 DUT_RST_SYNC_2 ( .CLK(UART_SCAN_CLK), .RST(RSTN_SCAN_RST), 
        .SYNC_RST(SYNC_UART_RST), .test_si(SYNC_REF_RST), .test_se(SE) );
  ASYNC_FIFO_test_1 DUT_FIFO ( .W_CLK(REF_SCAN_CLK), .W_RST(n7), .W_INC(
        UART_TX_VLD), .R_CLK(UART_TX_SCAN_CLK), .R_RST(n5), .R_INC(
        UART_TX_Busy_PULSE), .WR_DATA(UART_TX_IN), .FULL(FIFO_FULL), .RD_DATA(
        UART_TX_SYNC), .EMPTY(UART_TX_V_SYNC), .test_si2(SI[2]), .test_si1(n19), .test_so2(n16), .test_so1(SO[3]), .test_se(SE) );
  CLKDiv_test_1 DUT_CLKDIV_TX ( .I_ref_clk(UART_SCAN_CLK), .I_rst_n(n5), 
        .I_clk_en(1'b1), .I_div_ratio({DIV_RATIO_7_, DIV_RATIO_6_, 
        DIV_RATIO_5_, DIV_RATIO_4_, DIV_RATIO_3_, SO[2], DIV_RATIO_1_, 
        DIV_RATIO_0_}), .O_div_clk(UART_TX_CLK), .test_si(n21), .test_so(n20), 
        .test_se(SE) );
  CLKDiv_test_0 DUT_CLKDIV_RX ( .I_ref_clk(UART_SCAN_CLK), .I_rst_n(n5), 
        .I_clk_en(1'b1), .I_div_ratio({1'b0, 1'b0, 1'b0, 1'b0, 
        DIV_RATIO_RX[3:0]}), .O_div_clk(UART_RX_CLK), .test_si(ALU_OUT_VLD), 
        .test_so(n21), .test_se(SE) );
  CLKDIV_MUX DUT_CLKDIV_MUX ( .IN(UART_Config[7:2]), .OUT({
        SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2, SYNOPSYS_UNCONNECTED_3, 
        SYNOPSYS_UNCONNECTED_4, DIV_RATIO_RX[3:0]}) );
endmodule

