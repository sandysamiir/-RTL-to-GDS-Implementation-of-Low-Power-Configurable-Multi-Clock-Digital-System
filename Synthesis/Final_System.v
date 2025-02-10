/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Fri Aug 16 02:39:32 2024
/////////////////////////////////////////////////////////////


module TX_FSM ( CLK, RST, Data_Valid, PAR_EN, ser_done, busy, mux_sel, ser_en, 
        par_en );
  output [1:0] mux_sel;
  input CLK, RST, Data_Valid, PAR_EN, ser_done;
  output busy, ser_en, par_en;
  wire   n8, n9, n11, n12, n14, n15, n1, n3, n4, n6, n7, n10;
  wire   [31:0] Current_State;
  wire   [2:0] Next_State;

  DFFRQX1M \Current_State_reg[0]  ( .D(Next_State[0]), .CK(CLK), .RN(n1), .Q(
        Current_State[0]) );
  DFFRQX4M \Current_State_reg[2]  ( .D(Next_State[2]), .CK(CLK), .RN(n1), .Q(
        Current_State[2]) );
  DFFRX1M \Current_State_reg[1]  ( .D(Next_State[1]), .CK(CLK), .RN(RST), .Q(
        Current_State[1]), .QN(n7) );
  AOI31X2M U3 ( .A0(mux_sel[1]), .A1(n3), .A2(n4), .B0(par_en), .Y(n8) );
  BUFX2M U4 ( .A(RST), .Y(n1) );
  INVX2M U5 ( .A(n8), .Y(ser_en) );
  INVX2M U6 ( .A(n12), .Y(mux_sel[1]) );
  NAND2X2M U7 ( .A(n15), .B(n8), .Y(Next_State[1]) );
  OAI211X2M U8 ( .A0(n7), .A1(n4), .B0(n9), .C0(n6), .Y(mux_sel[0]) );
  NAND2X2M U9 ( .A(n4), .B(n7), .Y(n9) );
  NOR3X4M U10 ( .A(Current_State[2]), .B(Current_State[1]), .C(n4), .Y(par_en)
         );
  INVX4M U11 ( .A(Current_State[0]), .Y(n4) );
  NAND2X2M U12 ( .A(Current_State[1]), .B(n6), .Y(n12) );
  INVX2M U13 ( .A(Current_State[2]), .Y(n6) );
  INVX2M U14 ( .A(ser_done), .Y(n3) );
  OAI211X2M U15 ( .A0(Current_State[2]), .A1(n4), .B0(n11), .C0(n12), .Y(busy)
         );
  NAND2BX2M U16 ( .AN(n9), .B(Current_State[2]), .Y(n11) );
  NAND3X2M U17 ( .A(mux_sel[1]), .B(n4), .C(PAR_EN), .Y(n15) );
  NOR2X2M U18 ( .A(n14), .B(n12), .Y(Next_State[2]) );
  AOI2B1X1M U19 ( .A1N(PAR_EN), .A0(ser_done), .B0(Current_State[0]), .Y(n14)
         );
  OAI32X2M U20 ( .A0(n10), .A1(Current_State[2]), .A2(n9), .B0(n3), .B1(n15), 
        .Y(Next_State[0]) );
  INVX2M U21 ( .A(Data_Valid), .Y(n10) );
endmodule


module Serializer_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHX1M U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX1M U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHX1M U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1M U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1M U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1M U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  INVX2M U1 ( .A(A[0]), .Y(SUM[0]) );
  CLKXOR2X2M U2 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
endmodule


module Serializer ( CLK, RST, Data_Valid, ser_en, P_DATA, ser_done, ser_data
 );
  input [7:0] P_DATA;
  input CLK, RST, Data_Valid, ser_en;
  output ser_done, ser_data;
  wire   N8, N9, N10, N11, N12, N13, N14, N15, N25, N35, n2, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n1, n3, n33,
         n34, n35, n36, n37, n38, n39, n40, n41;
  wire   [7:0] IN_Data;
  wire   [7:0] Counter;

  Serializer_DW01_inc_0 add_35 ( .A({Counter[7:6], n3, Counter[4:0]}), .SUM({
        N15, N14, N13, N12, N11, N10, N9, N8}) );
  DFFRQX1M ser_data_reg ( .D(N25), .CK(CLK), .RN(n37), .Q(ser_data) );
  DFFRQX1M \IN_Data_reg[7]  ( .D(n26), .CK(CLK), .RN(n38), .Q(IN_Data[7]) );
  DFFRQX1M \IN_Data_reg[6]  ( .D(n27), .CK(CLK), .RN(n38), .Q(IN_Data[6]) );
  DFFRQX1M \IN_Data_reg[5]  ( .D(n28), .CK(CLK), .RN(n38), .Q(IN_Data[5]) );
  DFFRQX1M \IN_Data_reg[4]  ( .D(n29), .CK(CLK), .RN(n38), .Q(IN_Data[4]) );
  DFFRQX1M \IN_Data_reg[3]  ( .D(n30), .CK(CLK), .RN(n38), .Q(IN_Data[3]) );
  DFFRQX1M \IN_Data_reg[2]  ( .D(n31), .CK(CLK), .RN(n37), .Q(IN_Data[2]) );
  DFFRQX1M \IN_Data_reg[1]  ( .D(n32), .CK(CLK), .RN(n37), .Q(IN_Data[1]) );
  DFFRX1M \IN_Data_reg[0]  ( .D(n25), .CK(CLK), .RN(n37), .Q(n16) );
  DFFRQX1M ser_done_reg ( .D(N35), .CK(CLK), .RN(n37), .Q(ser_done) );
  DFFRX1M \Counter_reg[5]  ( .D(n19), .CK(CLK), .RN(n37), .Q(Counter[5]), .QN(
        n1) );
  DFFRX1M \Counter_reg[0]  ( .D(n24), .CK(CLK), .RN(n37), .Q(Counter[0]), .QN(
        n40) );
  DFFRX4M \Counter_reg[4]  ( .D(n20), .CK(CLK), .RN(n37), .Q(Counter[4]) );
  DFFRX4M \Counter_reg[2]  ( .D(n22), .CK(CLK), .RN(n37), .Q(Counter[2]) );
  DFFRX4M \Counter_reg[3]  ( .D(n21), .CK(CLK), .RN(n37), .Q(Counter[3]) );
  DFFRX4M \Counter_reg[1]  ( .D(n23), .CK(CLK), .RN(n37), .Q(Counter[1]) );
  DFFRX4M \Counter_reg[6]  ( .D(n18), .CK(CLK), .RN(n37), .Q(Counter[6]) );
  DFFRX4M \Counter_reg[7]  ( .D(n17), .CK(CLK), .RN(n37), .Q(Counter[7]) );
  CLKINVX1M U3 ( .A(RST), .Y(n39) );
  NOR4X2M U4 ( .A(Counter[7]), .B(Counter[6]), .C(Counter[5]), .D(Counter[4]), 
        .Y(n15) );
  INVXLM U5 ( .A(n1), .Y(n3) );
  NAND4X2M U6 ( .A(Counter[2]), .B(Counter[1]), .C(n14), .D(n15), .Y(n4) );
  INVX4M U7 ( .A(n35), .Y(n41) );
  INVX6M U8 ( .A(n39), .Y(n37) );
  INVX4M U9 ( .A(n39), .Y(n38) );
  NOR2X8M U10 ( .A(n33), .B(n35), .Y(n6) );
  INVX4M U11 ( .A(n34), .Y(n35) );
  INVX4M U12 ( .A(n34), .Y(n36) );
  CLKBUFX6M U13 ( .A(n7), .Y(n33) );
  NOR2X2M U14 ( .A(Data_Valid), .B(n36), .Y(n7) );
  INVX2M U15 ( .A(ser_en), .Y(n34) );
  CLKAND2X4M U16 ( .A(n4), .B(n35), .Y(n2) );
  NOR2X2M U17 ( .A(n41), .B(n4), .Y(N35) );
  OAI2BB1X2M U18 ( .A0N(n35), .A1N(IN_Data[2]), .B0(n13), .Y(n32) );
  AOI22X1M U19 ( .A0(P_DATA[1]), .A1(n6), .B0(IN_Data[1]), .B1(n33), .Y(n13)
         );
  OAI2BB1X2M U20 ( .A0N(n36), .A1N(IN_Data[3]), .B0(n12), .Y(n31) );
  AOI22X1M U21 ( .A0(P_DATA[2]), .A1(n6), .B0(IN_Data[2]), .B1(n33), .Y(n12)
         );
  OAI2BB1X2M U22 ( .A0N(n35), .A1N(IN_Data[4]), .B0(n11), .Y(n30) );
  AOI22X1M U23 ( .A0(P_DATA[3]), .A1(n6), .B0(IN_Data[3]), .B1(n33), .Y(n11)
         );
  OAI2BB1X2M U24 ( .A0N(n36), .A1N(IN_Data[5]), .B0(n10), .Y(n29) );
  AOI22X1M U25 ( .A0(P_DATA[4]), .A1(n6), .B0(IN_Data[4]), .B1(n33), .Y(n10)
         );
  OAI2BB1X2M U26 ( .A0N(n35), .A1N(IN_Data[6]), .B0(n9), .Y(n28) );
  AOI22X1M U27 ( .A0(P_DATA[5]), .A1(n6), .B0(IN_Data[5]), .B1(n33), .Y(n9) );
  OAI2BB1X2M U28 ( .A0N(n36), .A1N(IN_Data[7]), .B0(n8), .Y(n27) );
  AOI22X1M U29 ( .A0(P_DATA[6]), .A1(n6), .B0(IN_Data[6]), .B1(n33), .Y(n8) );
  OAI2BB1X2M U30 ( .A0N(n35), .A1N(IN_Data[1]), .B0(n5), .Y(n25) );
  AOI22X1M U31 ( .A0(P_DATA[0]), .A1(n6), .B0(n16), .B1(n33), .Y(n5) );
  OAI2BB2X1M U32 ( .B0(n36), .B1(n40), .A0N(N8), .A1N(n2), .Y(n24) );
  AO22X1M U33 ( .A0(n33), .A1(IN_Data[7]), .B0(P_DATA[7]), .B1(n6), .Y(n26) );
  AO22X1M U34 ( .A0(n41), .A1(Counter[7]), .B0(N15), .B1(n2), .Y(n17) );
  AO22X1M U35 ( .A0(n41), .A1(Counter[6]), .B0(N14), .B1(n2), .Y(n18) );
  AO22X1M U36 ( .A0(n41), .A1(Counter[5]), .B0(N13), .B1(n2), .Y(n19) );
  AO22X1M U37 ( .A0(n41), .A1(Counter[4]), .B0(N12), .B1(n2), .Y(n20) );
  AO22X1M U38 ( .A0(n41), .A1(Counter[3]), .B0(N11), .B1(n2), .Y(n21) );
  AO22X1M U39 ( .A0(n41), .A1(Counter[2]), .B0(N10), .B1(n2), .Y(n22) );
  AO22X1M U40 ( .A0(n41), .A1(Counter[1]), .B0(N9), .B1(n2), .Y(n23) );
  AND2X2M U41 ( .A(n16), .B(n36), .Y(N25) );
  NOR2X2M U42 ( .A(Counter[3]), .B(n40), .Y(n14) );
endmodule


module Parity_Calc ( CLK, RST, PAR_TYP, Data_Valid, par_en, P_DATA, par_bit );
  input [7:0] P_DATA;
  input CLK, RST, PAR_TYP, Data_Valid, par_en;
  output par_bit;
  wire   n1, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n2, n16,
         n17, n18, n19, n20;
  wire   [7:0] IN_Data;

  DFFRQX1M par_bit_reg ( .D(n7), .CK(CLK), .RN(n18), .Q(par_bit) );
  DFFRQX1M \IN_Data_reg[5]  ( .D(n13), .CK(CLK), .RN(n18), .Q(IN_Data[5]) );
  DFFRQX1M \IN_Data_reg[1]  ( .D(n9), .CK(CLK), .RN(n18), .Q(IN_Data[1]) );
  DFFRQX1M \IN_Data_reg[4]  ( .D(n12), .CK(CLK), .RN(n18), .Q(IN_Data[4]) );
  DFFRQX1M \IN_Data_reg[0]  ( .D(n8), .CK(CLK), .RN(n18), .Q(IN_Data[0]) );
  DFFRQX1M \IN_Data_reg[2]  ( .D(n10), .CK(CLK), .RN(n18), .Q(IN_Data[2]) );
  DFFRQX1M \IN_Data_reg[7]  ( .D(n15), .CK(CLK), .RN(n18), .Q(IN_Data[7]) );
  DFFRQX1M \IN_Data_reg[3]  ( .D(n11), .CK(CLK), .RN(n18), .Q(IN_Data[3]) );
  DFFRQX1M \IN_Data_reg[6]  ( .D(n14), .CK(CLK), .RN(n18), .Q(IN_Data[6]) );
  CLKINVX1M U2 ( .A(RST), .Y(n19) );
  INVX4M U3 ( .A(n2), .Y(n16) );
  INVX4M U4 ( .A(n2), .Y(n17) );
  INVX6M U5 ( .A(n19), .Y(n18) );
  INVX2M U6 ( .A(Data_Valid), .Y(n2) );
  AO2B2X2M U7 ( .B0(P_DATA[0]), .B1(n16), .A0(IN_Data[0]), .A1N(n16), .Y(n8)
         );
  AO2B2X2M U8 ( .B0(P_DATA[1]), .B1(n17), .A0(IN_Data[1]), .A1N(n17), .Y(n9)
         );
  AO2B2X2M U9 ( .B0(P_DATA[2]), .B1(n16), .A0(IN_Data[2]), .A1N(n16), .Y(n10)
         );
  AO2B2X2M U10 ( .B0(P_DATA[3]), .B1(n17), .A0(IN_Data[3]), .A1N(n17), .Y(n11)
         );
  AO2B2X2M U11 ( .B0(P_DATA[4]), .B1(n16), .A0(IN_Data[4]), .A1N(n16), .Y(n12)
         );
  AO2B2X2M U12 ( .B0(P_DATA[5]), .B1(n17), .A0(IN_Data[5]), .A1N(n17), .Y(n13)
         );
  AO2B2X2M U13 ( .B0(P_DATA[6]), .B1(n16), .A0(IN_Data[6]), .A1N(n16), .Y(n14)
         );
  AO2B2X2M U14 ( .B0(P_DATA[7]), .B1(n17), .A0(IN_Data[7]), .A1N(n17), .Y(n15)
         );
  XNOR2X2M U15 ( .A(IN_Data[2]), .B(IN_Data[3]), .Y(n5) );
  OAI2BB2X1M U16 ( .B0(n1), .B1(n20), .A0N(par_bit), .A1N(n20), .Y(n7) );
  INVX2M U17 ( .A(par_en), .Y(n20) );
  XOR3XLM U18 ( .A(n3), .B(PAR_TYP), .C(n4), .Y(n1) );
  XOR3XLM U19 ( .A(IN_Data[1]), .B(IN_Data[0]), .C(n5), .Y(n4) );
  XOR3XLM U20 ( .A(IN_Data[5]), .B(IN_Data[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U21 ( .A(IN_Data[7]), .B(IN_Data[6]), .Y(n6) );
endmodule


module MUX ( CLK, RST, mux_sel, ser_data, par_bit, TX_OUT );
  input [1:0] mux_sel;
  input CLK, RST, ser_data, par_bit;
  output TX_OUT;
  wire   N13, n2, n3, n1;

  DFFSQX2M TX_OUT_reg ( .D(N13), .CK(CLK), .SN(RST), .Q(TX_OUT) );
  OAI21X2M U3 ( .A0(n2), .A1(n1), .B0(n3), .Y(N13) );
  NAND3X2M U4 ( .A(mux_sel[1]), .B(n1), .C(ser_data), .Y(n3) );
  INVX2M U5 ( .A(mux_sel[0]), .Y(n1) );
  NOR2BX2M U6 ( .AN(mux_sel[1]), .B(par_bit), .Y(n2) );
endmodule


module UART_TX ( CLK, RST, PAR_EN, PAR_TYP, Data_Valid, P_DATA, TX_OUT, busy
 );
  input [7:0] P_DATA;
  input CLK, RST, PAR_EN, PAR_TYP, Data_Valid;
  output TX_OUT, busy;
  wire   ser_done, ser_en, par_en, ser_data, par_bit, n1, n2;
  wire   [1:0] mux_sel;

  TX_FSM DUT_fsm ( .CLK(CLK), .RST(n1), .Data_Valid(Data_Valid), .PAR_EN(
        PAR_EN), .ser_done(ser_done), .busy(busy), .mux_sel(mux_sel), .ser_en(
        ser_en), .par_en(par_en) );
  Serializer DUT_ser ( .CLK(CLK), .RST(n1), .Data_Valid(Data_Valid), .ser_en(
        ser_en), .P_DATA(P_DATA), .ser_done(ser_done), .ser_data(ser_data) );
  Parity_Calc DUT_par ( .CLK(CLK), .RST(n1), .PAR_TYP(PAR_TYP), .Data_Valid(
        Data_Valid), .par_en(par_en), .P_DATA(P_DATA), .par_bit(par_bit) );
  MUX DUT_mux ( .CLK(CLK), .RST(n1), .mux_sel(mux_sel), .ser_data(ser_data), 
        .par_bit(par_bit), .TX_OUT(TX_OUT) );
  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
endmodule


module RX_FSM ( CLK, RST, RX_IN, PAR_EN, edge_cnt, bit_cnt, parr_err, 
        strt_glitch, stp_err, prescale, data_valid, deser_en, data_sample_en, 
        enable, par_chk_en, strt_chk_en, stp_chk_en );
  input [5:0] edge_cnt;
  input [7:0] bit_cnt;
  input [5:0] prescale;
  input CLK, RST, RX_IN, PAR_EN, parr_err, strt_glitch, stp_err;
  output data_valid, deser_en, data_sample_en, enable, par_chk_en, strt_chk_en,
         stp_chk_en;
  wire   N102, n18, n19, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, enable, n2, n3, n4, n5, n6,
         n7, n8, n9, n10, n11, n12, n13, n14, n15, n20, n21, n41, n42, n43,
         n44;
  wire   [31:0] Current_State;
  wire   [2:0] Next_State;
  assign data_sample_en = enable;

  OAI33X4M U45 ( .A0(n21), .A1(PAR_EN), .A2(n25), .B0(n35), .B1(RX_IN), .B2(
        Current_State[1]), .Y(n34) );
  DFFRQX4M \Current_State_reg[1]  ( .D(Next_State[1]), .CK(CLK), .RN(n2), .Q(
        Current_State[1]) );
  DFFRQX4M \Current_State_reg[2]  ( .D(Next_State[2]), .CK(CLK), .RN(n2), .Q(
        Current_State[2]) );
  DFFRX2M \Current_State_reg[0]  ( .D(Next_State[0]), .CK(CLK), .RN(RST), .Q(
        Current_State[0]), .QN(n20) );
  CLKXOR2X2M U3 ( .A(Current_State[2]), .B(Current_State[0]), .Y(n35) );
  NOR4X1M U4 ( .A(n19), .B(Current_State[1]), .C(stp_err), .D(parr_err), .Y(
        data_valid) );
  NOR3X6M U5 ( .A(Current_State[1]), .B(Current_State[0]), .C(n42), .Y(
        stp_chk_en) );
  CLKINVX1M U6 ( .A(Current_State[2]), .Y(n42) );
  NOR4X4M U7 ( .A(n11), .B(n10), .C(n9), .D(n8), .Y(N102) );
  NOR4X4M U8 ( .A(bit_cnt[7]), .B(bit_cnt[6]), .C(bit_cnt[5]), .D(bit_cnt[4]), 
        .Y(n40) );
  NOR2X2M U9 ( .A(bit_cnt[2]), .B(bit_cnt[1]), .Y(n39) );
  NOR3X6M U10 ( .A(Current_State[1]), .B(Current_State[2]), .C(n20), .Y(
        strt_chk_en) );
  NAND3X2M U11 ( .A(n20), .B(n43), .C(Current_State[2]), .Y(n23) );
  OAI211X2M U12 ( .A0(Current_State[2]), .A1(n20), .B0(n23), .C0(n24), .Y(n22)
         );
  NAND2XLM U13 ( .A(Current_State[2]), .B(Current_State[0]), .Y(n19) );
  INVX2M U14 ( .A(Current_State[1]), .Y(n43) );
  CLKBUFX6M U15 ( .A(n22), .Y(enable) );
  NOR2BX2M U16 ( .AN(prescale[0]), .B(edge_cnt[0]), .Y(n4) );
  NOR2BX2M U17 ( .AN(edge_cnt[0]), .B(prescale[0]), .Y(n3) );
  NAND2X2M U18 ( .A(Current_State[0]), .B(n41), .Y(n18) );
  BUFX2M U19 ( .A(RST), .Y(n2) );
  INVX2M U20 ( .A(n30), .Y(deser_en) );
  OAI211X2M U21 ( .A0(n25), .A1(n18), .B0(n26), .C0(n21), .Y(Next_State[2]) );
  NAND3X2M U22 ( .A(n27), .B(n44), .C(deser_en), .Y(n26) );
  INVX2M U23 ( .A(n25), .Y(n14) );
  OAI21X2M U24 ( .A0(n14), .A1(n18), .B0(n28), .Y(Next_State[1]) );
  AOI31X2M U25 ( .A0(n13), .A1(n12), .A2(strt_chk_en), .B0(n29), .Y(n28) );
  INVX2M U26 ( .A(n31), .Y(n13) );
  AOI21X2M U27 ( .A0(n27), .A1(n44), .B0(n30), .Y(n29) );
  INVX2M U28 ( .A(n24), .Y(n41) );
  NAND2X2M U29 ( .A(n20), .B(n41), .Y(n30) );
  INVX2M U30 ( .A(stp_chk_en), .Y(n21) );
  INVX2M U31 ( .A(n18), .Y(par_chk_en) );
  OAI221X1M U32 ( .A0(n32), .A1(n44), .B0(n14), .B1(n18), .C0(n33), .Y(
        Next_State[0]) );
  AOI32X1M U33 ( .A0(stp_chk_en), .A1(n37), .A2(n38), .B0(deser_en), .B1(n27), 
        .Y(n32) );
  AOI31X2M U34 ( .A0(n31), .A1(n12), .A2(strt_chk_en), .B0(n34), .Y(n33) );
  AND2X1M U35 ( .A(N102), .B(bit_cnt[0]), .Y(n38) );
  NAND3BX2M U36 ( .AN(bit_cnt[0]), .B(N102), .C(n37), .Y(n25) );
  AND4X1M U37 ( .A(bit_cnt[0]), .B(N102), .C(n39), .D(n40), .Y(n36) );
  NAND2BX2M U38 ( .AN(bit_cnt[3]), .B(n36), .Y(n31) );
  AND2X2M U39 ( .A(bit_cnt[3]), .B(n36), .Y(n27) );
  NAND2X2M U40 ( .A(Current_State[1]), .B(n42), .Y(n24) );
  AND4X2M U41 ( .A(n15), .B(bit_cnt[3]), .C(bit_cnt[1]), .D(n40), .Y(n37) );
  INVX2M U42 ( .A(bit_cnt[2]), .Y(n15) );
  INVX2M U43 ( .A(strt_glitch), .Y(n12) );
  INVX2M U44 ( .A(PAR_EN), .Y(n44) );
  OAI2B2X1M U46 ( .A1N(prescale[1]), .A0(n3), .B0(edge_cnt[1]), .B1(n3), .Y(n7) );
  OAI2B2X1M U47 ( .A1N(edge_cnt[1]), .A0(n4), .B0(prescale[1]), .B1(n4), .Y(n6) );
  XNOR2X1M U48 ( .A(prescale[5]), .B(edge_cnt[5]), .Y(n5) );
  NAND3X1M U49 ( .A(n7), .B(n6), .C(n5), .Y(n11) );
  CLKXOR2X2M U50 ( .A(prescale[4]), .B(edge_cnt[4]), .Y(n10) );
  CLKXOR2X2M U51 ( .A(prescale[2]), .B(edge_cnt[2]), .Y(n9) );
  CLKXOR2X2M U52 ( .A(prescale[3]), .B(edge_cnt[3]), .Y(n8) );
endmodule


module edge_bit_counter_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHX1M U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX1M U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1M U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1M U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1M U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHX1M U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  INVX2M U1 ( .A(A[0]), .Y(SUM[0]) );
  CLKXOR2X2M U2 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
endmodule


module edge_bit_counter ( CLK, RST, enable, prescale, edge_cnt, bit_cnt );
  input [5:0] prescale;
  output [5:0] edge_cnt;
  output [7:0] bit_cnt;
  input CLK, RST, enable;
  wire   n49, n50, n51, n52, n53, n54, n55, n56, N8, N9, N10, N11, N12, N13,
         N14, N15, N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29,
         n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18,
         \add_23_aco/carry[5] , \add_23_aco/carry[4] , \add_23_aco/carry[3] ,
         \add_23_aco/carry[2] , n1, n2, n3, n4, n5, n6, n19, n21, n23, n25,
         n27, n29, n31, n33, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48;

  edge_bit_counter_DW01_inc_0 add_26 ( .A(bit_cnt), .SUM({N15, N14, N13, N12, 
        N11, N10, N9, N8}) );
  DFFRQX1M \bit_cnt_reg[3]  ( .D(n14), .CK(CLK), .RN(n36), .Q(n55) );
  DFFRQX1M \bit_cnt_reg[0]  ( .D(n17), .CK(CLK), .RN(n36), .Q(n56) );
  DFFRQX1M \edge_cnt_reg[2]  ( .D(N26), .CK(CLK), .RN(n36), .Q(n52) );
  DFFRQX1M \edge_cnt_reg[3]  ( .D(N27), .CK(CLK), .RN(n36), .Q(n51) );
  DFFRQX1M \edge_cnt_reg[4]  ( .D(N28), .CK(CLK), .RN(n36), .Q(n50) );
  DFFRQX1M \edge_cnt_reg[1]  ( .D(N25), .CK(CLK), .RN(n36), .Q(n53) );
  DFFRQX1M \edge_cnt_reg[0]  ( .D(N24), .CK(CLK), .RN(n36), .Q(n54) );
  DFFRQX1M \edge_cnt_reg[5]  ( .D(N29), .CK(CLK), .RN(n36), .Q(n49) );
  DFFRX4M \bit_cnt_reg[2]  ( .D(n15), .CK(CLK), .RN(n36), .Q(bit_cnt[2]) );
  DFFRX4M \bit_cnt_reg[1]  ( .D(n16), .CK(CLK), .RN(n36), .Q(bit_cnt[1]) );
  DFFRX4M \bit_cnt_reg[5]  ( .D(n12), .CK(CLK), .RN(n37), .Q(bit_cnt[5]) );
  DFFRX4M \bit_cnt_reg[6]  ( .D(n11), .CK(CLK), .RN(n37), .Q(bit_cnt[6]) );
  DFFRX4M \bit_cnt_reg[4]  ( .D(n13), .CK(CLK), .RN(n36), .Q(bit_cnt[4]) );
  DFFRX4M \bit_cnt_reg[7]  ( .D(n18), .CK(CLK), .RN(n36), .Q(bit_cnt[7]) );
  OR4X4M U3 ( .A(n47), .B(n46), .C(n45), .D(n44), .Y(n1) );
  AND2X2M U4 ( .A(edge_cnt[2]), .B(n1), .Y(n2) );
  AND2X2M U5 ( .A(edge_cnt[1]), .B(n1), .Y(n3) );
  AND2X2M U6 ( .A(edge_cnt[3]), .B(n1), .Y(n4) );
  AND2X2M U7 ( .A(edge_cnt[4]), .B(n1), .Y(n5) );
  AND2X2M U8 ( .A(n1), .B(edge_cnt[5]), .Y(n6) );
  INVXLM U9 ( .A(n55), .Y(n19) );
  INVX4M U10 ( .A(n19), .Y(bit_cnt[3]) );
  INVXLM U11 ( .A(n56), .Y(n21) );
  INVX4M U12 ( .A(n21), .Y(bit_cnt[0]) );
  INVXLM U13 ( .A(n51), .Y(n23) );
  INVX4M U14 ( .A(n23), .Y(edge_cnt[3]) );
  INVXLM U15 ( .A(n52), .Y(n25) );
  INVX4M U16 ( .A(n25), .Y(edge_cnt[2]) );
  INVXLM U17 ( .A(n50), .Y(n27) );
  INVX4M U18 ( .A(n27), .Y(edge_cnt[4]) );
  INVXLM U19 ( .A(n49), .Y(n29) );
  INVX6M U20 ( .A(n29), .Y(edge_cnt[5]) );
  INVXLM U21 ( .A(n54), .Y(n31) );
  INVX6M U22 ( .A(n31), .Y(edge_cnt[0]) );
  INVXLM U23 ( .A(n53), .Y(n33) );
  INVX8M U24 ( .A(n33), .Y(edge_cnt[1]) );
  NAND3X2M U25 ( .A(n43), .B(n42), .C(n41), .Y(n47) );
  NOR2BX2M U26 ( .AN(prescale[0]), .B(edge_cnt[0]), .Y(n40) );
  NOR2BX2M U27 ( .AN(edge_cnt[0]), .B(prescale[0]), .Y(n39) );
  INVX6M U28 ( .A(n38), .Y(n36) );
  INVX2M U29 ( .A(n38), .Y(n37) );
  INVX2M U30 ( .A(RST), .Y(n38) );
  INVX4M U31 ( .A(n8), .Y(n48) );
  CLKAND2X4M U32 ( .A(enable), .B(n8), .Y(n7) );
  AND2X1M U33 ( .A(N18), .B(enable), .Y(N24) );
  INVX2M U34 ( .A(n35), .Y(N18) );
  AND2X1M U35 ( .A(N19), .B(enable), .Y(N25) );
  AND2X1M U36 ( .A(N20), .B(enable), .Y(N26) );
  AND2X1M U37 ( .A(N21), .B(enable), .Y(N27) );
  AND2X1M U38 ( .A(N22), .B(enable), .Y(N28) );
  AND2X2M U39 ( .A(edge_cnt[0]), .B(n1), .Y(n35) );
  ADDHX1M U40 ( .A(n3), .B(n35), .CO(\add_23_aco/carry[2] ), .S(N19) );
  ADDHX1M U41 ( .A(n2), .B(\add_23_aco/carry[2] ), .CO(\add_23_aco/carry[3] ), 
        .S(N20) );
  ADDHX1M U42 ( .A(n4), .B(\add_23_aco/carry[3] ), .CO(\add_23_aco/carry[4] ), 
        .S(N21) );
  AND2X1M U43 ( .A(N23), .B(enable), .Y(N29) );
  ADDHX1M U44 ( .A(n5), .B(\add_23_aco/carry[4] ), .CO(\add_23_aco/carry[5] ), 
        .S(N22) );
  OAI211X4M U45 ( .A0(n9), .A1(n10), .B0(n1), .C0(enable), .Y(n8) );
  OR3X2M U46 ( .A(edge_cnt[5]), .B(edge_cnt[4]), .C(edge_cnt[3]), .Y(n9) );
  OR3X2M U47 ( .A(edge_cnt[2]), .B(edge_cnt[1]), .C(edge_cnt[0]), .Y(n10) );
  AO22X1M U48 ( .A0(bit_cnt[0]), .A1(n48), .B0(N8), .B1(n7), .Y(n17) );
  AO22X1M U49 ( .A0(bit_cnt[3]), .A1(n48), .B0(N11), .B1(n7), .Y(n14) );
  AO22X1M U50 ( .A0(bit_cnt[2]), .A1(n48), .B0(N10), .B1(n7), .Y(n15) );
  AO22X1M U51 ( .A0(bit_cnt[1]), .A1(n48), .B0(N9), .B1(n7), .Y(n16) );
  AO22X1M U52 ( .A0(bit_cnt[6]), .A1(n48), .B0(N14), .B1(n7), .Y(n11) );
  AO22X1M U53 ( .A0(bit_cnt[5]), .A1(n48), .B0(N13), .B1(n7), .Y(n12) );
  AO22X1M U54 ( .A0(bit_cnt[4]), .A1(n48), .B0(N12), .B1(n7), .Y(n13) );
  AO22X1M U55 ( .A0(bit_cnt[7]), .A1(n48), .B0(N15), .B1(n7), .Y(n18) );
  CLKXOR2X2M U56 ( .A(\add_23_aco/carry[5] ), .B(n6), .Y(N23) );
  OAI2B2X1M U57 ( .A1N(prescale[1]), .A0(n39), .B0(edge_cnt[1]), .B1(n39), .Y(
        n43) );
  OAI2B2X1M U58 ( .A1N(edge_cnt[1]), .A0(n40), .B0(prescale[1]), .B1(n40), .Y(
        n42) );
  XNOR2X1M U59 ( .A(prescale[5]), .B(edge_cnt[5]), .Y(n41) );
  CLKXOR2X2M U60 ( .A(prescale[4]), .B(edge_cnt[4]), .Y(n46) );
  CLKXOR2X2M U61 ( .A(prescale[2]), .B(edge_cnt[2]), .Y(n45) );
  CLKXOR2X2M U62 ( .A(prescale[3]), .B(edge_cnt[3]), .Y(n44) );
endmodule


module data_sampling ( CLK, RST, RX_IN, prescale, data_sample_en, edge_cnt, 
        sampled_bit, Done );
  input [5:0] prescale;
  input [5:0] edge_cnt;
  input CLK, RST, RX_IN, data_sample_en;
  output sampled_bit, Done;
  wire   bit1_sampled, bit2_sampled, bit3_sampled, N9, N10, N11, N12, N13, N14,
         N16, N17, N18, N19, N20, N21, N40, N41, \add_30/carry[4] ,
         \add_30/carry[3] , \add_30/carry[2] , n1, n2, n3, n4, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n52;

  DFFSQX4M sampled_bit_reg ( .D(N41), .CK(CLK), .SN(n1), .Q(sampled_bit) );
  EDFFX1M bit3_sampled_reg ( .D(RX_IN), .E(n17), .CK(CLK), .Q(bit3_sampled) );
  EDFFX1M bit2_sampled_reg ( .D(RX_IN), .E(n14), .CK(CLK), .Q(bit2_sampled), 
        .QN(n13) );
  EDFFX1M bit1_sampled_reg ( .D(RX_IN), .E(n36), .CK(CLK), .Q(bit1_sampled), 
        .QN(n35) );
  DFFRX4M Done_reg ( .D(N40), .CK(CLK), .RN(n1), .Q(Done) );
  OAI22X4M U3 ( .A0(N19), .A1(n25), .B0(N16), .B1(n26), .Y(n19) );
  INVX4M U4 ( .A(prescale[1]), .Y(N16) );
  INVX4M U5 ( .A(edge_cnt[3]), .Y(n25) );
  NOR3X4M U6 ( .A(prescale[4]), .B(prescale[5]), .C(n3), .Y(N13) );
  AOI222X2M U7 ( .A0(N19), .A1(n25), .B0(n22), .B1(n44), .C0(N18), .C1(n34), 
        .Y(n43) );
  AOI2BB2X2M U8 ( .B0(n45), .B1(edge_cnt[1]), .A0N(N18), .A1N(n34), .Y(n22) );
  NOR4X2M U9 ( .A(n12), .B(n11), .C(n10), .D(n9), .Y(N14) );
  NOR2X2M U10 ( .A(n23), .B(N14), .Y(n15) );
  NAND2X1M U11 ( .A(data_sample_en), .B(n1), .Y(n23) );
  NOR2BX2M U12 ( .AN(edge_cnt[0]), .B(N16), .Y(n5) );
  NOR2BX2M U13 ( .AN(N16), .B(edge_cnt[0]), .Y(n6) );
  NAND2X1M U14 ( .A(n22), .B(n15), .Y(n21) );
  OAI21X2M U15 ( .A0(N21), .A1(n39), .B0(n40), .Y(n27) );
  INVX2M U16 ( .A(edge_cnt[2]), .Y(n34) );
  INVX2M U17 ( .A(edge_cnt[4]), .Y(n24) );
  NAND4X2M U18 ( .A(n28), .B(n29), .C(n30), .D(n31), .Y(n16) );
  NOR3X2M U19 ( .A(n32), .B(edge_cnt[5]), .C(n33), .Y(n31) );
  XOR2X1M U20 ( .A(prescale[1]), .B(edge_cnt[0]), .Y(n33) );
  NOR3X2M U21 ( .A(n50), .B(n51), .C(n52), .Y(n49) );
  XOR2X1M U22 ( .A(prescale[1]), .B(edge_cnt[1]), .Y(n50) );
  OR2X2M U23 ( .A(n2), .B(prescale[3]), .Y(n3) );
  NAND2BX2M U24 ( .AN(prescale[2]), .B(N16), .Y(n2) );
  OAI2BB1XLM U25 ( .A0N(n2), .A1N(prescale[3]), .B0(n3), .Y(N10) );
  BUFX2M U26 ( .A(RST), .Y(n1) );
  ADDHX4M U27 ( .A(prescale[5]), .B(\add_30/carry[4] ), .CO(N21), .S(N20) );
  ADDHX1M U28 ( .A(prescale[2]), .B(prescale[1]), .CO(\add_30/carry[2] ), .S(
        N17) );
  ADDHX4M U29 ( .A(prescale[4]), .B(\add_30/carry[3] ), .CO(\add_30/carry[4] ), 
        .S(N19) );
  ADDHX2M U30 ( .A(prescale[3]), .B(\add_30/carry[2] ), .CO(\add_30/carry[3] ), 
        .S(N18) );
  OAI2BB1X1M U31 ( .A0N(prescale[1]), .A1N(prescale[2]), .B0(n2), .Y(N9) );
  XNOR2X1M U32 ( .A(prescale[4]), .B(n3), .Y(N11) );
  OAI21X1M U33 ( .A0(prescale[4]), .A1(n3), .B0(prescale[5]), .Y(n4) );
  NAND2BX1M U34 ( .AN(N13), .B(n4), .Y(N12) );
  OAI2B2X1M U35 ( .A1N(N9), .A0(n5), .B0(edge_cnt[1]), .B1(n5), .Y(n8) );
  OAI2B2X1M U36 ( .A1N(edge_cnt[1]), .A0(n6), .B0(N9), .B1(n6), .Y(n7) );
  NAND4BBX1M U37 ( .AN(N13), .BN(edge_cnt[5]), .C(n8), .D(n7), .Y(n12) );
  CLKXOR2X2M U38 ( .A(N12), .B(edge_cnt[4]), .Y(n11) );
  CLKXOR2X2M U39 ( .A(N10), .B(edge_cnt[2]), .Y(n10) );
  CLKXOR2X2M U40 ( .A(N11), .B(edge_cnt[3]), .Y(n9) );
  NOR2BX1M U41 ( .AN(n15), .B(n16), .Y(n14) );
  NOR4X1M U42 ( .A(n18), .B(n19), .C(n20), .D(n21), .Y(n17) );
  OAI2B2X1M U43 ( .A1N(edge_cnt[5]), .A0(N21), .B0(N20), .B1(n24), .Y(n20) );
  CLKNAND2X2M U44 ( .A(n27), .B(n16), .Y(n18) );
  CLKXOR2X2M U45 ( .A(prescale[5]), .B(edge_cnt[4]), .Y(n32) );
  CLKXOR2X2M U46 ( .A(prescale[3]), .B(n34), .Y(n30) );
  CLKXOR2X2M U47 ( .A(prescale[4]), .B(n25), .Y(n29) );
  XNOR2X1M U48 ( .A(prescale[2]), .B(edge_cnt[1]), .Y(n28) );
  NOR2BX1M U49 ( .AN(N14), .B(n23), .Y(n36) );
  OAI211X1M U50 ( .A0(n13), .A1(n35), .B0(n37), .C0(N40), .Y(N41) );
  OAI21X1M U51 ( .A0(bit1_sampled), .A1(bit2_sampled), .B0(bit3_sampled), .Y(
        n37) );
  AND3X1M U52 ( .A(n38), .B(n27), .C(data_sample_en), .Y(N40) );
  OAI2BB1X1M U53 ( .A0N(n39), .A1N(N21), .B0(edge_cnt[5]), .Y(n40) );
  OA21X1M U54 ( .A0(N20), .A1(n24), .B0(n41), .Y(n39) );
  OAI2BB2X1M U55 ( .B0(n42), .B1(n43), .A0N(n24), .A1N(N20), .Y(n41) );
  OAI2BB2X1M U56 ( .B0(edge_cnt[1]), .B1(n45), .A0N(n26), .A1N(N16), .Y(n44)
         );
  CLKINVX1M U57 ( .A(edge_cnt[0]), .Y(n26) );
  CLKINVX1M U58 ( .A(N17), .Y(n45) );
  NOR2X1M U59 ( .A(N19), .B(n25), .Y(n42) );
  NAND4X1M U60 ( .A(n46), .B(n47), .C(n48), .D(n49), .Y(n38) );
  CLKXOR2X2M U61 ( .A(prescale[0]), .B(edge_cnt[0]), .Y(n52) );
  CLKXOR2X2M U62 ( .A(prescale[2]), .B(edge_cnt[2]), .Y(n51) );
  CLKXOR2X2M U63 ( .A(prescale[4]), .B(n24), .Y(n48) );
  XNOR2X1M U64 ( .A(prescale[5]), .B(edge_cnt[5]), .Y(n47) );
  CLKXOR2X2M U65 ( .A(prescale[3]), .B(n25), .Y(n46) );
endmodule


module deserializer ( CLK, RST, deser_en, sampled_bit, edge_cnt, prescale, 
        P_DATA );
  input [5:0] edge_cnt;
  input [5:0] prescale;
  output [7:0] P_DATA;
  input CLK, RST, deser_en, sampled_bit;
  wire   N15, n3, n4, n6, n7, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n1, n2, n5, n8, n9, n21, n36, n37, n38, n39, n40, n41, n42, n43,
         n44;
  wire   [2:0] i;

  DFFRX4M \i_reg[0]  ( .D(n27), .CK(CLK), .RN(RST), .Q(i[0]), .QN(n41) );
  DFFRX4M \i_reg[2]  ( .D(n25), .CK(CLK), .RN(n1), .Q(i[2]) );
  DFFRX4M \i_reg[1]  ( .D(n26), .CK(CLK), .RN(n1), .Q(i[1]), .QN(n42) );
  DFFRX4M \P_DATA_reg[2]  ( .D(n33), .CK(CLK), .RN(n1), .Q(P_DATA[2]) );
  DFFRX4M \P_DATA_reg[6]  ( .D(n29), .CK(CLK), .RN(n1), .Q(P_DATA[6]) );
  DFFRX4M \P_DATA_reg[4]  ( .D(n31), .CK(CLK), .RN(n1), .Q(P_DATA[4]) );
  DFFRX4M \P_DATA_reg[0]  ( .D(n35), .CK(CLK), .RN(n1), .Q(P_DATA[0]) );
  DFFRX4M \P_DATA_reg[1]  ( .D(n34), .CK(CLK), .RN(n1), .Q(P_DATA[1]) );
  DFFRX4M \P_DATA_reg[5]  ( .D(n30), .CK(CLK), .RN(n1), .Q(P_DATA[5]) );
  DFFRX4M \P_DATA_reg[3]  ( .D(n32), .CK(CLK), .RN(n1), .Q(P_DATA[3]) );
  DFFRX4M \P_DATA_reg[7]  ( .D(n28), .CK(CLK), .RN(n1), .Q(P_DATA[7]) );
  CLKXOR2X2M U3 ( .A(prescale[3]), .B(edge_cnt[3]), .Y(n37) );
  NAND2X4M U4 ( .A(i[0]), .B(n42), .Y(n7) );
  NOR4X2M U5 ( .A(n40), .B(n39), .C(n38), .D(n37), .Y(N15) );
  NAND3X2M U6 ( .A(n36), .B(n21), .C(n9), .Y(n40) );
  NOR2BX2M U7 ( .AN(prescale[0]), .B(edge_cnt[0]), .Y(n8) );
  NOR2BX2M U8 ( .AN(edge_cnt[0]), .B(prescale[0]), .Y(n5) );
  NOR2X2M U9 ( .A(n6), .B(i[2]), .Y(n24) );
  INVX6M U10 ( .A(n2), .Y(n1) );
  INVX2M U11 ( .A(RST), .Y(n2) );
  INVX4M U12 ( .A(n24), .Y(n43) );
  INVX2M U13 ( .A(n6), .Y(n44) );
  OAI221X1M U14 ( .A0(n6), .A1(n7), .B0(n44), .B1(n42), .C0(n10), .Y(n26) );
  NAND2X2M U15 ( .A(n42), .B(n41), .Y(n16) );
  NAND2X3M U16 ( .A(deser_en), .B(N15), .Y(n6) );
  NAND2BX2M U17 ( .AN(n13), .B(sampled_bit), .Y(n11) );
  OAI2B2X1M U18 ( .A1N(i[2]), .A0(n3), .B0(n4), .B1(n43), .Y(n25) );
  NOR2X2M U19 ( .A(n4), .B(n6), .Y(n3) );
  NAND2X4M U20 ( .A(i[2]), .B(n44), .Y(n13) );
  NAND2X2M U21 ( .A(sampled_bit), .B(n24), .Y(n18) );
  OAI21X2M U22 ( .A0(n4), .A1(n18), .B0(n19), .Y(n32) );
  OAI21X2M U23 ( .A0(n4), .A1(n43), .B0(P_DATA[3]), .Y(n19) );
  OAI21X2M U24 ( .A0(n4), .A1(n11), .B0(n12), .Y(n28) );
  OAI21X2M U25 ( .A0(n4), .A1(n13), .B0(P_DATA[7]), .Y(n12) );
  OAI21X2M U26 ( .A0(n7), .A1(n18), .B0(n22), .Y(n34) );
  OAI21X2M U27 ( .A0(n43), .A1(n7), .B0(P_DATA[1]), .Y(n22) );
  OAI21X2M U28 ( .A0(n7), .A1(n11), .B0(n15), .Y(n30) );
  OAI21X2M U29 ( .A0(n7), .A1(n13), .B0(P_DATA[5]), .Y(n15) );
  OAI21X2M U30 ( .A0(n10), .A1(n18), .B0(n20), .Y(n33) );
  OAI21X2M U31 ( .A0(n43), .A1(n10), .B0(P_DATA[2]), .Y(n20) );
  OAI21X2M U32 ( .A0(n11), .A1(n10), .B0(n14), .Y(n29) );
  OAI21X2M U33 ( .A0(n13), .A1(n10), .B0(P_DATA[6]), .Y(n14) );
  OAI21X2M U34 ( .A0(n16), .A1(n18), .B0(n23), .Y(n35) );
  OAI21X2M U35 ( .A0(n43), .A1(n16), .B0(P_DATA[0]), .Y(n23) );
  OAI21X2M U36 ( .A0(n11), .A1(n16), .B0(n17), .Y(n31) );
  OAI21X2M U37 ( .A0(n13), .A1(n16), .B0(P_DATA[4]), .Y(n17) );
  XNOR2X2M U38 ( .A(i[0]), .B(n6), .Y(n27) );
  NAND2X4M U39 ( .A(i[1]), .B(i[0]), .Y(n4) );
  NAND2X4M U40 ( .A(i[1]), .B(n41), .Y(n10) );
  OAI2B2X1M U41 ( .A1N(prescale[1]), .A0(n5), .B0(edge_cnt[1]), .B1(n5), .Y(
        n36) );
  OAI2B2X1M U42 ( .A1N(edge_cnt[1]), .A0(n8), .B0(prescale[1]), .B1(n8), .Y(
        n21) );
  XNOR2X1M U43 ( .A(prescale[5]), .B(edge_cnt[5]), .Y(n9) );
  CLKXOR2X2M U44 ( .A(prescale[4]), .B(edge_cnt[4]), .Y(n39) );
  CLKXOR2X2M U45 ( .A(prescale[2]), .B(edge_cnt[2]), .Y(n38) );
endmodule


module parity_check ( CLK, RST, par_chk_en, sampled_bit, PAR_TYP, P_DATA, Done, 
        parr_err );
  input [7:0] P_DATA;
  input CLK, RST, par_chk_en, sampled_bit, PAR_TYP, Done;
  output parr_err;
  wire   n11, n1, n2, n3, n4, n5, n6, n7, n8, n9;

  DFFRQX1M parr_err_reg ( .D(n8), .CK(CLK), .RN(RST), .Q(n11) );
  CLKINVX4M U2 ( .A(n9), .Y(parr_err) );
  XNOR2X2M U3 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
  XNOR2X2M U4 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n7) );
  INVXLM U5 ( .A(n11), .Y(n9) );
  OAI2BB2X1M U6 ( .B0(n1), .B1(n2), .A0N(parr_err), .A1N(n2), .Y(n8) );
  XOR3XLM U7 ( .A(n3), .B(n4), .C(n5), .Y(n1) );
  NAND2X2M U8 ( .A(par_chk_en), .B(Done), .Y(n2) );
  XNOR2X2M U9 ( .A(sampled_bit), .B(PAR_TYP), .Y(n5) );
  XOR3XLM U10 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n4) );
  XOR3XLM U11 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n7), .Y(n3) );
endmodule


module strt_check ( CLK, RST, strt_chk_en, sampled_bit, Done, strt_glitch );
  input CLK, RST, strt_chk_en, sampled_bit, Done;
  output strt_glitch;
  wire   N1;

  DFFRQX1M strt_glitch_reg ( .D(N1), .CK(CLK), .RN(RST), .Q(strt_glitch) );
  AND3X2M U3 ( .A(sampled_bit), .B(Done), .C(strt_chk_en), .Y(N1) );
endmodule


module stp_check ( CLK, RST, stp_chk_en, sampled_bit, Done, stp_err );
  input CLK, RST, stp_chk_en, sampled_bit, Done;
  output stp_err;
  wire   N1, n1;

  DFFRQX4M stp_err_reg ( .D(N1), .CK(CLK), .RN(RST), .Q(stp_err) );
  AND3XLM U3 ( .A(n1), .B(Done), .C(stp_chk_en), .Y(N1) );
  INVX2M U4 ( .A(sampled_bit), .Y(n1) );
endmodule


module UART_RX ( CLK, RST, PAR_EN, PAR_TYP, prescale, RX_IN, P_DATA, 
        data_valid, parr_err, Framing_error );
  input [5:0] prescale;
  output [7:0] P_DATA;
  input CLK, RST, PAR_EN, PAR_TYP, RX_IN;
  output data_valid, parr_err, Framing_error;
  wire   strt_glitch, deser_en, data_sample_en, enable, par_chk_en,
         strt_chk_en, stp_chk_en, sampled_bit, Done, n1, n2;
  wire   [5:0] edge_cnt;
  wire   [7:0] bit_cnt;

  RX_FSM DUT_fsm ( .CLK(CLK), .RST(n1), .RX_IN(RX_IN), .PAR_EN(PAR_EN), 
        .edge_cnt(edge_cnt), .bit_cnt(bit_cnt), .parr_err(parr_err), 
        .strt_glitch(strt_glitch), .stp_err(Framing_error), .prescale(prescale), .data_valid(data_valid), .deser_en(deser_en), .data_sample_en(data_sample_en), .enable(enable), .par_chk_en(par_chk_en), .strt_chk_en(strt_chk_en), 
        .stp_chk_en(stp_chk_en) );
  edge_bit_counter DUT_edge_bit_cnt ( .CLK(CLK), .RST(n1), .enable(enable), 
        .prescale(prescale), .edge_cnt(edge_cnt), .bit_cnt(bit_cnt) );
  data_sampling DUT_data_samp ( .CLK(CLK), .RST(n1), .RX_IN(RX_IN), .prescale(
        prescale), .data_sample_en(data_sample_en), .edge_cnt(edge_cnt), 
        .sampled_bit(sampled_bit), .Done(Done) );
  deserializer DUT_deser ( .CLK(CLK), .RST(n1), .deser_en(deser_en), 
        .sampled_bit(sampled_bit), .edge_cnt(edge_cnt), .prescale(prescale), 
        .P_DATA(P_DATA) );
  parity_check DUT_par_chk ( .CLK(CLK), .RST(n1), .par_chk_en(par_chk_en), 
        .sampled_bit(sampled_bit), .PAR_TYP(PAR_TYP), .P_DATA(P_DATA), .Done(
        Done), .parr_err(parr_err) );
  strt_check DUT_strt_chk ( .CLK(CLK), .RST(n1), .strt_chk_en(strt_chk_en), 
        .sampled_bit(sampled_bit), .Done(Done), .strt_glitch(strt_glitch) );
  stp_check DUT_stp_chk ( .CLK(CLK), .RST(n1), .stp_chk_en(stp_chk_en), 
        .sampled_bit(sampled_bit), .Done(Done), .stp_err(Framing_error) );
  INVX4M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(RST), .Y(n2) );
endmodule


module UART ( PAR_EN, PAR_TYP, RST, TX_CLK, TX_IN_VLD, TX_IN_P, TX_OUT_S, 
        TX_OUT_VLD, RX_CLK, prescale, RX_IN_S, RX_OUT_P, RX_OUT_VLD, parr_err, 
        Framing_error );
  input [7:0] TX_IN_P;
  input [5:0] prescale;
  output [7:0] RX_OUT_P;
  input PAR_EN, PAR_TYP, RST, TX_CLK, TX_IN_VLD, RX_CLK, RX_IN_S;
  output TX_OUT_S, TX_OUT_VLD, RX_OUT_VLD, parr_err, Framing_error;


  UART_TX U0_UART_TX ( .CLK(TX_CLK), .RST(RST), .PAR_EN(PAR_EN), .PAR_TYP(
        PAR_TYP), .Data_Valid(TX_IN_VLD), .P_DATA(TX_IN_P), .TX_OUT(TX_OUT_S), 
        .busy(TX_OUT_VLD) );
  UART_RX U0_UART_RX ( .CLK(RX_CLK), .RST(RST), .PAR_EN(PAR_EN), .PAR_TYP(
        PAR_TYP), .prescale(prescale), .RX_IN(RX_IN_S), .P_DATA(RX_OUT_P), 
        .data_valid(RX_OUT_VLD), .parr_err(parr_err), .Framing_error(
        Framing_error) );
endmodule


module DATA_SYNC ( CLK, RST, bus_enable, Unsync_bus, sync_bus, enable_pulse );
  input [7:0] Unsync_bus;
  output [7:0] sync_bus;
  input CLK, RST, bus_enable;
  output enable_pulse;
  wire   pulse, N1, n2, n3, n4, n5, n6, n7, n8, n9, n1, n10, n11, n12;
  wire   [1:0] sync_reg;

  DFFRQX2M \sync_reg_reg[1]  ( .D(sync_reg[0]), .CK(CLK), .RN(n10), .Q(
        sync_reg[1]) );
  DFFRQX2M \sync_reg_reg[0]  ( .D(bus_enable), .CK(CLK), .RN(n10), .Q(
        sync_reg[0]) );
  DFFRQX2M pulse_reg ( .D(N1), .CK(CLK), .RN(n10), .Q(pulse) );
  DFFRQX2M \sync_bus_reg[7]  ( .D(n9), .CK(CLK), .RN(n10), .Q(sync_bus[7]) );
  DFFRQX2M \sync_bus_reg[5]  ( .D(n7), .CK(CLK), .RN(n10), .Q(sync_bus[5]) );
  DFFRQX2M \sync_bus_reg[3]  ( .D(n5), .CK(CLK), .RN(n10), .Q(sync_bus[3]) );
  DFFRQX2M \sync_bus_reg[0]  ( .D(n2), .CK(CLK), .RN(n10), .Q(sync_bus[0]) );
  DFFRQX2M \sync_bus_reg[6]  ( .D(n8), .CK(CLK), .RN(n10), .Q(sync_bus[6]) );
  DFFRQX2M \sync_bus_reg[1]  ( .D(n3), .CK(CLK), .RN(n10), .Q(sync_bus[1]) );
  DFFRQX2M enable_pulse_reg ( .D(pulse), .CK(CLK), .RN(n10), .Q(enable_pulse)
         );
  DFFRQX4M \sync_bus_reg[2]  ( .D(n4), .CK(CLK), .RN(n10), .Q(sync_bus[2]) );
  DFFRQX4M \sync_bus_reg[4]  ( .D(n6), .CK(CLK), .RN(n10), .Q(sync_bus[4]) );
  BUFX4M U3 ( .A(pulse), .Y(n1) );
  AO22XLM U4 ( .A0(sync_bus[4]), .A1(n12), .B0(Unsync_bus[4]), .B1(n1), .Y(n6)
         );
  AO22XLM U5 ( .A0(sync_bus[2]), .A1(n12), .B0(Unsync_bus[2]), .B1(n1), .Y(n4)
         );
  INVX4M U6 ( .A(n1), .Y(n12) );
  INVX6M U7 ( .A(n11), .Y(n10) );
  INVX2M U8 ( .A(RST), .Y(n11) );
  AO22X1M U9 ( .A0(sync_bus[0]), .A1(n12), .B0(n1), .B1(Unsync_bus[0]), .Y(n2)
         );
  AO22X1M U10 ( .A0(sync_bus[1]), .A1(n12), .B0(Unsync_bus[1]), .B1(n1), .Y(n3) );
  AO22X1M U11 ( .A0(sync_bus[3]), .A1(n12), .B0(Unsync_bus[3]), .B1(n1), .Y(n5) );
  AO22X1M U12 ( .A0(sync_bus[5]), .A1(n12), .B0(Unsync_bus[5]), .B1(n1), .Y(n7) );
  AO22X1M U13 ( .A0(sync_bus[6]), .A1(n12), .B0(Unsync_bus[6]), .B1(n1), .Y(n8) );
  AO22X1M U14 ( .A0(sync_bus[7]), .A1(n12), .B0(Unsync_bus[7]), .B1(n1), .Y(n9) );
  NOR2BX2M U15 ( .AN(sync_reg[1]), .B(sync_reg[0]), .Y(N1) );
endmodule


module PULSE_GEN ( CLK, RST, LVL_SIG, PULSE_SIG );
  input CLK, RST, LVL_SIG;
  output PULSE_SIG;
  wire   pls_flop, rcv_flop;

  DFFRQX1M pls_flop_reg ( .D(rcv_flop), .CK(CLK), .RN(RST), .Q(pls_flop) );
  DFFRQX1M rcv_flop_reg ( .D(LVL_SIG), .CK(CLK), .RN(RST), .Q(rcv_flop) );
  NOR2BX2M U3 ( .AN(rcv_flop), .B(pls_flop), .Y(PULSE_SIG) );
endmodule


module SYS_CTRL ( CLK, RST, ALU_OUT, OUT_Valid, RdData, RdData_Valid, 
        RX_P_DATA, RX_D_VLD, FIFO_FULL, parity_error, Framing_error, ALU_FUN, 
        ALU_EN, CLK_EN, Address, WrEn, RdEn, WrData, TX_P_DATA, TX_D_VLD, 
        clk_div_en );
  input [15:0] ALU_OUT;
  input [7:0] RdData;
  input [7:0] RX_P_DATA;
  output [3:0] ALU_FUN;
  output [3:0] Address;
  output [7:0] WrData;
  output [7:0] TX_P_DATA;
  input CLK, RST, OUT_Valid, RdData_Valid, RX_D_VLD, FIFO_FULL, parity_error,
         Framing_error;
  output ALU_EN, CLK_EN, WrEn, RdEn, TX_D_VLD, clk_div_en;
  wire   n91, n92, n1, n11, n12, n18, n20, n21, n23, n24, n25, n26, n27, n28,
         n30, n32, n33, n34, n35, n36, n37, n39, n40, n41, n43, n44, n48, n49,
         n50, n52, n53, n54, n55, n56, n57, n59, n60, n61, n62, n63, n64, n65,
         n66, n68, n69, n70, n71, n72, n75, n76, n77, n78, n3, n5, n7, n8, n9,
         n10, n13, n14, n15, n16, n17, n19, n22, n29, n31, n38, n45, n46, n47,
         n51, n58, n67, n73, n74, n79, n80, n81, n82, n83, n84, n85, n86, n87,
         n88, n89, n90;
  wire   [31:0] Current_State;
  wire   [3:0] Next_State;
  wire   [3:0] Temp_Address;
  assign clk_div_en = 1'b1;

  NOR3X12M U8 ( .A(n10), .B(RX_D_VLD), .C(n11), .Y(n1) );
  DFFRQX2M \Temp_Address_reg[1]  ( .D(n76), .CK(CLK), .RN(n13), .Q(
        Temp_Address[1]) );
  DFFRQX2M \Temp_Address_reg[0]  ( .D(n75), .CK(CLK), .RN(n13), .Q(
        Temp_Address[0]) );
  DFFRQX2M \Temp_Address_reg[3]  ( .D(n78), .CK(CLK), .RN(n13), .Q(
        Temp_Address[3]) );
  DFFRQX2M \Temp_Address_reg[2]  ( .D(n77), .CK(CLK), .RN(n13), .Q(
        Temp_Address[2]) );
  DFFRQX2M \Current_State_reg[3]  ( .D(Next_State[3]), .CK(CLK), .RN(n13), .Q(
        Current_State[3]) );
  DFFRX4M \Current_State_reg[0]  ( .D(Next_State[0]), .CK(CLK), .RN(RST), .Q(
        Current_State[0]), .QN(n19) );
  DFFRQX4M \Current_State_reg[1]  ( .D(Next_State[1]), .CK(CLK), .RN(n13), .Q(
        Current_State[1]) );
  DFFRQX4M \Current_State_reg[2]  ( .D(Next_State[2]), .CK(CLK), .RN(n13), .Q(
        Current_State[2]) );
  NOR2X8M U3 ( .A(n88), .B(n5), .Y(ALU_FUN[2]) );
  INVX2M U4 ( .A(RX_P_DATA[2]), .Y(n88) );
  NAND4X4M U5 ( .A(Current_State[2]), .B(n9), .C(Current_State[1]), .D(n19), 
        .Y(n24) );
  NAND4X4M U6 ( .A(Current_State[2]), .B(Current_State[0]), .C(n58), .D(n67), 
        .Y(n70) );
  NAND4X4M U7 ( .A(Current_State[2]), .B(n10), .C(Current_State[0]), .D(n58), 
        .Y(n21) );
  NOR2X4M U9 ( .A(Current_State[0]), .B(Current_State[2]), .Y(n50) );
  CLKINVX4M U10 ( .A(Current_State[2]), .Y(n73) );
  AOI31X2M U11 ( .A0(Current_State[2]), .A1(n67), .A2(n58), .B0(n56), .Y(n48)
         );
  NAND2X2M U12 ( .A(Current_State[1]), .B(n50), .Y(n11) );
  NOR4X4M U13 ( .A(n73), .B(n67), .C(Current_State[0]), .D(Current_State[1]), 
        .Y(n44) );
  NAND4X2M U14 ( .A(n10), .B(Current_State[0]), .C(Current_State[1]), .D(n73), 
        .Y(n33) );
  CLKBUFX6M U15 ( .A(n91), .Y(Address[3]) );
  OAI22X1M U16 ( .A0(n87), .A1(n70), .B0(n71), .B1(n74), .Y(n91) );
  BUFX4M U17 ( .A(n20), .Y(n3) );
  NOR3X2M U18 ( .A(n21), .B(OUT_Valid), .C(n16), .Y(n20) );
  CLKBUFX6M U19 ( .A(n92), .Y(Address[2]) );
  OAI22X1M U20 ( .A0(n88), .A1(n70), .B0(n71), .B1(n79), .Y(n92) );
  NOR2X6M U21 ( .A(n90), .B(n5), .Y(ALU_FUN[0]) );
  NOR2X4M U22 ( .A(n89), .B(n5), .Y(ALU_FUN[1]) );
  INVX2M U23 ( .A(n70), .Y(RdEn) );
  NAND2X2M U24 ( .A(n23), .B(n5), .Y(ALU_EN) );
  CLKBUFX6M U25 ( .A(n33), .Y(n5) );
  NAND2X2M U26 ( .A(OUT_Valid), .B(n51), .Y(n23) );
  INVX2M U27 ( .A(RX_P_DATA[1]), .Y(n89) );
  NOR3X2M U28 ( .A(n69), .B(RX_D_VLD), .C(n9), .Y(n65) );
  OR2X2M U29 ( .A(parity_error), .B(Framing_error), .Y(n26) );
  INVX2M U30 ( .A(n32), .Y(n31) );
  INVX4M U31 ( .A(WrEn), .Y(n7) );
  INVX2M U32 ( .A(n9), .Y(n67) );
  NAND2X2M U33 ( .A(n10), .B(n38), .Y(n32) );
  INVX2M U34 ( .A(n12), .Y(WrEn) );
  NOR2X2M U35 ( .A(n31), .B(n18), .Y(n12) );
  INVX2M U36 ( .A(n39), .Y(n46) );
  INVX4M U37 ( .A(n8), .Y(n10) );
  NOR3X6M U38 ( .A(n58), .B(n10), .C(n19), .Y(n18) );
  AND4X2M U39 ( .A(n5), .B(n21), .C(n11), .D(n72), .Y(n71) );
  AOI211X2M U40 ( .A0(n18), .A1(n73), .B0(n17), .C0(n68), .Y(n72) );
  INVX2M U41 ( .A(n24), .Y(n17) );
  NOR2X2M U42 ( .A(n87), .B(n5), .Y(ALU_FUN[3]) );
  INVX4M U43 ( .A(n8), .Y(n9) );
  AND2X2M U44 ( .A(n50), .B(n10), .Y(n68) );
  OAI221X1M U45 ( .A0(n71), .A1(n81), .B0(n90), .B1(n70), .C0(n32), .Y(
        Address[0]) );
  OAI22X1M U46 ( .A0(n89), .A1(n70), .B0(n71), .B1(n80), .Y(Address[1]) );
  OAI211X4M U47 ( .A0(n21), .A1(n16), .B0(n23), .C0(n24), .Y(TX_D_VLD) );
  INVX2M U48 ( .A(n21), .Y(n51) );
  INVX2M U49 ( .A(n69), .Y(n38) );
  AOI31X2M U50 ( .A0(n30), .A1(n11), .A2(n48), .B0(n82), .Y(n66) );
  NOR2X2M U51 ( .A(n7), .B(n90), .Y(WrData[0]) );
  NOR2X2M U52 ( .A(n7), .B(n88), .Y(WrData[2]) );
  NOR2X2M U53 ( .A(n7), .B(n86), .Y(WrData[4]) );
  NOR2X2M U54 ( .A(n7), .B(n85), .Y(WrData[5]) );
  NOR2X2M U55 ( .A(n12), .B(n84), .Y(WrData[6]) );
  INVX2M U56 ( .A(n1), .Y(n45) );
  OAI22X1M U57 ( .A0(n1), .A1(n81), .B0(n45), .B1(n90), .Y(n75) );
  OAI22X1M U58 ( .A0(n1), .A1(n80), .B0(n45), .B1(n89), .Y(n76) );
  OAI22X1M U59 ( .A0(n1), .A1(n79), .B0(n45), .B1(n88), .Y(n77) );
  OAI22X1M U60 ( .A0(n1), .A1(n74), .B0(n45), .B1(n87), .Y(n78) );
  NOR2X2M U61 ( .A(n44), .B(n68), .Y(n30) );
  NOR2X2M U62 ( .A(n7), .B(n87), .Y(WrData[3]) );
  NOR2X2M U63 ( .A(n7), .B(n89), .Y(WrData[1]) );
  NOR2X2M U64 ( .A(n7), .B(n83), .Y(WrData[7]) );
  INVX4M U65 ( .A(n23), .Y(n15) );
  INVX2M U66 ( .A(n48), .Y(n22) );
  NAND2BX2M U67 ( .AN(ALU_EN), .B(n24), .Y(CLK_EN) );
  INVX2M U68 ( .A(n5), .Y(n47) );
  NAND3X2M U69 ( .A(n90), .B(n86), .C(n43), .Y(n39) );
  INVX4M U70 ( .A(n14), .Y(n13) );
  INVX2M U71 ( .A(RST), .Y(n14) );
  INVX2M U72 ( .A(Current_State[3]), .Y(n8) );
  INVX4M U73 ( .A(Current_State[1]), .Y(n58) );
  INVX4M U74 ( .A(RX_P_DATA[0]), .Y(n90) );
  INVX4M U75 ( .A(RX_P_DATA[3]), .Y(n87) );
  AO22XLM U76 ( .A0(ALU_OUT[0]), .A1(n15), .B0(RdData[0]), .B1(n3), .Y(
        TX_P_DATA[0]) );
  AO22XLM U77 ( .A0(ALU_OUT[1]), .A1(n15), .B0(RdData[1]), .B1(n3), .Y(
        TX_P_DATA[1]) );
  AO22XLM U78 ( .A0(ALU_OUT[2]), .A1(n15), .B0(RdData[2]), .B1(n3), .Y(
        TX_P_DATA[2]) );
  AO22XLM U79 ( .A0(ALU_OUT[3]), .A1(n15), .B0(RdData[3]), .B1(n3), .Y(
        TX_P_DATA[3]) );
  AO22XLM U80 ( .A0(ALU_OUT[4]), .A1(n15), .B0(RdData[4]), .B1(n3), .Y(
        TX_P_DATA[4]) );
  AO22XLM U81 ( .A0(ALU_OUT[5]), .A1(n15), .B0(RdData[5]), .B1(n3), .Y(
        TX_P_DATA[5]) );
  AO22XLM U82 ( .A0(ALU_OUT[6]), .A1(n15), .B0(RdData[6]), .B1(n3), .Y(
        TX_P_DATA[6]) );
  AO22XLM U83 ( .A0(ALU_OUT[7]), .A1(n15), .B0(RdData[7]), .B1(n3), .Y(
        TX_P_DATA[7]) );
  NAND3X2M U84 ( .A(n58), .B(n73), .C(Current_State[0]), .Y(n69) );
  INVX2M U85 ( .A(Temp_Address[2]), .Y(n79) );
  INVX2M U86 ( .A(Temp_Address[3]), .Y(n74) );
  NOR4X4M U87 ( .A(n73), .B(n58), .C(Current_State[0]), .D(n9), .Y(n56) );
  OAI221X1M U88 ( .A0(n49), .A1(n26), .B0(FIFO_FULL), .B1(n23), .C0(n39), .Y(
        Next_State[1]) );
  NOR4BX2M U89 ( .AN(n11), .B(n55), .C(n56), .D(n31), .Y(n49) );
  OAI21X2M U90 ( .A0(OUT_Valid), .A1(n5), .B0(n57), .Y(n55) );
  OAI21X2M U91 ( .A0(n38), .A1(n44), .B0(RX_D_VLD), .Y(n57) );
  OAI211X2M U92 ( .A0(n34), .A1(n26), .B0(n27), .C0(n35), .Y(Next_State[2]) );
  AOI31X2M U93 ( .A0(n36), .A1(RX_P_DATA[4]), .A2(n37), .B0(n46), .Y(n35) );
  AOI221X2M U94 ( .A0(n44), .A1(n82), .B0(n47), .B1(OUT_Valid), .C0(n22), .Y(
        n34) );
  NOR3X2M U95 ( .A(n90), .B(RX_P_DATA[6]), .C(RX_P_DATA[2]), .Y(n37) );
  OAI21X2M U96 ( .A0(n25), .A1(n26), .B0(n27), .Y(Next_State[3]) );
  AOI211X2M U97 ( .A0(RdEn), .A1(RdData_Valid), .B0(n28), .C0(n29), .Y(n25) );
  INVX2M U98 ( .A(n30), .Y(n29) );
  OAI2B11X2M U99 ( .A1N(n18), .A0(n73), .B0(n32), .C0(n5), .Y(n28) );
  OAI21X2M U100 ( .A0(n59), .A1(n26), .B0(n60), .Y(Next_State[0]) );
  AOI32X1M U101 ( .A0(n36), .A1(n90), .A2(n61), .B0(n51), .B1(n62), .Y(n60) );
  NOR4X2M U102 ( .A(n47), .B(RdEn), .C(n65), .D(n66), .Y(n59) );
  NOR3X2M U103 ( .A(RX_P_DATA[2]), .B(RX_P_DATA[6]), .C(RX_P_DATA[4]), .Y(n61)
         );
  INVX2M U104 ( .A(RdData_Valid), .Y(n16) );
  INVX2M U105 ( .A(Temp_Address[1]), .Y(n80) );
  INVX2M U106 ( .A(Temp_Address[0]), .Y(n81) );
  AND2X2M U107 ( .A(n40), .B(n41), .Y(n27) );
  OAI21X2M U108 ( .A0(FIFO_FULL), .A1(n16), .B0(n51), .Y(n41) );
  AOI31X2M U109 ( .A0(RX_P_DATA[4]), .A1(RX_P_DATA[0]), .A2(n43), .B0(n15), 
        .Y(n40) );
  INVX2M U110 ( .A(RX_D_VLD), .Y(n82) );
  OAI21BX1M U111 ( .A0(RdData_Valid), .A1(OUT_Valid), .B0N(FIFO_FULL), .Y(n62)
         );
  AND4X2M U112 ( .A(n50), .B(n58), .C(n52), .D(n53), .Y(n43) );
  NOR3X2M U113 ( .A(n9), .B(RX_P_DATA[5]), .C(RX_P_DATA[1]), .Y(n52) );
  NOR3X2M U114 ( .A(n54), .B(n84), .C(n82), .Y(n53) );
  NAND3X2M U115 ( .A(RX_P_DATA[3]), .B(RX_P_DATA[2]), .C(RX_P_DATA[7]), .Y(n54) );
  INVX2M U116 ( .A(RX_P_DATA[4]), .Y(n86) );
  INVX2M U117 ( .A(RX_P_DATA[6]), .Y(n84) );
  AND4X2M U118 ( .A(RX_P_DATA[1]), .B(n50), .C(n63), .D(n64), .Y(n36) );
  NOR2X2M U119 ( .A(n9), .B(Current_State[1]), .Y(n63) );
  NOR4X2M U120 ( .A(n87), .B(n83), .C(n85), .D(n82), .Y(n64) );
  INVX2M U121 ( .A(RX_P_DATA[5]), .Y(n85) );
  INVX2M U122 ( .A(RX_P_DATA[7]), .Y(n83) );
endmodule


module RegFile ( CLK, RST, RdEn, WrEn, Address, WrData, RdData, RdData_VLD, 
        REG0, REG1, REG2, REG3 );
  input [3:0] Address;
  input [7:0] WrData;
  output [7:0] RdData;
  output [7:0] REG0;
  output [7:0] REG1;
  output [7:0] REG2;
  output [7:0] REG3;
  input CLK, RST, RdEn, WrEn;
  output RdData_VLD;
  wire   N11, N12, N13, N14, n273, n274, n275, n276, n277, n278,
         \regArr[4][7] , \regArr[4][6] , \regArr[4][5] , \regArr[4][4] ,
         \regArr[4][3] , \regArr[4][2] , \regArr[4][1] , \regArr[4][0] ,
         \regArr[5][7] , \regArr[5][6] , \regArr[5][5] , \regArr[5][4] ,
         \regArr[5][3] , \regArr[5][2] , \regArr[5][1] , \regArr[5][0] ,
         \regArr[6][7] , \regArr[6][6] , \regArr[6][5] , \regArr[6][4] ,
         \regArr[6][3] , \regArr[6][2] , \regArr[6][1] , \regArr[6][0] ,
         \regArr[7][7] , \regArr[7][6] , \regArr[7][5] , \regArr[7][4] ,
         \regArr[7][3] , \regArr[7][2] , \regArr[7][1] , \regArr[7][0] ,
         \regArr[8][7] , \regArr[8][6] , \regArr[8][5] , \regArr[8][4] ,
         \regArr[8][3] , \regArr[8][2] , \regArr[8][1] , \regArr[8][0] ,
         \regArr[9][7] , \regArr[9][6] , \regArr[9][5] , \regArr[9][4] ,
         \regArr[9][3] , \regArr[9][2] , \regArr[9][1] , \regArr[9][0] ,
         \regArr[10][7] , \regArr[10][6] , \regArr[10][5] , \regArr[10][4] ,
         \regArr[10][3] , \regArr[10][2] , \regArr[10][1] , \regArr[10][0] ,
         \regArr[11][7] , \regArr[11][6] , \regArr[11][5] , \regArr[11][4] ,
         \regArr[11][3] , \regArr[11][2] , \regArr[11][1] , \regArr[11][0] ,
         \regArr[12][7] , \regArr[12][6] , \regArr[12][5] , \regArr[12][4] ,
         \regArr[12][3] , \regArr[12][2] , \regArr[12][1] , \regArr[12][0] ,
         \regArr[13][7] , \regArr[13][6] , \regArr[13][5] , \regArr[13][4] ,
         \regArr[13][3] , \regArr[13][2] , \regArr[13][1] , \regArr[13][0] ,
         \regArr[14][7] , \regArr[14][6] , \regArr[14][5] , \regArr[14][4] ,
         \regArr[14][3] , \regArr[14][2] , \regArr[14][1] , \regArr[14][0] ,
         \regArr[15][7] , \regArr[15][6] , \regArr[15][5] , \regArr[15][4] ,
         \regArr[15][3] , \regArr[15][2] , \regArr[15][1] , \regArr[15][0] ,
         N36, N37, N38, N39, N40, N41, N42, N43, n13, n14, n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101,
         n102, n103, n104, n105, n106, n107, n108, n109, n110, n111, n112,
         n113, n114, n115, n116, n117, n118, n119, n120, n121, n122, n123,
         n124, n125, n126, n127, n128, n129, n130, n131, n132, n133, n134,
         n135, n136, n137, n138, n139, n140, n141, n142, n143, n144, n145,
         n146, n147, n148, n149, n150, n151, n152, n153, n154, n155, n156,
         n157, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n174, n175, n176, n177, n6, n8,
         n9, n10, n11, n12, n178, n179, n180, n181, n182, n183, n184, n185,
         n186, n187, n188, n189, n190, n191, n192, n193, n194, n195, n196,
         n197, n198, n199, n200, n201, n202, n203, n204, n205, n206, n207,
         n208, n209, n210, n211, n212, n213, n214, n215, n216, n217, n218,
         n219, n220, n221, n222, n223, n224, n225, n226, n227, n228, n229,
         n230, n231, n232, n233, n234, n235, n236, n237, n238, n239, n240,
         n241, n242, n243, n244, n245, n246, n247, n248, n249, n250, n251,
         n252, n253, n254, n255, n256, n257, n258, n259, n260, n261, n262,
         n263, n264, n265, n266, n267, n268, n269, n270, n271, n272;
  assign N11 = Address[0];
  assign N12 = Address[1];
  assign N13 = Address[2];
  assign N14 = Address[3];

  DFFRHQX8M \regArr_reg[1][1]  ( .D(n163), .CK(CLK), .RN(n258), .Q(REG1[1]) );
  DFFRHQX8M \regArr_reg[2][7]  ( .D(n161), .CK(CLK), .RN(n258), .Q(REG2[7]) );
  DFFRHQX8M \regArr_reg[2][6]  ( .D(n160), .CK(CLK), .RN(n258), .Q(REG2[6]) );
  DFFRHQX8M \regArr_reg[2][4]  ( .D(n158), .CK(CLK), .RN(n258), .Q(REG2[4]) );
  DFFRHQX8M \regArr_reg[2][3]  ( .D(n157), .CK(CLK), .RN(n258), .Q(REG2[3]) );
  DFFRHQX8M \regArr_reg[2][2]  ( .D(n156), .CK(CLK), .RN(n258), .Q(REG2[2]) );
  DFFRQX2M \regArr_reg[5][7]  ( .D(n137), .CK(CLK), .RN(n256), .Q(
        \regArr[5][7] ) );
  DFFRQX2M \regArr_reg[5][6]  ( .D(n136), .CK(CLK), .RN(n256), .Q(
        \regArr[5][6] ) );
  DFFRQX2M \regArr_reg[5][5]  ( .D(n135), .CK(CLK), .RN(n256), .Q(
        \regArr[5][5] ) );
  DFFRQX2M \regArr_reg[5][4]  ( .D(n134), .CK(CLK), .RN(n256), .Q(
        \regArr[5][4] ) );
  DFFRQX2M \regArr_reg[5][3]  ( .D(n133), .CK(CLK), .RN(n256), .Q(
        \regArr[5][3] ) );
  DFFRQX2M \regArr_reg[5][2]  ( .D(n132), .CK(CLK), .RN(n256), .Q(
        \regArr[5][2] ) );
  DFFRQX2M \regArr_reg[5][1]  ( .D(n131), .CK(CLK), .RN(n256), .Q(
        \regArr[5][1] ) );
  DFFRQX2M \regArr_reg[5][0]  ( .D(n130), .CK(CLK), .RN(n256), .Q(
        \regArr[5][0] ) );
  DFFRQX2M \regArr_reg[9][7]  ( .D(n105), .CK(CLK), .RN(n254), .Q(
        \regArr[9][7] ) );
  DFFRQX2M \regArr_reg[9][6]  ( .D(n104), .CK(CLK), .RN(n254), .Q(
        \regArr[9][6] ) );
  DFFRQX2M \regArr_reg[9][5]  ( .D(n103), .CK(CLK), .RN(n254), .Q(
        \regArr[9][5] ) );
  DFFRQX2M \regArr_reg[9][4]  ( .D(n102), .CK(CLK), .RN(n253), .Q(
        \regArr[9][4] ) );
  DFFRQX2M \regArr_reg[9][3]  ( .D(n101), .CK(CLK), .RN(n253), .Q(
        \regArr[9][3] ) );
  DFFRQX2M \regArr_reg[9][2]  ( .D(n100), .CK(CLK), .RN(n253), .Q(
        \regArr[9][2] ) );
  DFFRQX2M \regArr_reg[9][1]  ( .D(n99), .CK(CLK), .RN(n253), .Q(
        \regArr[9][1] ) );
  DFFRQX2M \regArr_reg[9][0]  ( .D(n98), .CK(CLK), .RN(n253), .Q(
        \regArr[9][0] ) );
  DFFRQX2M \regArr_reg[13][7]  ( .D(n73), .CK(CLK), .RN(n251), .Q(
        \regArr[13][7] ) );
  DFFRQX2M \regArr_reg[13][6]  ( .D(n72), .CK(CLK), .RN(n251), .Q(
        \regArr[13][6] ) );
  DFFRQX2M \regArr_reg[13][5]  ( .D(n71), .CK(CLK), .RN(n251), .Q(
        \regArr[13][5] ) );
  DFFRQX2M \regArr_reg[13][4]  ( .D(n70), .CK(CLK), .RN(n251), .Q(
        \regArr[13][4] ) );
  DFFRQX2M \regArr_reg[13][3]  ( .D(n69), .CK(CLK), .RN(n251), .Q(
        \regArr[13][3] ) );
  DFFRQX2M \regArr_reg[13][2]  ( .D(n68), .CK(CLK), .RN(n251), .Q(
        \regArr[13][2] ) );
  DFFRQX2M \regArr_reg[13][1]  ( .D(n67), .CK(CLK), .RN(n251), .Q(
        \regArr[13][1] ) );
  DFFRQX2M \regArr_reg[13][0]  ( .D(n66), .CK(CLK), .RN(n251), .Q(
        \regArr[13][0] ) );
  DFFRQX2M \regArr_reg[7][7]  ( .D(n121), .CK(CLK), .RN(n255), .Q(
        \regArr[7][7] ) );
  DFFRQX2M \regArr_reg[7][6]  ( .D(n120), .CK(CLK), .RN(n255), .Q(
        \regArr[7][6] ) );
  DFFRQX2M \regArr_reg[7][5]  ( .D(n119), .CK(CLK), .RN(n255), .Q(
        \regArr[7][5] ) );
  DFFRQX2M \regArr_reg[7][4]  ( .D(n118), .CK(CLK), .RN(n255), .Q(
        \regArr[7][4] ) );
  DFFRQX2M \regArr_reg[7][3]  ( .D(n117), .CK(CLK), .RN(n255), .Q(
        \regArr[7][3] ) );
  DFFRQX2M \regArr_reg[7][2]  ( .D(n116), .CK(CLK), .RN(n255), .Q(
        \regArr[7][2] ) );
  DFFRQX2M \regArr_reg[7][1]  ( .D(n115), .CK(CLK), .RN(n255), .Q(
        \regArr[7][1] ) );
  DFFRQX2M \regArr_reg[7][0]  ( .D(n114), .CK(CLK), .RN(n254), .Q(
        \regArr[7][0] ) );
  DFFRQX2M \regArr_reg[11][7]  ( .D(n89), .CK(CLK), .RN(n252), .Q(
        \regArr[11][7] ) );
  DFFRQX2M \regArr_reg[11][6]  ( .D(n88), .CK(CLK), .RN(n252), .Q(
        \regArr[11][6] ) );
  DFFRQX2M \regArr_reg[11][5]  ( .D(n87), .CK(CLK), .RN(n252), .Q(
        \regArr[11][5] ) );
  DFFRQX2M \regArr_reg[11][4]  ( .D(n86), .CK(CLK), .RN(n252), .Q(
        \regArr[11][4] ) );
  DFFRQX2M \regArr_reg[11][3]  ( .D(n85), .CK(CLK), .RN(n252), .Q(
        \regArr[11][3] ) );
  DFFRQX2M \regArr_reg[11][2]  ( .D(n84), .CK(CLK), .RN(n252), .Q(
        \regArr[11][2] ) );
  DFFRQX2M \regArr_reg[11][1]  ( .D(n83), .CK(CLK), .RN(n252), .Q(
        \regArr[11][1] ) );
  DFFRQX2M \regArr_reg[11][0]  ( .D(n82), .CK(CLK), .RN(n252), .Q(
        \regArr[11][0] ) );
  DFFRQX2M \regArr_reg[15][7]  ( .D(n57), .CK(CLK), .RN(n250), .Q(
        \regArr[15][7] ) );
  DFFRQX2M \regArr_reg[15][6]  ( .D(n56), .CK(CLK), .RN(n250), .Q(
        \regArr[15][6] ) );
  DFFRQX2M \regArr_reg[15][5]  ( .D(n55), .CK(CLK), .RN(n250), .Q(
        \regArr[15][5] ) );
  DFFRQX2M \regArr_reg[15][4]  ( .D(n54), .CK(CLK), .RN(n250), .Q(
        \regArr[15][4] ) );
  DFFRQX2M \regArr_reg[15][3]  ( .D(n53), .CK(CLK), .RN(n250), .Q(
        \regArr[15][3] ) );
  DFFRQX2M \regArr_reg[15][2]  ( .D(n52), .CK(CLK), .RN(n250), .Q(
        \regArr[15][2] ) );
  DFFRQX2M \regArr_reg[15][1]  ( .D(n51), .CK(CLK), .RN(n251), .Q(
        \regArr[15][1] ) );
  DFFRQX2M \regArr_reg[15][0]  ( .D(n50), .CK(CLK), .RN(n250), .Q(
        \regArr[15][0] ) );
  DFFRQX2M \regArr_reg[6][7]  ( .D(n129), .CK(CLK), .RN(n256), .Q(
        \regArr[6][7] ) );
  DFFRQX2M \regArr_reg[6][6]  ( .D(n128), .CK(CLK), .RN(n256), .Q(
        \regArr[6][6] ) );
  DFFRQX2M \regArr_reg[6][5]  ( .D(n127), .CK(CLK), .RN(n255), .Q(
        \regArr[6][5] ) );
  DFFRQX2M \regArr_reg[6][4]  ( .D(n126), .CK(CLK), .RN(n255), .Q(
        \regArr[6][4] ) );
  DFFRQX2M \regArr_reg[6][3]  ( .D(n125), .CK(CLK), .RN(n255), .Q(
        \regArr[6][3] ) );
  DFFRQX2M \regArr_reg[6][2]  ( .D(n124), .CK(CLK), .RN(n255), .Q(
        \regArr[6][2] ) );
  DFFRQX2M \regArr_reg[6][1]  ( .D(n123), .CK(CLK), .RN(n255), .Q(
        \regArr[6][1] ) );
  DFFRQX2M \regArr_reg[6][0]  ( .D(n122), .CK(CLK), .RN(n255), .Q(
        \regArr[6][0] ) );
  DFFRQX2M \regArr_reg[10][7]  ( .D(n97), .CK(CLK), .RN(n253), .Q(
        \regArr[10][7] ) );
  DFFRQX2M \regArr_reg[10][6]  ( .D(n96), .CK(CLK), .RN(n253), .Q(
        \regArr[10][6] ) );
  DFFRQX2M \regArr_reg[10][5]  ( .D(n95), .CK(CLK), .RN(n253), .Q(
        \regArr[10][5] ) );
  DFFRQX2M \regArr_reg[10][4]  ( .D(n94), .CK(CLK), .RN(n253), .Q(
        \regArr[10][4] ) );
  DFFRQX2M \regArr_reg[10][3]  ( .D(n93), .CK(CLK), .RN(n253), .Q(
        \regArr[10][3] ) );
  DFFRQX2M \regArr_reg[10][2]  ( .D(n92), .CK(CLK), .RN(n253), .Q(
        \regArr[10][2] ) );
  DFFRQX2M \regArr_reg[10][1]  ( .D(n91), .CK(CLK), .RN(n253), .Q(
        \regArr[10][1] ) );
  DFFRQX2M \regArr_reg[10][0]  ( .D(n90), .CK(CLK), .RN(n253), .Q(
        \regArr[10][0] ) );
  DFFRQX2M \regArr_reg[14][7]  ( .D(n65), .CK(CLK), .RN(n251), .Q(
        \regArr[14][7] ) );
  DFFRQX2M \regArr_reg[14][6]  ( .D(n64), .CK(CLK), .RN(n251), .Q(
        \regArr[14][6] ) );
  DFFRQX2M \regArr_reg[14][5]  ( .D(n63), .CK(CLK), .RN(n250), .Q(
        \regArr[14][5] ) );
  DFFRQX2M \regArr_reg[14][4]  ( .D(n62), .CK(CLK), .RN(n250), .Q(
        \regArr[14][4] ) );
  DFFRQX2M \regArr_reg[14][3]  ( .D(n61), .CK(CLK), .RN(n250), .Q(
        \regArr[14][3] ) );
  DFFRQX2M \regArr_reg[14][2]  ( .D(n60), .CK(CLK), .RN(n250), .Q(
        \regArr[14][2] ) );
  DFFRQX2M \regArr_reg[14][1]  ( .D(n59), .CK(CLK), .RN(n250), .Q(
        \regArr[14][1] ) );
  DFFRQX2M \regArr_reg[14][0]  ( .D(n58), .CK(CLK), .RN(n250), .Q(
        \regArr[14][0] ) );
  DFFRQX2M \regArr_reg[4][7]  ( .D(n145), .CK(CLK), .RN(n257), .Q(
        \regArr[4][7] ) );
  DFFRQX2M \regArr_reg[4][6]  ( .D(n144), .CK(CLK), .RN(n257), .Q(
        \regArr[4][6] ) );
  DFFRQX2M \regArr_reg[4][5]  ( .D(n143), .CK(CLK), .RN(n257), .Q(
        \regArr[4][5] ) );
  DFFRQX2M \regArr_reg[4][4]  ( .D(n142), .CK(CLK), .RN(n257), .Q(
        \regArr[4][4] ) );
  DFFRQX2M \regArr_reg[4][3]  ( .D(n141), .CK(CLK), .RN(n257), .Q(
        \regArr[4][3] ) );
  DFFRQX2M \regArr_reg[4][2]  ( .D(n140), .CK(CLK), .RN(n256), .Q(
        \regArr[4][2] ) );
  DFFRQX2M \regArr_reg[4][1]  ( .D(n139), .CK(CLK), .RN(n256), .Q(
        \regArr[4][1] ) );
  DFFRQX2M \regArr_reg[4][0]  ( .D(n138), .CK(CLK), .RN(n256), .Q(
        \regArr[4][0] ) );
  DFFRQX2M \regArr_reg[8][7]  ( .D(n113), .CK(CLK), .RN(n254), .Q(
        \regArr[8][7] ) );
  DFFRQX2M \regArr_reg[8][6]  ( .D(n112), .CK(CLK), .RN(n254), .Q(
        \regArr[8][6] ) );
  DFFRQX2M \regArr_reg[8][5]  ( .D(n111), .CK(CLK), .RN(n254), .Q(
        \regArr[8][5] ) );
  DFFRQX2M \regArr_reg[8][4]  ( .D(n110), .CK(CLK), .RN(n254), .Q(
        \regArr[8][4] ) );
  DFFRQX2M \regArr_reg[8][3]  ( .D(n109), .CK(CLK), .RN(n254), .Q(
        \regArr[8][3] ) );
  DFFRQX2M \regArr_reg[8][2]  ( .D(n108), .CK(CLK), .RN(n254), .Q(
        \regArr[8][2] ) );
  DFFRQX2M \regArr_reg[8][1]  ( .D(n107), .CK(CLK), .RN(n254), .Q(
        \regArr[8][1] ) );
  DFFRQX2M \regArr_reg[8][0]  ( .D(n106), .CK(CLK), .RN(n254), .Q(
        \regArr[8][0] ) );
  DFFRQX2M \regArr_reg[12][7]  ( .D(n81), .CK(CLK), .RN(n252), .Q(
        \regArr[12][7] ) );
  DFFRQX2M \regArr_reg[12][6]  ( .D(n80), .CK(CLK), .RN(n252), .Q(
        \regArr[12][6] ) );
  DFFRQX2M \regArr_reg[12][5]  ( .D(n79), .CK(CLK), .RN(n252), .Q(
        \regArr[12][5] ) );
  DFFRQX2M \regArr_reg[12][4]  ( .D(n78), .CK(CLK), .RN(n252), .Q(
        \regArr[12][4] ) );
  DFFRQX2M \regArr_reg[12][3]  ( .D(n77), .CK(CLK), .RN(n252), .Q(
        \regArr[12][3] ) );
  DFFRQX2M \regArr_reg[12][2]  ( .D(n76), .CK(CLK), .RN(n251), .Q(
        \regArr[12][2] ) );
  DFFRQX2M \regArr_reg[12][1]  ( .D(n75), .CK(CLK), .RN(n251), .Q(
        \regArr[12][1] ) );
  DFFRQX2M \regArr_reg[12][0]  ( .D(n74), .CK(CLK), .RN(n251), .Q(
        \regArr[12][0] ) );
  DFFRQX2M \RdData_reg[7]  ( .D(n48), .CK(CLK), .RN(n250), .Q(RdData[7]) );
  DFFRQX2M \RdData_reg[6]  ( .D(n47), .CK(CLK), .RN(n259), .Q(RdData[6]) );
  DFFRQX2M \RdData_reg[5]  ( .D(n46), .CK(CLK), .RN(n254), .Q(RdData[5]) );
  DFFRQX2M \RdData_reg[4]  ( .D(n45), .CK(CLK), .RN(n254), .Q(RdData[4]) );
  DFFRQX2M \RdData_reg[3]  ( .D(n44), .CK(CLK), .RN(n256), .Q(RdData[3]) );
  DFFRQX2M \RdData_reg[2]  ( .D(n43), .CK(CLK), .RN(n256), .Q(RdData[2]) );
  DFFRQX2M \RdData_reg[1]  ( .D(n42), .CK(CLK), .RN(n262), .Q(RdData[1]) );
  DFFRQX2M \RdData_reg[0]  ( .D(n41), .CK(CLK), .RN(n254), .Q(RdData[0]) );
  DFFRQX2M \regArr_reg[3][0]  ( .D(n146), .CK(CLK), .RN(n257), .Q(REG3[0]) );
  DFFRQX2M \regArr_reg[2][1]  ( .D(n155), .CK(CLK), .RN(n257), .Q(REG2[1]) );
  DFFSQX4M \regArr_reg[3][5]  ( .D(n151), .CK(CLK), .SN(n254), .Q(REG3[5]) );
  DFFSQX4M \regArr_reg[2][0]  ( .D(n154), .CK(CLK), .SN(n252), .Q(REG2[0]) );
  DFFRQX2M \regArr_reg[0][3]  ( .D(n173), .CK(CLK), .RN(n259), .Q(REG0[3]) );
  DFFRQX2M \regArr_reg[0][2]  ( .D(n172), .CK(CLK), .RN(n259), .Q(REG0[2]) );
  DFFRQX2M \regArr_reg[0][0]  ( .D(n170), .CK(CLK), .RN(n259), .Q(REG0[0]) );
  DFFRQX2M \regArr_reg[0][1]  ( .D(n171), .CK(CLK), .RN(n259), .Q(REG0[1]) );
  DFFRQX2M RdData_VLD_reg ( .D(n49), .CK(CLK), .RN(RST), .Q(RdData_VLD) );
  DFFRHQX8M \regArr_reg[0][6]  ( .D(n176), .CK(CLK), .RN(n259), .Q(REG0[6]) );
  DFFRHQX8M \regArr_reg[0][7]  ( .D(n177), .CK(CLK), .RN(n256), .Q(REG0[7]) );
  DFFRQX2M \regArr_reg[0][4]  ( .D(n174), .CK(CLK), .RN(n259), .Q(REG0[4]) );
  DFFRQX2M \regArr_reg[0][5]  ( .D(n175), .CK(CLK), .RN(n259), .Q(REG0[5]) );
  DFFSHQX8M \regArr_reg[2][5]  ( .D(n159), .CK(CLK), .SN(RST), .Q(REG2[5]) );
  DFFRQX4M \regArr_reg[3][4]  ( .D(n150), .CK(CLK), .RN(n257), .Q(REG3[4]) );
  DFFRQX4M \regArr_reg[3][6]  ( .D(n152), .CK(CLK), .RN(n257), .Q(REG3[6]) );
  DFFRQX4M \regArr_reg[3][1]  ( .D(n147), .CK(CLK), .RN(n257), .Q(REG3[1]) );
  DFFRQX4M \regArr_reg[3][3]  ( .D(n149), .CK(CLK), .RN(n257), .Q(REG3[3]) );
  DFFRQX4M \regArr_reg[3][2]  ( .D(n148), .CK(CLK), .RN(n257), .Q(REG3[2]) );
  DFFRQX4M \regArr_reg[3][7]  ( .D(n153), .CK(CLK), .RN(n257), .Q(REG3[7]) );
  DFFRHQX4M \regArr_reg[1][7]  ( .D(n169), .CK(CLK), .RN(n258), .Q(n273) );
  DFFRQX4M \regArr_reg[1][5]  ( .D(n167), .CK(CLK), .RN(n258), .Q(n274) );
  DFFRQX4M \regArr_reg[1][4]  ( .D(n166), .CK(CLK), .RN(n258), .Q(n275) );
  DFFRHQX2M \regArr_reg[1][3]  ( .D(n165), .CK(CLK), .RN(n258), .Q(n276) );
  DFFRQX2M \regArr_reg[1][0]  ( .D(n162), .CK(CLK), .RN(n258), .Q(n278) );
  DFFRHQX8M \regArr_reg[1][2]  ( .D(n164), .CK(CLK), .RN(n258), .Q(n277) );
  DFFRHQX8M \regArr_reg[1][6]  ( .D(n168), .CK(CLK), .RN(n258), .Q(REG1[6]) );
  BUFX32M U3 ( .A(n277), .Y(REG1[2]) );
  CLKBUFX40M U4 ( .A(n276), .Y(REG1[3]) );
  BUFX32M U5 ( .A(n274), .Y(REG1[5]) );
  BUFX32M U6 ( .A(n275), .Y(REG1[4]) );
  BUFX24M U7 ( .A(n278), .Y(REG1[0]) );
  CLKINVX32M U8 ( .A(n273), .Y(n6) );
  INVX32M U9 ( .A(n6), .Y(REG1[7]) );
  CLKINVX1M U10 ( .A(N13), .Y(n263) );
  NOR2BX4M U11 ( .AN(n39), .B(n246), .Y(n33) );
  NOR2BX4M U12 ( .AN(n28), .B(n246), .Y(n19) );
  NOR2X4M U13 ( .A(n263), .B(n248), .Y(n21) );
  NOR2BX4M U14 ( .AN(n39), .B(n247), .Y(n31) );
  NOR2BX4M U15 ( .AN(n28), .B(n247), .Y(n17) );
  NOR2X4M U16 ( .A(n263), .B(n249), .Y(n16) );
  NOR2X4M U17 ( .A(n248), .B(N13), .Y(n27) );
  NOR2X4M U18 ( .A(n249), .B(N13), .Y(n24) );
  INVX2M U19 ( .A(N11), .Y(n247) );
  INVX2M U20 ( .A(N12), .Y(n249) );
  MX4XLM U21 ( .A(REG0[0]), .B(REG1[0]), .C(REG2[0]), .D(REG3[0]), .S0(n211), 
        .S1(n205), .Y(n11) );
  MX4XLM U22 ( .A(REG0[1]), .B(REG1[1]), .C(REG2[1]), .D(REG3[1]), .S0(n212), 
        .S1(n206), .Y(n180) );
  MX4XLM U23 ( .A(REG0[2]), .B(REG1[2]), .C(REG2[2]), .D(REG3[2]), .S0(n211), 
        .S1(n206), .Y(n184) );
  MX4XLM U24 ( .A(REG0[4]), .B(REG1[4]), .C(REG2[4]), .D(REG3[4]), .S0(n211), 
        .S1(n207), .Y(n192) );
  MX4XLM U25 ( .A(REG0[5]), .B(REG1[5]), .C(REG2[5]), .D(REG3[5]), .S0(n212), 
        .S1(n207), .Y(n196) );
  MX4XLM U26 ( .A(REG0[6]), .B(REG1[6]), .C(REG2[6]), .D(REG3[6]), .S0(n212), 
        .S1(n207), .Y(n200) );
  MX4XLM U27 ( .A(REG0[7]), .B(REG1[7]), .C(REG2[7]), .D(REG3[7]), .S0(n212), 
        .S1(n207), .Y(n204) );
  BUFX4M U28 ( .A(n22), .Y(n238) );
  BUFX4M U29 ( .A(n35), .Y(n222) );
  BUFX4M U30 ( .A(n22), .Y(n237) );
  BUFX4M U31 ( .A(n35), .Y(n221) );
  CLKBUFX8M U32 ( .A(n210), .Y(n211) );
  CLKBUFX8M U33 ( .A(n248), .Y(n206) );
  BUFX4M U34 ( .A(n206), .Y(n205) );
  NAND2X2M U35 ( .A(n33), .B(n21), .Y(n35) );
  NAND2X2M U36 ( .A(n21), .B(n19), .Y(n22) );
  BUFX4M U37 ( .A(n23), .Y(n236) );
  BUFX4M U38 ( .A(n25), .Y(n234) );
  BUFX4M U39 ( .A(n26), .Y(n232) );
  BUFX4M U40 ( .A(n29), .Y(n230) );
  BUFX4M U41 ( .A(n18), .Y(n242) );
  BUFX4M U42 ( .A(n20), .Y(n240) );
  BUFX4M U43 ( .A(n30), .Y(n228) );
  BUFX4M U44 ( .A(n32), .Y(n226) );
  BUFX4M U45 ( .A(n34), .Y(n224) );
  BUFX4M U46 ( .A(n15), .Y(n244) );
  BUFX4M U47 ( .A(n23), .Y(n235) );
  BUFX4M U48 ( .A(n25), .Y(n233) );
  BUFX4M U49 ( .A(n26), .Y(n231) );
  BUFX4M U50 ( .A(n29), .Y(n229) );
  BUFX4M U51 ( .A(n18), .Y(n241) );
  BUFX4M U52 ( .A(n20), .Y(n239) );
  BUFX4M U53 ( .A(n30), .Y(n227) );
  BUFX4M U54 ( .A(n32), .Y(n225) );
  BUFX4M U55 ( .A(n34), .Y(n223) );
  BUFX4M U56 ( .A(n15), .Y(n243) );
  CLKBUFX8M U57 ( .A(n209), .Y(n212) );
  BUFX2M U58 ( .A(n208), .Y(n209) );
  CLKBUFX8M U59 ( .A(n248), .Y(n207) );
  BUFX4M U60 ( .A(n36), .Y(n220) );
  BUFX4M U61 ( .A(n37), .Y(n218) );
  BUFX4M U62 ( .A(n38), .Y(n216) );
  BUFX4M U63 ( .A(n40), .Y(n214) );
  BUFX4M U64 ( .A(n36), .Y(n219) );
  BUFX4M U65 ( .A(n37), .Y(n217) );
  BUFX4M U66 ( .A(n38), .Y(n215) );
  BUFX4M U67 ( .A(n40), .Y(n213) );
  BUFX2M U68 ( .A(n208), .Y(n210) );
  CLKBUFX8M U69 ( .A(n261), .Y(n251) );
  CLKBUFX8M U70 ( .A(n261), .Y(n252) );
  CLKBUFX8M U71 ( .A(n261), .Y(n253) );
  CLKBUFX8M U72 ( .A(n262), .Y(n254) );
  CLKBUFX8M U73 ( .A(n260), .Y(n255) );
  CLKBUFX8M U74 ( .A(RST), .Y(n256) );
  CLKBUFX8M U75 ( .A(n260), .Y(n257) );
  BUFX6M U76 ( .A(n260), .Y(n258) );
  CLKBUFX8M U77 ( .A(n261), .Y(n250) );
  BUFX4M U78 ( .A(n260), .Y(n259) );
  NAND2X2M U79 ( .A(n24), .B(n17), .Y(n23) );
  NAND2X2M U80 ( .A(n24), .B(n19), .Y(n25) );
  NAND2X2M U81 ( .A(n27), .B(n17), .Y(n26) );
  NAND2X2M U82 ( .A(n27), .B(n19), .Y(n29) );
  NAND2X2M U83 ( .A(n19), .B(n16), .Y(n18) );
  NAND2X2M U84 ( .A(n31), .B(n16), .Y(n30) );
  NAND2X2M U85 ( .A(n33), .B(n16), .Y(n32) );
  NAND2X2M U86 ( .A(n31), .B(n21), .Y(n34) );
  NAND2X2M U87 ( .A(n16), .B(n17), .Y(n15) );
  NAND2X2M U88 ( .A(n21), .B(n17), .Y(n20) );
  NAND2X2M U89 ( .A(n31), .B(n24), .Y(n36) );
  NAND2X2M U90 ( .A(n33), .B(n24), .Y(n37) );
  NAND2X2M U91 ( .A(n31), .B(n27), .Y(n38) );
  NAND2X2M U92 ( .A(n33), .B(n27), .Y(n40) );
  BUFX2M U93 ( .A(n246), .Y(n208) );
  INVX4M U94 ( .A(n245), .Y(n264) );
  BUFX2M U95 ( .A(n262), .Y(n261) );
  BUFX2M U96 ( .A(n262), .Y(n260) );
  AND2X1M U97 ( .A(N14), .B(n14), .Y(n28) );
  NOR2BX2M U98 ( .AN(n14), .B(N14), .Y(n39) );
  INVX2M U99 ( .A(n247), .Y(n246) );
  INVX2M U100 ( .A(n249), .Y(n248) );
  NOR2BX4M U101 ( .AN(WrEn), .B(RdEn), .Y(n14) );
  CLKBUFX6M U102 ( .A(n13), .Y(n245) );
  NAND2BX2M U103 ( .AN(WrEn), .B(RdEn), .Y(n13) );
  INVX8M U104 ( .A(WrData[0]), .Y(n265) );
  INVX8M U105 ( .A(WrData[2]), .Y(n267) );
  INVX8M U106 ( .A(WrData[4]), .Y(n269) );
  INVX8M U107 ( .A(WrData[5]), .Y(n270) );
  INVX8M U108 ( .A(WrData[6]), .Y(n271) );
  INVX8M U109 ( .A(WrData[3]), .Y(n268) );
  INVX8M U110 ( .A(WrData[1]), .Y(n266) );
  INVX8M U111 ( .A(WrData[7]), .Y(n272) );
  BUFX2M U112 ( .A(RST), .Y(n262) );
  OAI2BB2X1M U113 ( .B0(n244), .B1(n265), .A0N(\regArr[15][0] ), .A1N(n244), 
        .Y(n50) );
  OAI2BB2X1M U114 ( .B0(n243), .B1(n268), .A0N(\regArr[15][3] ), .A1N(n244), 
        .Y(n53) );
  OAI2BB2X1M U115 ( .B0(n243), .B1(n266), .A0N(\regArr[15][1] ), .A1N(n244), 
        .Y(n51) );
  OAI2BB2X1M U116 ( .B0(n243), .B1(n267), .A0N(\regArr[15][2] ), .A1N(n244), 
        .Y(n52) );
  OAI2BB2X1M U117 ( .B0(n243), .B1(n269), .A0N(\regArr[15][4] ), .A1N(n244), 
        .Y(n54) );
  OAI2BB2X1M U118 ( .B0(n243), .B1(n270), .A0N(\regArr[15][5] ), .A1N(n244), 
        .Y(n55) );
  OAI2BB2X1M U119 ( .B0(n243), .B1(n271), .A0N(\regArr[15][6] ), .A1N(n244), 
        .Y(n56) );
  OAI2BB2X1M U120 ( .B0(n243), .B1(n272), .A0N(\regArr[15][7] ), .A1N(n244), 
        .Y(n57) );
  OAI2BB2X1M U121 ( .B0(n265), .B1(n242), .A0N(\regArr[14][0] ), .A1N(n242), 
        .Y(n58) );
  OAI2BB2X1M U122 ( .B0(n265), .B1(n240), .A0N(\regArr[13][0] ), .A1N(n240), 
        .Y(n66) );
  OAI2BB2X1M U123 ( .B0(n265), .B1(n238), .A0N(\regArr[12][0] ), .A1N(n238), 
        .Y(n74) );
  OAI2BB2X1M U124 ( .B0(n265), .B1(n236), .A0N(\regArr[11][0] ), .A1N(n236), 
        .Y(n82) );
  OAI2BB2X1M U125 ( .B0(n265), .B1(n234), .A0N(\regArr[10][0] ), .A1N(n234), 
        .Y(n90) );
  OAI2BB2X1M U126 ( .B0(n265), .B1(n232), .A0N(\regArr[9][0] ), .A1N(n232), 
        .Y(n98) );
  OAI2BB2X1M U127 ( .B0(n265), .B1(n230), .A0N(\regArr[8][0] ), .A1N(n230), 
        .Y(n106) );
  OAI2BB2X1M U128 ( .B0(n265), .B1(n228), .A0N(\regArr[7][0] ), .A1N(n228), 
        .Y(n114) );
  OAI2BB2X1M U129 ( .B0(n265), .B1(n226), .A0N(\regArr[6][0] ), .A1N(n226), 
        .Y(n122) );
  OAI2BB2X1M U130 ( .B0(n265), .B1(n224), .A0N(\regArr[5][0] ), .A1N(n224), 
        .Y(n130) );
  OAI2BB2X1M U131 ( .B0(n265), .B1(n222), .A0N(\regArr[4][0] ), .A1N(n222), 
        .Y(n138) );
  OAI2BB2X1M U132 ( .B0(n268), .B1(n241), .A0N(\regArr[14][3] ), .A1N(n242), 
        .Y(n61) );
  OAI2BB2X1M U133 ( .B0(n268), .B1(n239), .A0N(\regArr[13][3] ), .A1N(n240), 
        .Y(n69) );
  OAI2BB2X1M U134 ( .B0(n268), .B1(n237), .A0N(\regArr[12][3] ), .A1N(n238), 
        .Y(n77) );
  OAI2BB2X1M U135 ( .B0(n268), .B1(n235), .A0N(\regArr[11][3] ), .A1N(n236), 
        .Y(n85) );
  OAI2BB2X1M U136 ( .B0(n268), .B1(n233), .A0N(\regArr[10][3] ), .A1N(n234), 
        .Y(n93) );
  OAI2BB2X1M U137 ( .B0(n268), .B1(n231), .A0N(\regArr[9][3] ), .A1N(n232), 
        .Y(n101) );
  OAI2BB2X1M U138 ( .B0(n268), .B1(n229), .A0N(\regArr[8][3] ), .A1N(n230), 
        .Y(n109) );
  OAI2BB2X1M U139 ( .B0(n268), .B1(n227), .A0N(\regArr[7][3] ), .A1N(n228), 
        .Y(n117) );
  OAI2BB2X1M U140 ( .B0(n268), .B1(n225), .A0N(\regArr[6][3] ), .A1N(n226), 
        .Y(n125) );
  OAI2BB2X1M U141 ( .B0(n268), .B1(n223), .A0N(\regArr[5][3] ), .A1N(n224), 
        .Y(n133) );
  OAI2BB2X1M U142 ( .B0(n268), .B1(n221), .A0N(\regArr[4][3] ), .A1N(n222), 
        .Y(n141) );
  OAI2BB2X1M U143 ( .B0(n266), .B1(n241), .A0N(\regArr[14][1] ), .A1N(n242), 
        .Y(n59) );
  OAI2BB2X1M U144 ( .B0(n267), .B1(n241), .A0N(\regArr[14][2] ), .A1N(n242), 
        .Y(n60) );
  OAI2BB2X1M U145 ( .B0(n266), .B1(n239), .A0N(\regArr[13][1] ), .A1N(n240), 
        .Y(n67) );
  OAI2BB2X1M U146 ( .B0(n267), .B1(n239), .A0N(\regArr[13][2] ), .A1N(n240), 
        .Y(n68) );
  OAI2BB2X1M U147 ( .B0(n266), .B1(n237), .A0N(\regArr[12][1] ), .A1N(n238), 
        .Y(n75) );
  OAI2BB2X1M U148 ( .B0(n267), .B1(n237), .A0N(\regArr[12][2] ), .A1N(n238), 
        .Y(n76) );
  OAI2BB2X1M U149 ( .B0(n266), .B1(n235), .A0N(\regArr[11][1] ), .A1N(n236), 
        .Y(n83) );
  OAI2BB2X1M U150 ( .B0(n267), .B1(n235), .A0N(\regArr[11][2] ), .A1N(n236), 
        .Y(n84) );
  OAI2BB2X1M U151 ( .B0(n266), .B1(n233), .A0N(\regArr[10][1] ), .A1N(n234), 
        .Y(n91) );
  OAI2BB2X1M U152 ( .B0(n267), .B1(n233), .A0N(\regArr[10][2] ), .A1N(n234), 
        .Y(n92) );
  OAI2BB2X1M U153 ( .B0(n266), .B1(n231), .A0N(\regArr[9][1] ), .A1N(n232), 
        .Y(n99) );
  OAI2BB2X1M U154 ( .B0(n267), .B1(n231), .A0N(\regArr[9][2] ), .A1N(n232), 
        .Y(n100) );
  OAI2BB2X1M U155 ( .B0(n266), .B1(n229), .A0N(\regArr[8][1] ), .A1N(n230), 
        .Y(n107) );
  OAI2BB2X1M U156 ( .B0(n267), .B1(n229), .A0N(\regArr[8][2] ), .A1N(n230), 
        .Y(n108) );
  OAI2BB2X1M U157 ( .B0(n266), .B1(n227), .A0N(\regArr[7][1] ), .A1N(n228), 
        .Y(n115) );
  OAI2BB2X1M U158 ( .B0(n267), .B1(n227), .A0N(\regArr[7][2] ), .A1N(n228), 
        .Y(n116) );
  OAI2BB2X1M U159 ( .B0(n266), .B1(n225), .A0N(\regArr[6][1] ), .A1N(n226), 
        .Y(n123) );
  OAI2BB2X1M U160 ( .B0(n267), .B1(n225), .A0N(\regArr[6][2] ), .A1N(n226), 
        .Y(n124) );
  OAI2BB2X1M U161 ( .B0(n266), .B1(n223), .A0N(\regArr[5][1] ), .A1N(n224), 
        .Y(n131) );
  OAI2BB2X1M U162 ( .B0(n267), .B1(n223), .A0N(\regArr[5][2] ), .A1N(n224), 
        .Y(n132) );
  OAI2BB2X1M U163 ( .B0(n266), .B1(n221), .A0N(\regArr[4][1] ), .A1N(n222), 
        .Y(n139) );
  OAI2BB2X1M U164 ( .B0(n267), .B1(n221), .A0N(\regArr[4][2] ), .A1N(n222), 
        .Y(n140) );
  OAI2BB2X1M U165 ( .B0(n269), .B1(n241), .A0N(\regArr[14][4] ), .A1N(n242), 
        .Y(n62) );
  OAI2BB2X1M U166 ( .B0(n270), .B1(n241), .A0N(\regArr[14][5] ), .A1N(n242), 
        .Y(n63) );
  OAI2BB2X1M U167 ( .B0(n271), .B1(n241), .A0N(\regArr[14][6] ), .A1N(n242), 
        .Y(n64) );
  OAI2BB2X1M U168 ( .B0(n272), .B1(n241), .A0N(\regArr[14][7] ), .A1N(n242), 
        .Y(n65) );
  OAI2BB2X1M U169 ( .B0(n269), .B1(n239), .A0N(\regArr[13][4] ), .A1N(n240), 
        .Y(n70) );
  OAI2BB2X1M U170 ( .B0(n270), .B1(n239), .A0N(\regArr[13][5] ), .A1N(n240), 
        .Y(n71) );
  OAI2BB2X1M U171 ( .B0(n271), .B1(n239), .A0N(\regArr[13][6] ), .A1N(n240), 
        .Y(n72) );
  OAI2BB2X1M U172 ( .B0(n272), .B1(n239), .A0N(\regArr[13][7] ), .A1N(n240), 
        .Y(n73) );
  OAI2BB2X1M U173 ( .B0(n269), .B1(n237), .A0N(\regArr[12][4] ), .A1N(n238), 
        .Y(n78) );
  OAI2BB2X1M U174 ( .B0(n270), .B1(n237), .A0N(\regArr[12][5] ), .A1N(n238), 
        .Y(n79) );
  OAI2BB2X1M U175 ( .B0(n271), .B1(n237), .A0N(\regArr[12][6] ), .A1N(n238), 
        .Y(n80) );
  OAI2BB2X1M U176 ( .B0(n272), .B1(n237), .A0N(\regArr[12][7] ), .A1N(n238), 
        .Y(n81) );
  OAI2BB2X1M U177 ( .B0(n269), .B1(n235), .A0N(\regArr[11][4] ), .A1N(n236), 
        .Y(n86) );
  OAI2BB2X1M U178 ( .B0(n270), .B1(n235), .A0N(\regArr[11][5] ), .A1N(n236), 
        .Y(n87) );
  OAI2BB2X1M U179 ( .B0(n271), .B1(n235), .A0N(\regArr[11][6] ), .A1N(n236), 
        .Y(n88) );
  OAI2BB2X1M U180 ( .B0(n272), .B1(n235), .A0N(\regArr[11][7] ), .A1N(n236), 
        .Y(n89) );
  OAI2BB2X1M U181 ( .B0(n269), .B1(n233), .A0N(\regArr[10][4] ), .A1N(n234), 
        .Y(n94) );
  OAI2BB2X1M U182 ( .B0(n270), .B1(n233), .A0N(\regArr[10][5] ), .A1N(n234), 
        .Y(n95) );
  OAI2BB2X1M U183 ( .B0(n271), .B1(n233), .A0N(\regArr[10][6] ), .A1N(n234), 
        .Y(n96) );
  OAI2BB2X1M U184 ( .B0(n272), .B1(n233), .A0N(\regArr[10][7] ), .A1N(n234), 
        .Y(n97) );
  OAI2BB2X1M U185 ( .B0(n269), .B1(n231), .A0N(\regArr[9][4] ), .A1N(n232), 
        .Y(n102) );
  OAI2BB2X1M U186 ( .B0(n270), .B1(n231), .A0N(\regArr[9][5] ), .A1N(n232), 
        .Y(n103) );
  OAI2BB2X1M U187 ( .B0(n271), .B1(n231), .A0N(\regArr[9][6] ), .A1N(n232), 
        .Y(n104) );
  OAI2BB2X1M U188 ( .B0(n272), .B1(n231), .A0N(\regArr[9][7] ), .A1N(n232), 
        .Y(n105) );
  OAI2BB2X1M U189 ( .B0(n269), .B1(n229), .A0N(\regArr[8][4] ), .A1N(n230), 
        .Y(n110) );
  OAI2BB2X1M U190 ( .B0(n270), .B1(n229), .A0N(\regArr[8][5] ), .A1N(n230), 
        .Y(n111) );
  OAI2BB2X1M U191 ( .B0(n271), .B1(n229), .A0N(\regArr[8][6] ), .A1N(n230), 
        .Y(n112) );
  OAI2BB2X1M U192 ( .B0(n272), .B1(n229), .A0N(\regArr[8][7] ), .A1N(n230), 
        .Y(n113) );
  OAI2BB2X1M U193 ( .B0(n269), .B1(n227), .A0N(\regArr[7][4] ), .A1N(n228), 
        .Y(n118) );
  OAI2BB2X1M U194 ( .B0(n270), .B1(n227), .A0N(\regArr[7][5] ), .A1N(n228), 
        .Y(n119) );
  OAI2BB2X1M U195 ( .B0(n271), .B1(n227), .A0N(\regArr[7][6] ), .A1N(n228), 
        .Y(n120) );
  OAI2BB2X1M U196 ( .B0(n272), .B1(n227), .A0N(\regArr[7][7] ), .A1N(n228), 
        .Y(n121) );
  OAI2BB2X1M U197 ( .B0(n269), .B1(n225), .A0N(\regArr[6][4] ), .A1N(n226), 
        .Y(n126) );
  OAI2BB2X1M U198 ( .B0(n270), .B1(n225), .A0N(\regArr[6][5] ), .A1N(n226), 
        .Y(n127) );
  OAI2BB2X1M U199 ( .B0(n271), .B1(n225), .A0N(\regArr[6][6] ), .A1N(n226), 
        .Y(n128) );
  OAI2BB2X1M U200 ( .B0(n272), .B1(n225), .A0N(\regArr[6][7] ), .A1N(n226), 
        .Y(n129) );
  OAI2BB2X1M U201 ( .B0(n269), .B1(n223), .A0N(\regArr[5][4] ), .A1N(n224), 
        .Y(n134) );
  OAI2BB2X1M U202 ( .B0(n270), .B1(n223), .A0N(\regArr[5][5] ), .A1N(n224), 
        .Y(n135) );
  OAI2BB2X1M U203 ( .B0(n271), .B1(n223), .A0N(\regArr[5][6] ), .A1N(n224), 
        .Y(n136) );
  OAI2BB2X1M U204 ( .B0(n272), .B1(n223), .A0N(\regArr[5][7] ), .A1N(n224), 
        .Y(n137) );
  OAI2BB2X1M U205 ( .B0(n269), .B1(n221), .A0N(\regArr[4][4] ), .A1N(n222), 
        .Y(n142) );
  OAI2BB2X1M U206 ( .B0(n270), .B1(n221), .A0N(\regArr[4][5] ), .A1N(n222), 
        .Y(n143) );
  OAI2BB2X1M U207 ( .B0(n271), .B1(n221), .A0N(\regArr[4][6] ), .A1N(n222), 
        .Y(n144) );
  OAI2BB2X1M U208 ( .B0(n272), .B1(n221), .A0N(\regArr[4][7] ), .A1N(n222), 
        .Y(n145) );
  OAI2BB2X1M U209 ( .B0(n265), .B1(n220), .A0N(REG3[0]), .A1N(n220), .Y(n146)
         );
  OAI2BB2X1M U210 ( .B0(n265), .B1(n216), .A0N(REG1[0]), .A1N(n216), .Y(n162)
         );
  OAI2BB2X1M U211 ( .B0(n265), .B1(n214), .A0N(REG0[0]), .A1N(n214), .Y(n170)
         );
  OAI2BB2X1M U212 ( .B0(n268), .B1(n219), .A0N(REG3[3]), .A1N(n220), .Y(n149)
         );
  OAI2BB2X1M U213 ( .B0(n268), .B1(n217), .A0N(REG2[3]), .A1N(n218), .Y(n157)
         );
  OAI2BB2X1M U214 ( .B0(n268), .B1(n215), .A0N(REG1[3]), .A1N(n216), .Y(n165)
         );
  OAI2BB2X1M U215 ( .B0(n268), .B1(n213), .A0N(REG0[3]), .A1N(n214), .Y(n173)
         );
  OAI2BB2X1M U216 ( .B0(n266), .B1(n219), .A0N(REG3[1]), .A1N(n220), .Y(n147)
         );
  OAI2BB2X1M U217 ( .B0(n267), .B1(n219), .A0N(REG3[2]), .A1N(n220), .Y(n148)
         );
  OAI2BB2X1M U218 ( .B0(n266), .B1(n217), .A0N(REG2[1]), .A1N(n218), .Y(n155)
         );
  OAI2BB2X1M U219 ( .B0(n267), .B1(n217), .A0N(REG2[2]), .A1N(n218), .Y(n156)
         );
  OAI2BB2X1M U220 ( .B0(n266), .B1(n215), .A0N(REG1[1]), .A1N(n216), .Y(n163)
         );
  OAI2BB2X1M U221 ( .B0(n267), .B1(n215), .A0N(REG1[2]), .A1N(n216), .Y(n164)
         );
  OAI2BB2X1M U222 ( .B0(n266), .B1(n213), .A0N(REG0[1]), .A1N(n214), .Y(n171)
         );
  OAI2BB2X1M U223 ( .B0(n267), .B1(n213), .A0N(REG0[2]), .A1N(n214), .Y(n172)
         );
  OAI2BB2X1M U224 ( .B0(n269), .B1(n219), .A0N(REG3[4]), .A1N(n220), .Y(n150)
         );
  OAI2BB2X1M U225 ( .B0(n271), .B1(n219), .A0N(REG3[6]), .A1N(n220), .Y(n152)
         );
  OAI2BB2X1M U226 ( .B0(n272), .B1(n219), .A0N(REG3[7]), .A1N(n220), .Y(n153)
         );
  OAI2BB2X1M U227 ( .B0(n269), .B1(n217), .A0N(REG2[4]), .A1N(n218), .Y(n158)
         );
  OAI2BB2X1M U228 ( .B0(n271), .B1(n217), .A0N(REG2[6]), .A1N(n218), .Y(n160)
         );
  OAI2BB2X1M U229 ( .B0(n272), .B1(n217), .A0N(REG2[7]), .A1N(n218), .Y(n161)
         );
  OAI2BB2X1M U230 ( .B0(n269), .B1(n215), .A0N(REG1[4]), .A1N(n216), .Y(n166)
         );
  OAI2BB2X1M U231 ( .B0(n270), .B1(n215), .A0N(REG1[5]), .A1N(n216), .Y(n167)
         );
  OAI2BB2X1M U232 ( .B0(n271), .B1(n215), .A0N(REG1[6]), .A1N(n216), .Y(n168)
         );
  OAI2BB2X1M U233 ( .B0(n272), .B1(n215), .A0N(REG1[7]), .A1N(n216), .Y(n169)
         );
  OAI2BB2X1M U234 ( .B0(n269), .B1(n213), .A0N(REG0[4]), .A1N(n214), .Y(n174)
         );
  OAI2BB2X1M U235 ( .B0(n270), .B1(n213), .A0N(REG0[5]), .A1N(n214), .Y(n175)
         );
  OAI2BB2X1M U236 ( .B0(n271), .B1(n213), .A0N(REG0[6]), .A1N(n214), .Y(n176)
         );
  OAI2BB2X1M U237 ( .B0(n272), .B1(n213), .A0N(REG0[7]), .A1N(n214), .Y(n177)
         );
  OAI2BB2X1M U238 ( .B0(n265), .B1(n218), .A0N(REG2[0]), .A1N(n218), .Y(n154)
         );
  OAI2BB2X1M U239 ( .B0(n270), .B1(n219), .A0N(REG3[5]), .A1N(n220), .Y(n151)
         );
  OAI2BB2X1M U240 ( .B0(n270), .B1(n217), .A0N(REG2[5]), .A1N(n218), .Y(n159)
         );
  MX4X1M U241 ( .A(\regArr[4][2] ), .B(\regArr[5][2] ), .C(\regArr[6][2] ), 
        .D(\regArr[7][2] ), .S0(n211), .S1(n206), .Y(n183) );
  MX4X1M U242 ( .A(\regArr[4][3] ), .B(\regArr[5][3] ), .C(\regArr[6][3] ), 
        .D(\regArr[7][3] ), .S0(n211), .S1(n206), .Y(n187) );
  MX4X1M U243 ( .A(\regArr[4][4] ), .B(\regArr[5][4] ), .C(\regArr[6][4] ), 
        .D(\regArr[7][4] ), .S0(n211), .S1(n206), .Y(n191) );
  MX4X1M U244 ( .A(\regArr[4][5] ), .B(\regArr[5][5] ), .C(\regArr[6][5] ), 
        .D(\regArr[7][5] ), .S0(n212), .S1(n207), .Y(n195) );
  MX4X1M U245 ( .A(\regArr[4][6] ), .B(\regArr[5][6] ), .C(\regArr[6][6] ), 
        .D(\regArr[7][6] ), .S0(n212), .S1(n207), .Y(n199) );
  MX4X1M U246 ( .A(\regArr[4][7] ), .B(\regArr[5][7] ), .C(\regArr[6][7] ), 
        .D(\regArr[7][7] ), .S0(n212), .S1(n207), .Y(n203) );
  MX4X1M U247 ( .A(\regArr[12][2] ), .B(\regArr[13][2] ), .C(\regArr[14][2] ), 
        .D(\regArr[15][2] ), .S0(n211), .S1(n206), .Y(n181) );
  MX4X1M U248 ( .A(\regArr[12][3] ), .B(\regArr[13][3] ), .C(\regArr[14][3] ), 
        .D(\regArr[15][3] ), .S0(n211), .S1(n206), .Y(n185) );
  MX4X1M U249 ( .A(\regArr[12][4] ), .B(\regArr[13][4] ), .C(\regArr[14][4] ), 
        .D(\regArr[15][4] ), .S0(n211), .S1(n206), .Y(n189) );
  MX4X1M U250 ( .A(\regArr[12][5] ), .B(\regArr[13][5] ), .C(\regArr[14][5] ), 
        .D(\regArr[15][5] ), .S0(n212), .S1(n207), .Y(n193) );
  MX4X1M U251 ( .A(\regArr[12][6] ), .B(\regArr[13][6] ), .C(\regArr[14][6] ), 
        .D(\regArr[15][6] ), .S0(n212), .S1(n207), .Y(n197) );
  MX4X1M U252 ( .A(\regArr[12][7] ), .B(\regArr[13][7] ), .C(\regArr[14][7] ), 
        .D(\regArr[15][7] ), .S0(n212), .S1(n207), .Y(n201) );
  MX4X1M U253 ( .A(\regArr[4][0] ), .B(\regArr[5][0] ), .C(\regArr[6][0] ), 
        .D(\regArr[7][0] ), .S0(n246), .S1(n205), .Y(n10) );
  MX4X1M U254 ( .A(\regArr[4][1] ), .B(\regArr[5][1] ), .C(\regArr[6][1] ), 
        .D(\regArr[7][1] ), .S0(n210), .S1(n206), .Y(n179) );
  MX4X1M U255 ( .A(\regArr[12][0] ), .B(\regArr[13][0] ), .C(\regArr[14][0] ), 
        .D(\regArr[15][0] ), .S0(n208), .S1(n205), .Y(n8) );
  MX4X1M U256 ( .A(\regArr[12][1] ), .B(\regArr[13][1] ), .C(\regArr[14][1] ), 
        .D(\regArr[15][1] ), .S0(n208), .S1(n205), .Y(n12) );
  AO22X1M U257 ( .A0(N43), .A1(n264), .B0(RdData[0]), .B1(n245), .Y(n41) );
  MX4XLM U258 ( .A(n11), .B(n9), .C(n10), .D(n8), .S0(N14), .S1(N13), .Y(N43)
         );
  MX4X1M U259 ( .A(\regArr[8][0] ), .B(\regArr[9][0] ), .C(\regArr[10][0] ), 
        .D(\regArr[11][0] ), .S0(n209), .S1(n205), .Y(n9) );
  AO22X1M U260 ( .A0(N42), .A1(n264), .B0(RdData[1]), .B1(n245), .Y(n42) );
  MX4XLM U261 ( .A(n180), .B(n178), .C(n179), .D(n12), .S0(N14), .S1(N13), .Y(
        N42) );
  MX4X1M U262 ( .A(\regArr[8][1] ), .B(\regArr[9][1] ), .C(\regArr[10][1] ), 
        .D(\regArr[11][1] ), .S0(n210), .S1(n205), .Y(n178) );
  AO22X1M U263 ( .A0(N41), .A1(n264), .B0(RdData[2]), .B1(n245), .Y(n43) );
  MX4XLM U264 ( .A(n184), .B(n182), .C(n183), .D(n181), .S0(N14), .S1(N13), 
        .Y(N41) );
  MX4X1M U265 ( .A(\regArr[8][2] ), .B(\regArr[9][2] ), .C(\regArr[10][2] ), 
        .D(\regArr[11][2] ), .S0(n211), .S1(n206), .Y(n182) );
  AO22X1M U266 ( .A0(N40), .A1(n264), .B0(RdData[3]), .B1(n245), .Y(n44) );
  MX4XLM U267 ( .A(n188), .B(n186), .C(n187), .D(n185), .S0(N14), .S1(N13), 
        .Y(N40) );
  MX4XLM U268 ( .A(REG0[3]), .B(REG1[3]), .C(REG2[3]), .D(REG3[3]), .S0(n211), 
        .S1(n206), .Y(n188) );
  MX4X1M U269 ( .A(\regArr[8][3] ), .B(\regArr[9][3] ), .C(\regArr[10][3] ), 
        .D(\regArr[11][3] ), .S0(n211), .S1(n206), .Y(n186) );
  AO22X1M U270 ( .A0(N39), .A1(n264), .B0(RdData[4]), .B1(n245), .Y(n45) );
  MX4XLM U271 ( .A(n192), .B(n190), .C(n191), .D(n189), .S0(N14), .S1(N13), 
        .Y(N39) );
  MX4X1M U272 ( .A(\regArr[8][4] ), .B(\regArr[9][4] ), .C(\regArr[10][4] ), 
        .D(\regArr[11][4] ), .S0(n211), .S1(n206), .Y(n190) );
  AO22X1M U273 ( .A0(N38), .A1(n264), .B0(RdData[5]), .B1(n245), .Y(n46) );
  MX4XLM U274 ( .A(n196), .B(n194), .C(n195), .D(n193), .S0(N14), .S1(N13), 
        .Y(N38) );
  MX4X1M U275 ( .A(\regArr[8][5] ), .B(\regArr[9][5] ), .C(\regArr[10][5] ), 
        .D(\regArr[11][5] ), .S0(n212), .S1(n207), .Y(n194) );
  AO22X1M U276 ( .A0(N37), .A1(n264), .B0(RdData[6]), .B1(n245), .Y(n47) );
  MX4XLM U277 ( .A(n200), .B(n198), .C(n199), .D(n197), .S0(N14), .S1(N13), 
        .Y(N37) );
  MX4X1M U278 ( .A(\regArr[8][6] ), .B(\regArr[9][6] ), .C(\regArr[10][6] ), 
        .D(\regArr[11][6] ), .S0(n212), .S1(n207), .Y(n198) );
  AO22X1M U279 ( .A0(N36), .A1(n264), .B0(RdData[7]), .B1(n245), .Y(n48) );
  MX4XLM U280 ( .A(n204), .B(n202), .C(n203), .D(n201), .S0(N14), .S1(N13), 
        .Y(N36) );
  MX4X1M U281 ( .A(\regArr[8][7] ), .B(\regArr[9][7] ), .C(\regArr[10][7] ), 
        .D(\regArr[11][7] ), .S0(n212), .S1(n207), .Y(n202) );
  OAI2BB1X2M U282 ( .A0N(RdData_VLD), .A1N(n14), .B0(n245), .Y(n49) );
endmodule


module ALU_DW_div_uns_0 ( a, b, quotient, remainder, divide_by_0 );
  input [7:0] a;
  input [7:0] b;
  output [7:0] quotient;
  output [7:0] remainder;
  output divide_by_0;
  wire   n29, n30, \u_div/SumTmp[1][0] , \u_div/SumTmp[1][1] ,
         \u_div/SumTmp[1][2] , \u_div/SumTmp[1][3] , \u_div/SumTmp[1][4] ,
         \u_div/SumTmp[1][5] , \u_div/SumTmp[1][6] , \u_div/SumTmp[2][0] ,
         \u_div/SumTmp[2][1] , \u_div/SumTmp[2][2] , \u_div/SumTmp[2][3] ,
         \u_div/SumTmp[2][4] , \u_div/SumTmp[2][5] , \u_div/SumTmp[3][0] ,
         \u_div/SumTmp[3][1] , \u_div/SumTmp[3][2] , \u_div/SumTmp[3][3] ,
         \u_div/SumTmp[3][4] , \u_div/SumTmp[4][0] , \u_div/SumTmp[4][1] ,
         \u_div/SumTmp[4][2] , \u_div/SumTmp[4][3] , \u_div/SumTmp[5][0] ,
         \u_div/SumTmp[5][1] , \u_div/SumTmp[5][2] , \u_div/SumTmp[6][0] ,
         \u_div/SumTmp[6][1] , \u_div/SumTmp[7][0] , \u_div/CryTmp[0][1] ,
         \u_div/CryTmp[0][2] , \u_div/CryTmp[0][3] , \u_div/CryTmp[0][4] ,
         \u_div/CryTmp[0][5] , \u_div/CryTmp[0][6] , \u_div/CryTmp[0][7] ,
         \u_div/CryTmp[1][1] , \u_div/CryTmp[1][2] , \u_div/CryTmp[1][3] ,
         \u_div/CryTmp[1][4] , \u_div/CryTmp[1][5] , \u_div/CryTmp[1][6] ,
         \u_div/CryTmp[1][7] , \u_div/CryTmp[2][1] , \u_div/CryTmp[2][2] ,
         \u_div/CryTmp[2][3] , \u_div/CryTmp[2][4] , \u_div/CryTmp[2][5] ,
         \u_div/CryTmp[2][6] , \u_div/CryTmp[3][1] , \u_div/CryTmp[3][2] ,
         \u_div/CryTmp[3][3] , \u_div/CryTmp[3][4] , \u_div/CryTmp[3][5] ,
         \u_div/CryTmp[4][1] , \u_div/CryTmp[4][2] , \u_div/CryTmp[4][3] ,
         \u_div/CryTmp[4][4] , \u_div/CryTmp[5][1] , \u_div/CryTmp[5][2] ,
         \u_div/CryTmp[5][3] , \u_div/CryTmp[6][1] , \u_div/CryTmp[6][2] ,
         \u_div/CryTmp[7][1] , \u_div/PartRem[1][1] , \u_div/PartRem[1][2] ,
         \u_div/PartRem[1][3] , \u_div/PartRem[1][4] , \u_div/PartRem[1][5] ,
         \u_div/PartRem[1][6] , \u_div/PartRem[1][7] , \u_div/PartRem[2][1] ,
         \u_div/PartRem[2][2] , \u_div/PartRem[2][3] , \u_div/PartRem[2][4] ,
         \u_div/PartRem[2][5] , \u_div/PartRem[2][6] , \u_div/PartRem[3][1] ,
         \u_div/PartRem[3][2] , \u_div/PartRem[3][3] , \u_div/PartRem[3][4] ,
         \u_div/PartRem[3][5] , \u_div/PartRem[4][1] , \u_div/PartRem[4][2] ,
         \u_div/PartRem[4][3] , \u_div/PartRem[4][4] , \u_div/PartRem[5][1] ,
         \u_div/PartRem[5][2] , \u_div/PartRem[5][3] , \u_div/PartRem[6][1] ,
         \u_div/PartRem[6][2] , \u_div/PartRem[7][1] , n1, n2, n4, n6, n8, n9,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28;

  ADDFX2M \u_div/u_fa_PartRem_0_0_4  ( .A(\u_div/PartRem[1][4] ), .B(n21), 
        .CI(\u_div/CryTmp[0][4] ), .CO(\u_div/CryTmp[0][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_5  ( .A(\u_div/PartRem[1][5] ), .B(n20), 
        .CI(\u_div/CryTmp[0][5] ), .CO(\u_div/CryTmp[0][6] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_4  ( .A(\u_div/PartRem[3][4] ), .B(n21), 
        .CI(\u_div/CryTmp[2][4] ), .CO(\u_div/CryTmp[2][5] ), .S(
        \u_div/SumTmp[2][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_1  ( .A(\u_div/PartRem[1][1] ), .B(n24), 
        .CI(\u_div/CryTmp[0][1] ), .CO(\u_div/CryTmp[0][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_2  ( .A(\u_div/PartRem[1][2] ), .B(n23), 
        .CI(\u_div/CryTmp[0][2] ), .CO(\u_div/CryTmp[0][3] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_5_1  ( .A(\u_div/PartRem[6][1] ), .B(n24), 
        .CI(\u_div/CryTmp[5][1] ), .CO(\u_div/CryTmp[5][2] ), .S(
        \u_div/SumTmp[5][1] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_1_1  ( .A(\u_div/PartRem[2][1] ), .B(n24), 
        .CI(\u_div/CryTmp[1][1] ), .CO(\u_div/CryTmp[1][2] ), .S(
        \u_div/SumTmp[1][1] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_4_2  ( .A(\u_div/PartRem[5][2] ), .B(n23), 
        .CI(\u_div/CryTmp[4][2] ), .CO(\u_div/CryTmp[4][3] ), .S(
        \u_div/SumTmp[4][2] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_5_2  ( .A(\u_div/PartRem[6][2] ), .B(n23), 
        .CI(\u_div/CryTmp[5][2] ), .CO(\u_div/CryTmp[5][3] ), .S(
        \u_div/SumTmp[5][2] ) );
  ADDFHX4M \u_div/u_fa_PartRem_0_4_3  ( .A(\u_div/PartRem[5][3] ), .B(n22), 
        .CI(\u_div/CryTmp[4][3] ), .CO(\u_div/CryTmp[4][4] ), .S(
        \u_div/SumTmp[4][3] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_3_3  ( .A(\u_div/PartRem[4][3] ), .B(n22), 
        .CI(\u_div/CryTmp[3][3] ), .CO(\u_div/CryTmp[3][4] ), .S(
        \u_div/SumTmp[3][3] ) );
  ADDFHX2M \u_div/u_fa_PartRem_0_0_3  ( .A(\u_div/PartRem[1][3] ), .B(n22), 
        .CI(\u_div/CryTmp[0][3] ), .CO(\u_div/CryTmp[0][4] ) );
  ADDFHX2M \u_div/u_fa_PartRem_0_2_3  ( .A(\u_div/PartRem[3][3] ), .B(n22), 
        .CI(\u_div/CryTmp[2][3] ), .CO(\u_div/CryTmp[2][4] ), .S(
        \u_div/SumTmp[2][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_2  ( .A(\u_div/PartRem[3][2] ), .B(n23), 
        .CI(\u_div/CryTmp[2][2] ), .CO(\u_div/CryTmp[2][3] ), .S(
        \u_div/SumTmp[2][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_1  ( .A(\u_div/PartRem[3][1] ), .B(n24), 
        .CI(\u_div/CryTmp[2][1] ), .CO(\u_div/CryTmp[2][2] ), .S(
        \u_div/SumTmp[2][1] ) );
  ADDFX4M \u_div/u_fa_PartRem_0_2_5  ( .A(\u_div/PartRem[3][5] ), .B(n20), 
        .CI(\u_div/CryTmp[2][5] ), .CO(\u_div/CryTmp[2][6] ), .S(
        \u_div/SumTmp[2][5] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_6_1  ( .A(\u_div/PartRem[7][1] ), .B(n24), 
        .CI(\u_div/CryTmp[6][1] ), .CO(\u_div/CryTmp[6][2] ), .S(
        \u_div/SumTmp[6][1] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_3_1  ( .A(\u_div/PartRem[4][1] ), .B(n24), 
        .CI(\u_div/CryTmp[3][1] ), .CO(\u_div/CryTmp[3][2] ), .S(
        \u_div/SumTmp[3][1] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_3_2  ( .A(\u_div/PartRem[4][2] ), .B(n23), 
        .CI(\u_div/CryTmp[3][2] ), .CO(\u_div/CryTmp[3][3] ), .S(
        \u_div/SumTmp[3][2] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_4_1  ( .A(\u_div/PartRem[5][1] ), .B(n24), 
        .CI(\u_div/CryTmp[4][1] ), .CO(\u_div/CryTmp[4][2] ), .S(
        \u_div/SumTmp[4][1] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_1_6  ( .A(\u_div/PartRem[2][6] ), .B(n19), 
        .CI(\u_div/CryTmp[1][6] ), .CO(\u_div/CryTmp[1][7] ), .S(
        \u_div/SumTmp[1][6] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_1_4  ( .A(\u_div/PartRem[2][4] ), .B(n21), 
        .CI(\u_div/CryTmp[1][4] ), .CO(\u_div/CryTmp[1][5] ), .S(
        \u_div/SumTmp[1][4] ) );
  ADDFX4M \u_div/u_fa_PartRem_0_1_5  ( .A(\u_div/PartRem[2][5] ), .B(n20), 
        .CI(\u_div/CryTmp[1][5] ), .CO(\u_div/CryTmp[1][6] ), .S(
        \u_div/SumTmp[1][5] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_1_2  ( .A(n9), .B(n23), .CI(
        \u_div/CryTmp[1][2] ), .CO(\u_div/CryTmp[1][3] ), .S(
        \u_div/SumTmp[1][2] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_1_3  ( .A(\u_div/PartRem[2][3] ), .B(n22), 
        .CI(\u_div/CryTmp[1][3] ), .CO(\u_div/CryTmp[1][4] ), .S(
        \u_div/SumTmp[1][3] ) );
  ADDFX4M \u_div/u_fa_PartRem_0_3_4  ( .A(\u_div/PartRem[4][4] ), .B(n21), 
        .CI(\u_div/CryTmp[3][4] ), .CO(\u_div/CryTmp[3][5] ), .S(
        \u_div/SumTmp[3][4] ) );
  ADDFHX8M \u_div/u_fa_PartRem_0_0_7  ( .A(\u_div/PartRem[1][7] ), .B(n18), 
        .CI(\u_div/CryTmp[0][7] ), .CO(quotient[0]) );
  ADDFX4M \u_div/u_fa_PartRem_0_0_6  ( .A(\u_div/PartRem[1][6] ), .B(n19), 
        .CI(\u_div/CryTmp[0][6] ), .CO(\u_div/CryTmp[0][7] ) );
  CLKINVX40M U1 ( .A(n30), .Y(n1) );
  INVX14M U2 ( .A(n1), .Y(n2) );
  INVX32M U3 ( .A(n1), .Y(quotient[1]) );
  MX2X3M U4 ( .A(a[1]), .B(\u_div/SumTmp[1][0] ), .S0(n2), .Y(
        \u_div/PartRem[1][1] ) );
  AND2X12M U5 ( .A(\u_div/CryTmp[1][7] ), .B(n18), .Y(n30) );
  CLKINVX32M U6 ( .A(n29), .Y(n4) );
  INVX32M U7 ( .A(n4), .Y(quotient[2]) );
  MX2X12M U8 ( .A(a[5]), .B(\u_div/SumTmp[5][0] ), .S0(quotient[5]), .Y(
        \u_div/PartRem[5][1] ) );
  AND2X12M U9 ( .A(\u_div/CryTmp[6][2] ), .B(n16), .Y(quotient[6]) );
  BUFX18M U10 ( .A(n15), .Y(quotient[4]) );
  CLKAND2X3M U11 ( .A(\u_div/CryTmp[4][4] ), .B(n27), .Y(n15) );
  BUFX10M U12 ( .A(n17), .Y(quotient[5]) );
  INVX12M U13 ( .A(n6), .Y(quotient[3]) );
  NAND3X3M U14 ( .A(n8), .B(n20), .C(\u_div/CryTmp[3][5] ), .Y(n6) );
  AND2X12M U15 ( .A(\u_div/CryTmp[2][6] ), .B(n8), .Y(n29) );
  INVX32M U16 ( .A(b[3]), .Y(n22) );
  CLKINVX40M U17 ( .A(b[5]), .Y(n20) );
  CLKINVX40M U18 ( .A(b[4]), .Y(n21) );
  OR2X8M U19 ( .A(a[7]), .B(n25), .Y(\u_div/CryTmp[7][1] ) );
  OR2X1M U20 ( .A(a[5]), .B(n25), .Y(\u_div/CryTmp[5][1] ) );
  INVX32M U21 ( .A(b[0]), .Y(n25) );
  MX2X6M U22 ( .A(a[3]), .B(\u_div/SumTmp[3][0] ), .S0(quotient[3]), .Y(
        \u_div/PartRem[3][1] ) );
  MX2X2M U23 ( .A(\u_div/PartRem[3][2] ), .B(\u_div/SumTmp[2][2] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][3] ) );
  AND4X4M U24 ( .A(\u_div/CryTmp[7][1] ), .B(n26), .C(n24), .D(n23), .Y(
        quotient[7]) );
  MX2X1M U25 ( .A(\u_div/PartRem[3][3] ), .B(\u_div/SumTmp[2][3] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][4] ) );
  CLKMX2X2M U26 ( .A(\u_div/PartRem[4][2] ), .B(\u_div/SumTmp[3][2] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][3] ) );
  MX2X8M U27 ( .A(a[7]), .B(\u_div/SumTmp[7][0] ), .S0(quotient[7]), .Y(
        \u_div/PartRem[7][1] ) );
  MX2X2M U28 ( .A(\u_div/PartRem[7][1] ), .B(\u_div/SumTmp[6][1] ), .S0(
        quotient[6]), .Y(\u_div/PartRem[6][2] ) );
  MX2X2M U29 ( .A(\u_div/PartRem[6][1] ), .B(\u_div/SumTmp[5][1] ), .S0(
        quotient[5]), .Y(\u_div/PartRem[5][2] ) );
  NAND2X3M U30 ( .A(\u_div/SumTmp[6][0] ), .B(quotient[6]), .Y(n14) );
  NAND2X6M U31 ( .A(a[6]), .B(n12), .Y(n13) );
  BUFX32M U32 ( .A(n28), .Y(n8) );
  AND3X12M U33 ( .A(n8), .B(n21), .C(n20), .Y(n27) );
  AND2X12M U34 ( .A(n27), .B(n22), .Y(n26) );
  CLKMX2X12M U35 ( .A(\u_div/PartRem[4][1] ), .B(\u_div/SumTmp[3][1] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][2] ) );
  MX2X6M U36 ( .A(a[4]), .B(\u_div/SumTmp[4][0] ), .S0(quotient[4]), .Y(
        \u_div/PartRem[4][1] ) );
  MX2X6M U37 ( .A(\u_div/PartRem[5][2] ), .B(\u_div/SumTmp[4][2] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][3] ) );
  MX2X4M U38 ( .A(\u_div/PartRem[5][1] ), .B(\u_div/SumTmp[4][1] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][2] ) );
  MX2X4M U39 ( .A(\u_div/PartRem[3][1] ), .B(\u_div/SumTmp[2][1] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][2] ) );
  BUFX10M U40 ( .A(\u_div/PartRem[2][2] ), .Y(n9) );
  MX2X1M U41 ( .A(n9), .B(\u_div/SumTmp[1][2] ), .S0(quotient[1]), .Y(
        \u_div/PartRem[1][3] ) );
  MX2XLM U42 ( .A(\u_div/PartRem[2][1] ), .B(\u_div/SumTmp[1][1] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][2] ) );
  MX2X6M U43 ( .A(a[2]), .B(\u_div/SumTmp[2][0] ), .S0(quotient[2]), .Y(
        \u_div/PartRem[2][1] ) );
  NAND2X12M U44 ( .A(n13), .B(n14), .Y(\u_div/PartRem[6][1] ) );
  XNOR2X2M U45 ( .A(n25), .B(a[7]), .Y(\u_div/SumTmp[7][0] ) );
  AND2X1M U46 ( .A(\u_div/CryTmp[5][3] ), .B(n26), .Y(n17) );
  INVX2M U47 ( .A(quotient[6]), .Y(n12) );
  MX2X1M U48 ( .A(\u_div/PartRem[3][4] ), .B(\u_div/SumTmp[2][4] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][5] ) );
  INVX20M U49 ( .A(b[2]), .Y(n23) );
  AND2X1M U50 ( .A(n26), .B(n23), .Y(n16) );
  OR2X1M U51 ( .A(a[0]), .B(n25), .Y(\u_div/CryTmp[0][1] ) );
  INVX20M U52 ( .A(b[1]), .Y(n24) );
  NOR2X12M U53 ( .A(b[6]), .B(b[7]), .Y(n28) );
  MX2X1M U54 ( .A(\u_div/PartRem[6][2] ), .B(\u_div/SumTmp[5][2] ), .S0(
        quotient[5]), .Y(\u_div/PartRem[5][3] ) );
  MX2X1M U55 ( .A(\u_div/PartRem[4][3] ), .B(\u_div/SumTmp[3][3] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][4] ) );
  MX2X1M U56 ( .A(\u_div/PartRem[5][3] ), .B(\u_div/SumTmp[4][3] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][4] ) );
  MX2X1M U57 ( .A(\u_div/PartRem[3][5] ), .B(\u_div/SumTmp[2][5] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][6] ) );
  XNOR2X1M U58 ( .A(n25), .B(a[3]), .Y(\u_div/SumTmp[3][0] ) );
  XNOR2X1M U59 ( .A(n25), .B(a[6]), .Y(\u_div/SumTmp[6][0] ) );
  XNOR2X1M U60 ( .A(n25), .B(a[5]), .Y(\u_div/SumTmp[5][0] ) );
  XNOR2X1M U61 ( .A(n25), .B(a[2]), .Y(\u_div/SumTmp[2][0] ) );
  XNOR2X1M U62 ( .A(n25), .B(a[4]), .Y(\u_div/SumTmp[4][0] ) );
  OR2X1M U63 ( .A(a[6]), .B(n25), .Y(\u_div/CryTmp[6][1] ) );
  XNOR2X1M U64 ( .A(n25), .B(a[1]), .Y(\u_div/SumTmp[1][0] ) );
  CLKINVX1M U65 ( .A(b[7]), .Y(n18) );
  OR2X2M U66 ( .A(a[4]), .B(n25), .Y(\u_div/CryTmp[4][1] ) );
  OR2X2M U67 ( .A(a[3]), .B(n25), .Y(\u_div/CryTmp[3][1] ) );
  OR2X2M U68 ( .A(a[1]), .B(n25), .Y(\u_div/CryTmp[1][1] ) );
  OR2X2M U69 ( .A(a[2]), .B(n25), .Y(\u_div/CryTmp[2][1] ) );
  INVX2M U70 ( .A(b[6]), .Y(n19) );
  CLKMX2X2M U71 ( .A(\u_div/PartRem[2][6] ), .B(\u_div/SumTmp[1][6] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][7] ) );
  CLKMX2X2M U72 ( .A(\u_div/PartRem[4][4] ), .B(\u_div/SumTmp[3][4] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][5] ) );
  CLKMX2X2M U73 ( .A(\u_div/PartRem[2][5] ), .B(\u_div/SumTmp[1][5] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][6] ) );
  CLKMX2X2M U74 ( .A(\u_div/PartRem[2][4] ), .B(\u_div/SumTmp[1][4] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][5] ) );
  CLKMX2X2M U75 ( .A(\u_div/PartRem[2][3] ), .B(\u_div/SumTmp[1][3] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][4] ) );
endmodule


module ALU_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] DIFF;
  input CI;
  output CO;
  wire   n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [9:0] carry;

  ADDFX2M U2_7 ( .A(A[7]), .B(n2), .CI(carry[7]), .CO(carry[8]), .S(DIFF[7])
         );
  ADDFX2M U2_5 ( .A(A[5]), .B(n4), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  ADDFX2M U2_4 ( .A(A[4]), .B(n5), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4])
         );
  ADDFX2M U2_3 ( .A(A[3]), .B(n6), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3])
         );
  ADDFX2M U2_2 ( .A(A[2]), .B(n7), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2])
         );
  ADDFX2M U2_1 ( .A(A[1]), .B(n8), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1])
         );
  ADDFX2M U2_6 ( .A(A[6]), .B(n3), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6])
         );
  INVXLM U1 ( .A(B[1]), .Y(n8) );
  INVXLM U2 ( .A(B[4]), .Y(n5) );
  INVXLM U3 ( .A(B[5]), .Y(n4) );
  INVXLM U4 ( .A(B[2]), .Y(n7) );
  INVXLM U5 ( .A(B[3]), .Y(n6) );
  INVXLM U6 ( .A(B[7]), .Y(n2) );
  CLKINVX1M U7 ( .A(B[0]), .Y(n9) );
  INVX2M U8 ( .A(carry[8]), .Y(DIFF[8]) );
  INVX2M U9 ( .A(B[6]), .Y(n3) );
  XNOR2X2M U10 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  OR2X2M U11 ( .A(A[0]), .B(n9), .Y(carry[1]) );
endmodule


module ALU_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  ADDFX2M U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFX2M U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFX2M U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFX2M U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFX2M U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFX2M U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFX2M U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  AND2X2M U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1M U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_DW01_add_1 ( A, B, CI, SUM, CO );
  input [13:0] A;
  input [13:0] B;
  output [13:0] SUM;
  input CI;
  output CO;
  wire   \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19;
  assign SUM[6] = A[6];
  assign SUM[5] = \A[5] ;
  assign \A[5]  = A[5];
  assign SUM[4] = \A[4] ;
  assign \A[4]  = A[4];
  assign SUM[3] = \A[3] ;
  assign \A[3]  = A[3];
  assign SUM[2] = \A[2] ;
  assign \A[2]  = A[2];
  assign SUM[1] = \A[1] ;
  assign \A[1]  = A[1];
  assign SUM[0] = \A[0] ;
  assign \A[0]  = A[0];

  OAI21BX4M U2 ( .A0(n12), .A1(n13), .B0N(n14), .Y(n10) );
  AOI2BB1X2M U3 ( .A0N(n1), .A1N(n4), .B0(n3), .Y(n17) );
  NOR2X2M U4 ( .A(B[8]), .B(A[8]), .Y(n7) );
  NOR2X2M U5 ( .A(B[9]), .B(A[9]), .Y(n4) );
  NOR2X2M U6 ( .A(B[10]), .B(A[10]), .Y(n16) );
  NOR2X2M U7 ( .A(B[11]), .B(A[11]), .Y(n12) );
  CLKXOR2X2M U8 ( .A(B[13]), .B(n9), .Y(SUM[13]) );
  NAND2X2M U9 ( .A(A[7]), .B(B[7]), .Y(n6) );
  CLKXOR2X2M U10 ( .A(A[7]), .B(B[7]), .Y(SUM[7]) );
  XNOR2X1M U11 ( .A(n1), .B(n2), .Y(SUM[9]) );
  NOR2X1M U12 ( .A(n3), .B(n4), .Y(n2) );
  CLKXOR2X2M U13 ( .A(n5), .B(n6), .Y(SUM[8]) );
  NAND2BX1M U14 ( .AN(n7), .B(n8), .Y(n5) );
  OAI2BB1X1M U15 ( .A0N(n10), .A1N(A[12]), .B0(n11), .Y(n9) );
  OAI21X1M U16 ( .A0(A[12]), .A1(n10), .B0(B[12]), .Y(n11) );
  XOR3XLM U17 ( .A(B[12]), .B(A[12]), .C(n10), .Y(SUM[12]) );
  XNOR2X1M U18 ( .A(n13), .B(n15), .Y(SUM[11]) );
  NOR2X1M U19 ( .A(n14), .B(n12), .Y(n15) );
  AND2X1M U20 ( .A(B[11]), .B(A[11]), .Y(n14) );
  OA21X1M U21 ( .A0(n16), .A1(n17), .B0(n18), .Y(n13) );
  CLKXOR2X2M U22 ( .A(n19), .B(n17), .Y(SUM[10]) );
  AND2X1M U23 ( .A(B[9]), .B(A[9]), .Y(n3) );
  OA21X1M U24 ( .A0(n6), .A1(n7), .B0(n8), .Y(n1) );
  CLKNAND2X2M U25 ( .A(B[8]), .B(A[8]), .Y(n8) );
  NAND2BX1M U26 ( .AN(n16), .B(n18), .Y(n19) );
  CLKNAND2X2M U27 ( .A(B[10]), .B(A[10]), .Y(n18) );
endmodule


module ALU_DW02_mult_0 ( A, B, TC, PRODUCT );
  input [7:0] A;
  input [7:0] B;
  output [15:0] PRODUCT;
  input TC;
  wire   \ab[7][7] , \ab[7][6] , \ab[7][5] , \ab[7][4] , \ab[7][3] ,
         \ab[7][2] , \ab[7][1] , \ab[7][0] , \ab[6][7] , \ab[6][6] ,
         \ab[6][5] , \ab[6][4] , \ab[6][3] , \ab[6][2] , \ab[6][1] ,
         \ab[6][0] , \ab[5][7] , \ab[5][6] , \ab[5][5] , \ab[5][4] ,
         \ab[5][3] , \ab[5][2] , \ab[5][1] , \ab[5][0] , \ab[4][7] ,
         \ab[4][6] , \ab[4][5] , \ab[4][4] , \ab[4][3] , \ab[4][2] ,
         \ab[4][1] , \ab[4][0] , \ab[3][7] , \ab[3][6] , \ab[3][5] ,
         \ab[3][4] , \ab[3][3] , \ab[3][2] , \ab[3][1] , \ab[3][0] ,
         \ab[2][7] , \ab[2][6] , \ab[2][5] , \ab[2][4] , \ab[2][3] ,
         \ab[2][2] , \ab[2][1] , \ab[2][0] , \ab[1][7] , \ab[1][6] ,
         \ab[1][5] , \ab[1][4] , \ab[1][3] , \ab[1][2] , \ab[1][1] ,
         \ab[1][0] , \ab[0][7] , \ab[0][6] , \ab[0][5] , \ab[0][4] ,
         \ab[0][3] , \ab[0][2] , \ab[0][1] , \CARRYB[7][6] , \CARRYB[7][5] ,
         \CARRYB[7][4] , \CARRYB[7][3] , \CARRYB[7][2] , \CARRYB[7][1] ,
         \CARRYB[7][0] , \CARRYB[6][6] , \CARRYB[6][5] , \CARRYB[6][4] ,
         \CARRYB[6][3] , \CARRYB[6][2] , \CARRYB[6][1] , \CARRYB[6][0] ,
         \CARRYB[5][6] , \CARRYB[5][5] , \CARRYB[5][4] , \CARRYB[5][3] ,
         \CARRYB[5][2] , \CARRYB[5][1] , \CARRYB[5][0] , \CARRYB[4][6] ,
         \CARRYB[4][5] , \CARRYB[4][4] , \CARRYB[4][3] , \CARRYB[4][2] ,
         \CARRYB[4][1] , \CARRYB[4][0] , \CARRYB[3][6] , \CARRYB[3][5] ,
         \CARRYB[3][4] , \CARRYB[3][3] , \CARRYB[3][2] , \CARRYB[3][1] ,
         \CARRYB[3][0] , \CARRYB[2][6] , \CARRYB[2][5] , \CARRYB[2][4] ,
         \CARRYB[2][3] , \CARRYB[2][2] , \CARRYB[2][1] , \CARRYB[2][0] ,
         \SUMB[7][6] , \SUMB[7][5] , \SUMB[7][4] , \SUMB[7][3] , \SUMB[7][2] ,
         \SUMB[7][1] , \SUMB[7][0] , \SUMB[6][6] , \SUMB[6][5] , \SUMB[6][4] ,
         \SUMB[6][3] , \SUMB[6][2] , \SUMB[6][1] , \SUMB[5][6] , \SUMB[5][5] ,
         \SUMB[5][4] , \SUMB[5][3] , \SUMB[5][2] , \SUMB[5][1] , \SUMB[4][6] ,
         \SUMB[4][5] , \SUMB[4][4] , \SUMB[4][3] , \SUMB[4][2] , \SUMB[4][1] ,
         \SUMB[3][6] , \SUMB[3][5] , \SUMB[3][4] , \SUMB[3][3] , \SUMB[3][2] ,
         \SUMB[3][1] , \SUMB[2][6] , \SUMB[2][5] , \SUMB[2][4] , \SUMB[2][3] ,
         \SUMB[2][2] , \SUMB[2][1] , \SUMB[1][6] , \SUMB[1][5] , \SUMB[1][4] ,
         \SUMB[1][3] , \SUMB[1][2] , \SUMB[1][1] , \A1[12] , \A1[11] ,
         \A1[10] , \A1[9] , \A1[8] , \A1[7] , \A1[6] , \A1[4] , \A1[3] ,
         \A1[2] , \A1[1] , \A1[0] , n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32;

  ALU_DW01_add_1 FS_1 ( .A({1'b0, \A1[12] , \A1[11] , \A1[10] , \A1[9] , 
        \A1[8] , \A1[7] , \A1[6] , \SUMB[7][0] , \A1[4] , \A1[3] , \A1[2] , 
        \A1[1] , \A1[0] }), .B({n10, n16, n15, n14, n13, n12, n11, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .CI(1'b0), .SUM(PRODUCT[15:2]) );
  ADDFX2M S5_6 ( .A(\ab[7][6] ), .B(\CARRYB[6][6] ), .CI(\ab[6][7] ), .CO(
        \CARRYB[7][6] ), .S(\SUMB[7][6] ) );
  ADDFX2M S3_6_6 ( .A(\ab[6][6] ), .B(\CARRYB[5][6] ), .CI(\ab[5][7] ), .CO(
        \CARRYB[6][6] ), .S(\SUMB[6][6] ) );
  ADDFX2M S4_5 ( .A(\ab[7][5] ), .B(\CARRYB[6][5] ), .CI(\SUMB[6][6] ), .CO(
        \CARRYB[7][5] ), .S(\SUMB[7][5] ) );
  ADDFX2M S1_6_0 ( .A(\ab[6][0] ), .B(\CARRYB[5][0] ), .CI(\SUMB[5][1] ), .CO(
        \CARRYB[6][0] ), .S(\A1[4] ) );
  ADDFX2M S1_5_0 ( .A(\ab[5][0] ), .B(\CARRYB[4][0] ), .CI(\SUMB[4][1] ), .CO(
        \CARRYB[5][0] ), .S(\A1[3] ) );
  ADDFX2M S1_4_0 ( .A(\ab[4][0] ), .B(\CARRYB[3][0] ), .CI(\SUMB[3][1] ), .CO(
        \CARRYB[4][0] ), .S(\A1[2] ) );
  ADDFX2M S1_3_0 ( .A(\ab[3][0] ), .B(\CARRYB[2][0] ), .CI(\SUMB[2][1] ), .CO(
        \CARRYB[3][0] ), .S(\A1[1] ) );
  ADDFX2M S1_2_0 ( .A(\ab[2][0] ), .B(n8), .CI(\SUMB[1][1] ), .CO(
        \CARRYB[2][0] ), .S(\A1[0] ) );
  ADDFX2M S3_5_6 ( .A(\ab[5][6] ), .B(\CARRYB[4][6] ), .CI(\ab[4][7] ), .CO(
        \CARRYB[5][6] ), .S(\SUMB[5][6] ) );
  ADDFX2M S4_0 ( .A(\ab[7][0] ), .B(\CARRYB[6][0] ), .CI(\SUMB[6][1] ), .CO(
        \CARRYB[7][0] ), .S(\SUMB[7][0] ) );
  ADDFX2M S2_6_1 ( .A(\ab[6][1] ), .B(\CARRYB[5][1] ), .CI(\SUMB[5][2] ), .CO(
        \CARRYB[6][1] ), .S(\SUMB[6][1] ) );
  ADDFX2M S2_5_1 ( .A(\ab[5][1] ), .B(\CARRYB[4][1] ), .CI(\SUMB[4][2] ), .CO(
        \CARRYB[5][1] ), .S(\SUMB[5][1] ) );
  ADDFX2M S2_4_1 ( .A(\ab[4][1] ), .B(\CARRYB[3][1] ), .CI(\SUMB[3][2] ), .CO(
        \CARRYB[4][1] ), .S(\SUMB[4][1] ) );
  ADDFX2M S2_3_1 ( .A(\ab[3][1] ), .B(\CARRYB[2][1] ), .CI(\SUMB[2][2] ), .CO(
        \CARRYB[3][1] ), .S(\SUMB[3][1] ) );
  ADDFX2M S2_6_2 ( .A(\ab[6][2] ), .B(\CARRYB[5][2] ), .CI(\SUMB[5][3] ), .CO(
        \CARRYB[6][2] ), .S(\SUMB[6][2] ) );
  ADDFX2M S2_6_3 ( .A(\ab[6][3] ), .B(\CARRYB[5][3] ), .CI(\SUMB[5][4] ), .CO(
        \CARRYB[6][3] ), .S(\SUMB[6][3] ) );
  ADDFX2M S2_5_2 ( .A(\ab[5][2] ), .B(\CARRYB[4][2] ), .CI(\SUMB[4][3] ), .CO(
        \CARRYB[5][2] ), .S(\SUMB[5][2] ) );
  ADDFX2M S2_5_3 ( .A(\ab[5][3] ), .B(\CARRYB[4][3] ), .CI(\SUMB[4][4] ), .CO(
        \CARRYB[5][3] ), .S(\SUMB[5][3] ) );
  ADDFX2M S2_5_4 ( .A(\ab[5][4] ), .B(\CARRYB[4][4] ), .CI(\SUMB[4][5] ), .CO(
        \CARRYB[5][4] ), .S(\SUMB[5][4] ) );
  ADDFX2M S2_4_3 ( .A(\ab[4][3] ), .B(\CARRYB[3][3] ), .CI(\SUMB[3][4] ), .CO(
        \CARRYB[4][3] ), .S(\SUMB[4][3] ) );
  ADDFX2M S2_4_2 ( .A(\ab[4][2] ), .B(\CARRYB[3][2] ), .CI(\SUMB[3][3] ), .CO(
        \CARRYB[4][2] ), .S(\SUMB[4][2] ) );
  ADDFX2M S2_4_5 ( .A(\ab[4][5] ), .B(\CARRYB[3][5] ), .CI(\SUMB[3][6] ), .CO(
        \CARRYB[4][5] ), .S(\SUMB[4][5] ) );
  ADDFX2M S2_3_3 ( .A(\ab[3][3] ), .B(\CARRYB[2][3] ), .CI(\SUMB[2][4] ), .CO(
        \CARRYB[3][3] ), .S(\SUMB[3][3] ) );
  ADDFX2M S2_3_2 ( .A(\ab[3][2] ), .B(\CARRYB[2][2] ), .CI(\SUMB[2][3] ), .CO(
        \CARRYB[3][2] ), .S(\SUMB[3][2] ) );
  ADDFX2M S2_3_5 ( .A(\ab[3][5] ), .B(\CARRYB[2][5] ), .CI(\SUMB[2][6] ), .CO(
        \CARRYB[3][5] ), .S(\SUMB[3][5] ) );
  ADDFX2M S2_2_1 ( .A(\ab[2][1] ), .B(n6), .CI(\SUMB[1][2] ), .CO(
        \CARRYB[2][1] ), .S(\SUMB[2][1] ) );
  ADDFX2M S2_6_5 ( .A(\ab[6][5] ), .B(\CARRYB[5][5] ), .CI(\SUMB[5][6] ), .CO(
        \CARRYB[6][5] ), .S(\SUMB[6][5] ) );
  ADDFX2M S2_6_4 ( .A(\ab[6][4] ), .B(\CARRYB[5][4] ), .CI(\SUMB[5][5] ), .CO(
        \CARRYB[6][4] ), .S(\SUMB[6][4] ) );
  ADDFX2M S2_5_5 ( .A(\ab[5][5] ), .B(\CARRYB[4][5] ), .CI(\SUMB[4][6] ), .CO(
        \CARRYB[5][5] ), .S(\SUMB[5][5] ) );
  ADDFX2M S2_4_4 ( .A(\ab[4][4] ), .B(\CARRYB[3][4] ), .CI(\SUMB[3][5] ), .CO(
        \CARRYB[4][4] ), .S(\SUMB[4][4] ) );
  ADDFX2M S2_3_4 ( .A(\ab[3][4] ), .B(\CARRYB[2][4] ), .CI(\SUMB[2][5] ), .CO(
        \CARRYB[3][4] ), .S(\SUMB[3][4] ) );
  ADDFX2M S3_4_6 ( .A(\ab[4][6] ), .B(\CARRYB[3][6] ), .CI(\ab[3][7] ), .CO(
        \CARRYB[4][6] ), .S(\SUMB[4][6] ) );
  ADDFX2M S3_3_6 ( .A(\ab[3][6] ), .B(\CARRYB[2][6] ), .CI(\ab[2][7] ), .CO(
        \CARRYB[3][6] ), .S(\SUMB[3][6] ) );
  ADDFX2M S3_2_6 ( .A(\ab[2][6] ), .B(n9), .CI(\ab[1][7] ), .CO(\CARRYB[2][6] ), .S(\SUMB[2][6] ) );
  ADDFX2M S2_2_3 ( .A(\ab[2][3] ), .B(n5), .CI(\SUMB[1][4] ), .CO(
        \CARRYB[2][3] ), .S(\SUMB[2][3] ) );
  ADDFX2M S2_2_4 ( .A(\ab[2][4] ), .B(n4), .CI(\SUMB[1][5] ), .CO(
        \CARRYB[2][4] ), .S(\SUMB[2][4] ) );
  ADDFX2M S2_2_5 ( .A(\ab[2][5] ), .B(n7), .CI(\SUMB[1][6] ), .CO(
        \CARRYB[2][5] ), .S(\SUMB[2][5] ) );
  ADDFX2M S4_1 ( .A(\ab[7][1] ), .B(\CARRYB[6][1] ), .CI(\SUMB[6][2] ), .CO(
        \CARRYB[7][1] ), .S(\SUMB[7][1] ) );
  ADDFX2M S4_4 ( .A(\ab[7][4] ), .B(\CARRYB[6][4] ), .CI(\SUMB[6][5] ), .CO(
        \CARRYB[7][4] ), .S(\SUMB[7][4] ) );
  ADDFX2M S4_3 ( .A(\ab[7][3] ), .B(\CARRYB[6][3] ), .CI(\SUMB[6][4] ), .CO(
        \CARRYB[7][3] ), .S(\SUMB[7][3] ) );
  ADDFX2M S4_2 ( .A(\ab[7][2] ), .B(\CARRYB[6][2] ), .CI(\SUMB[6][3] ), .CO(
        \CARRYB[7][2] ), .S(\SUMB[7][2] ) );
  ADDFX2M S2_2_2 ( .A(\ab[2][2] ), .B(n3), .CI(\SUMB[1][3] ), .CO(
        \CARRYB[2][2] ), .S(\SUMB[2][2] ) );
  AND2X2M U2 ( .A(\ab[0][3] ), .B(\ab[1][2] ), .Y(n3) );
  AND2X2M U3 ( .A(\ab[0][5] ), .B(\ab[1][4] ), .Y(n4) );
  AND2X2M U4 ( .A(\ab[0][4] ), .B(\ab[1][3] ), .Y(n5) );
  AND2X2M U5 ( .A(\ab[0][2] ), .B(\ab[1][1] ), .Y(n6) );
  AND2X2M U6 ( .A(\ab[0][6] ), .B(\ab[1][5] ), .Y(n7) );
  AND2X2M U7 ( .A(\ab[0][1] ), .B(\ab[1][0] ), .Y(n8) );
  AND2X2M U8 ( .A(\ab[0][7] ), .B(\ab[1][6] ), .Y(n9) );
  AND2X2M U9 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(n10) );
  NOR2X2M U10 ( .A(n26), .B(n24), .Y(\ab[0][6] ) );
  NOR2X2M U11 ( .A(n26), .B(n23), .Y(\ab[1][6] ) );
  NOR2X2M U12 ( .A(n28), .B(n24), .Y(\ab[0][4] ) );
  NOR2X2M U13 ( .A(n27), .B(n24), .Y(\ab[0][5] ) );
  NOR2X2M U14 ( .A(n29), .B(n24), .Y(\ab[0][3] ) );
  NOR2X2M U15 ( .A(n29), .B(n23), .Y(\ab[1][3] ) );
  NOR2X2M U16 ( .A(n28), .B(n23), .Y(\ab[1][4] ) );
  NOR2X2M U17 ( .A(n30), .B(n23), .Y(\ab[1][2] ) );
  CLKXOR2X2M U18 ( .A(\ab[1][5] ), .B(\ab[0][6] ), .Y(\SUMB[1][5] ) );
  NOR2X2M U19 ( .A(n25), .B(n24), .Y(\ab[0][7] ) );
  NOR2X2M U20 ( .A(n30), .B(n24), .Y(\ab[0][2] ) );
  NOR2X2M U21 ( .A(n31), .B(n24), .Y(\ab[0][1] ) );
  NOR2X2M U22 ( .A(n27), .B(n23), .Y(\ab[1][5] ) );
  NOR2X2M U23 ( .A(n31), .B(n23), .Y(\ab[1][1] ) );
  NOR2X2M U24 ( .A(n32), .B(n23), .Y(\ab[1][0] ) );
  NOR2X2M U25 ( .A(n17), .B(n25), .Y(\ab[7][7] ) );
  CLKINVX4M U26 ( .A(A[4]), .Y(n20) );
  CLKINVX4M U27 ( .A(A[5]), .Y(n19) );
  CLKINVX4M U28 ( .A(A[6]), .Y(n18) );
  CLKINVX4M U29 ( .A(A[7]), .Y(n17) );
  CLKINVX4M U30 ( .A(B[3]), .Y(n29) );
  CLKINVX4M U31 ( .A(B[2]), .Y(n30) );
  CLKINVX4M U32 ( .A(B[4]), .Y(n28) );
  CLKINVX4M U33 ( .A(B[5]), .Y(n27) );
  CLKINVX4M U34 ( .A(B[7]), .Y(n25) );
  CLKINVX4M U35 ( .A(B[1]), .Y(n31) );
  CLKINVX4M U36 ( .A(B[0]), .Y(n32) );
  CLKXOR2X2M U37 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(\A1[7] ) );
  CLKXOR2X2M U38 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(\A1[8] ) );
  CLKXOR2X2M U39 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(\A1[9] ) );
  INVX4M U40 ( .A(A[1]), .Y(n23) );
  AND2X2M U41 ( .A(\CARRYB[7][0] ), .B(\SUMB[7][1] ), .Y(n11) );
  AND2X2M U42 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(n12) );
  INVX4M U43 ( .A(A[2]), .Y(n22) );
  AND2X2M U44 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(n13) );
  CLKXOR2X2M U45 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(\A1[10] ) );
  CLKXOR2X2M U46 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(\A1[11] ) );
  INVX4M U47 ( .A(A[3]), .Y(n21) );
  AND2X2M U48 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(n14) );
  AND2X2M U49 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(n15) );
  CLKXOR2X2M U50 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(\A1[12] ) );
  AND2X2M U51 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(n16) );
  XOR2X1M U52 ( .A(\ab[1][0] ), .B(\ab[0][1] ), .Y(PRODUCT[1]) );
  XOR2X1M U53 ( .A(\ab[1][3] ), .B(\ab[0][4] ), .Y(\SUMB[1][3] ) );
  INVX4M U54 ( .A(B[6]), .Y(n26) );
  INVX4M U55 ( .A(A[0]), .Y(n24) );
  XOR2X1M U56 ( .A(\ab[1][6] ), .B(\ab[0][7] ), .Y(\SUMB[1][6] ) );
  XOR2X1M U57 ( .A(\ab[1][4] ), .B(\ab[0][5] ), .Y(\SUMB[1][4] ) );
  XOR2X1M U58 ( .A(\ab[1][2] ), .B(\ab[0][3] ), .Y(\SUMB[1][2] ) );
  XOR2X1M U59 ( .A(\ab[1][1] ), .B(\ab[0][2] ), .Y(\SUMB[1][1] ) );
  CLKXOR2X2M U60 ( .A(\CARRYB[7][0] ), .B(\SUMB[7][1] ), .Y(\A1[6] ) );
  NOR2X1M U62 ( .A(n17), .B(n26), .Y(\ab[7][6] ) );
  NOR2X1M U63 ( .A(n17), .B(n27), .Y(\ab[7][5] ) );
  NOR2X1M U64 ( .A(n17), .B(n28), .Y(\ab[7][4] ) );
  NOR2X1M U65 ( .A(n17), .B(n29), .Y(\ab[7][3] ) );
  NOR2X1M U66 ( .A(n17), .B(n30), .Y(\ab[7][2] ) );
  NOR2X1M U67 ( .A(n17), .B(n31), .Y(\ab[7][1] ) );
  NOR2X1M U68 ( .A(n17), .B(n32), .Y(\ab[7][0] ) );
  NOR2X1M U69 ( .A(n25), .B(n18), .Y(\ab[6][7] ) );
  NOR2X1M U70 ( .A(n26), .B(n18), .Y(\ab[6][6] ) );
  NOR2X1M U71 ( .A(n27), .B(n18), .Y(\ab[6][5] ) );
  NOR2X1M U72 ( .A(n28), .B(n18), .Y(\ab[6][4] ) );
  NOR2X1M U73 ( .A(n29), .B(n18), .Y(\ab[6][3] ) );
  NOR2X1M U74 ( .A(n30), .B(n18), .Y(\ab[6][2] ) );
  NOR2X1M U75 ( .A(n31), .B(n18), .Y(\ab[6][1] ) );
  NOR2X1M U76 ( .A(n32), .B(n18), .Y(\ab[6][0] ) );
  NOR2X1M U77 ( .A(n25), .B(n19), .Y(\ab[5][7] ) );
  NOR2X1M U78 ( .A(n26), .B(n19), .Y(\ab[5][6] ) );
  NOR2X1M U79 ( .A(n27), .B(n19), .Y(\ab[5][5] ) );
  NOR2X1M U80 ( .A(n28), .B(n19), .Y(\ab[5][4] ) );
  NOR2X1M U81 ( .A(n29), .B(n19), .Y(\ab[5][3] ) );
  NOR2X1M U82 ( .A(n30), .B(n19), .Y(\ab[5][2] ) );
  NOR2X1M U83 ( .A(n31), .B(n19), .Y(\ab[5][1] ) );
  NOR2X1M U84 ( .A(n32), .B(n19), .Y(\ab[5][0] ) );
  NOR2X1M U85 ( .A(n25), .B(n20), .Y(\ab[4][7] ) );
  NOR2X1M U86 ( .A(n26), .B(n20), .Y(\ab[4][6] ) );
  NOR2X1M U87 ( .A(n27), .B(n20), .Y(\ab[4][5] ) );
  NOR2X1M U88 ( .A(n28), .B(n20), .Y(\ab[4][4] ) );
  NOR2X1M U89 ( .A(n29), .B(n20), .Y(\ab[4][3] ) );
  NOR2X1M U90 ( .A(n30), .B(n20), .Y(\ab[4][2] ) );
  NOR2X1M U91 ( .A(n31), .B(n20), .Y(\ab[4][1] ) );
  NOR2X1M U92 ( .A(n32), .B(n20), .Y(\ab[4][0] ) );
  NOR2X1M U93 ( .A(n25), .B(n21), .Y(\ab[3][7] ) );
  NOR2X1M U94 ( .A(n26), .B(n21), .Y(\ab[3][6] ) );
  NOR2X1M U95 ( .A(n27), .B(n21), .Y(\ab[3][5] ) );
  NOR2X1M U96 ( .A(n28), .B(n21), .Y(\ab[3][4] ) );
  NOR2X1M U97 ( .A(n29), .B(n21), .Y(\ab[3][3] ) );
  NOR2X1M U98 ( .A(n30), .B(n21), .Y(\ab[3][2] ) );
  NOR2X1M U99 ( .A(n31), .B(n21), .Y(\ab[3][1] ) );
  NOR2X1M U100 ( .A(n32), .B(n21), .Y(\ab[3][0] ) );
  NOR2X1M U101 ( .A(n25), .B(n22), .Y(\ab[2][7] ) );
  NOR2X1M U102 ( .A(n26), .B(n22), .Y(\ab[2][6] ) );
  NOR2X1M U103 ( .A(n27), .B(n22), .Y(\ab[2][5] ) );
  NOR2X1M U104 ( .A(n28), .B(n22), .Y(\ab[2][4] ) );
  NOR2X1M U105 ( .A(n29), .B(n22), .Y(\ab[2][3] ) );
  NOR2X1M U106 ( .A(n30), .B(n22), .Y(\ab[2][2] ) );
  NOR2X1M U107 ( .A(n31), .B(n22), .Y(\ab[2][1] ) );
  NOR2X1M U108 ( .A(n32), .B(n22), .Y(\ab[2][0] ) );
  NOR2X1M U109 ( .A(n25), .B(n23), .Y(\ab[1][7] ) );
  NOR2X1M U110 ( .A(n32), .B(n24), .Y(PRODUCT[0]) );
endmodule


module ALU ( A, B, EN, ALU_FUN, CLK, RST, ALU_OUT, OUT_VALID );
  input [7:0] A;
  input [7:0] B;
  input [3:0] ALU_FUN;
  output [15:0] ALU_OUT;
  input EN, CLK, RST;
  output OUT_VALID;
  wire   N91, N92, N93, N94, N95, N96, N97, N98, N99, N100, N101, N102, N103,
         N104, N105, N106, N107, N108, N109, N110, N111, N112, N113, N114,
         N115, N116, N117, N118, N119, N120, N121, N122, N123, N124, N125,
         N126, N127, N128, N129, N130, N131, N132, N157, N158, N159, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90,
         n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103,
         n104, n105, n106, n107, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n41, n42, n108, n109, n110, n111, n112, n113,
         n114, n115, n116, n117, n118, n119, n120, n121, n122, n123, n124,
         n125, n126, n127, n128, n129, n130, n131, n132, n133, n134, n135,
         n136, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146,
         n147, n148, n149, n150, n151, n152, n153, n154, n155, n156, n157,
         n158, n159, n160, n161, n162, n163;
  wire   [15:0] ALU_OUT_Comb;

  OAI2BB1X4M U77 ( .A0N(n100), .A1N(n99), .B0(n101), .Y(n48) );
  ALU_DW_div_uns_0 div_50 ( .a({A[7:6], n25, n22, n19, n16, n13, n11}), .b(B), 
        .quotient({N132, N131, N130, N129, N128, N127, N126, N125}) );
  ALU_DW01_sub_0 sub_44 ( .A({1'b0, A[7:6], n25, n22, n19, n16, n13, n11}), 
        .B({1'b0, B[7], n10, B[5:0]}), .CI(1'b0), .DIFF({N108, N107, N106, 
        N105, N104, N103, N102, N101, N100}) );
  ALU_DW01_add_0 add_41 ( .A({1'b0, A[7:6], n25, n22, n19, n16, n13, n11}), 
        .B({1'b0, B[7], n10, B[5:0]}), .CI(1'b0), .SUM({N99, N98, N97, N96, 
        N95, N94, N93, N92, N91}) );
  ALU_DW02_mult_0 mult_47 ( .A({A[7:6], n25, n22, n19, n16, n13, n11}), .B({
        B[7], n10, B[5:0]}), .TC(1'b0), .PRODUCT({N124, N123, N122, N121, N120, 
        N119, N118, N117, N116, N115, N114, N113, N112, N111, N110, N109}) );
  DFFRQX2M \ALU_OUT_reg[7]  ( .D(ALU_OUT_Comb[7]), .CK(CLK), .RN(n112), .Q(
        ALU_OUT[7]) );
  DFFRQX2M \ALU_OUT_reg[6]  ( .D(ALU_OUT_Comb[6]), .CK(CLK), .RN(n112), .Q(
        ALU_OUT[6]) );
  DFFRQX2M \ALU_OUT_reg[5]  ( .D(ALU_OUT_Comb[5]), .CK(CLK), .RN(n112), .Q(
        ALU_OUT[5]) );
  DFFRQX2M \ALU_OUT_reg[4]  ( .D(ALU_OUT_Comb[4]), .CK(CLK), .RN(n112), .Q(
        ALU_OUT[4]) );
  DFFRQX2M \ALU_OUT_reg[3]  ( .D(ALU_OUT_Comb[3]), .CK(CLK), .RN(n113), .Q(
        ALU_OUT[3]) );
  DFFRQX2M \ALU_OUT_reg[2]  ( .D(ALU_OUT_Comb[2]), .CK(CLK), .RN(n113), .Q(
        ALU_OUT[2]) );
  DFFRQX2M \ALU_OUT_reg[1]  ( .D(ALU_OUT_Comb[1]), .CK(CLK), .RN(n113), .Q(
        ALU_OUT[1]) );
  DFFRQX2M \ALU_OUT_reg[0]  ( .D(ALU_OUT_Comb[0]), .CK(CLK), .RN(n113), .Q(
        ALU_OUT[0]) );
  DFFRQX4M OUT_VALID_reg ( .D(EN), .CK(CLK), .RN(n113), .Q(OUT_VALID) );
  DFFRQX2M \ALU_OUT_reg[8]  ( .D(ALU_OUT_Comb[8]), .CK(CLK), .RN(n112), .Q(
        ALU_OUT[8]) );
  DFFRQX2M \ALU_OUT_reg[15]  ( .D(ALU_OUT_Comb[15]), .CK(CLK), .RN(n112), .Q(
        ALU_OUT[15]) );
  DFFRQX2M \ALU_OUT_reg[14]  ( .D(ALU_OUT_Comb[14]), .CK(CLK), .RN(n112), .Q(
        ALU_OUT[14]) );
  DFFRQX2M \ALU_OUT_reg[13]  ( .D(ALU_OUT_Comb[13]), .CK(CLK), .RN(n112), .Q(
        ALU_OUT[13]) );
  DFFRQX2M \ALU_OUT_reg[12]  ( .D(ALU_OUT_Comb[12]), .CK(CLK), .RN(n112), .Q(
        ALU_OUT[12]) );
  DFFRQX2M \ALU_OUT_reg[11]  ( .D(ALU_OUT_Comb[11]), .CK(CLK), .RN(n112), .Q(
        ALU_OUT[11]) );
  DFFRQX2M \ALU_OUT_reg[10]  ( .D(ALU_OUT_Comb[10]), .CK(CLK), .RN(n112), .Q(
        ALU_OUT[10]) );
  DFFRQX2M \ALU_OUT_reg[9]  ( .D(ALU_OUT_Comb[9]), .CK(CLK), .RN(n112), .Q(
        ALU_OUT[9]) );
  CLKINVX2M U3 ( .A(B[3]), .Y(n143) );
  AOI31X4M U4 ( .A0(n93), .A1(n94), .A2(n95), .B0(n149), .Y(ALU_OUT_Comb[0])
         );
  NOR2X4M U7 ( .A(n159), .B(n9), .Y(n105) );
  BUFX4M U8 ( .A(n49), .Y(n5) );
  AOI31X2M U9 ( .A0(n81), .A1(n82), .A2(n83), .B0(n149), .Y(ALU_OUT_Comb[1])
         );
  AND3X2M U10 ( .A(n6), .B(n7), .C(n8), .Y(n82) );
  CLKINVX1M U11 ( .A(A[7]), .Y(n147) );
  CLKINVX2M U12 ( .A(A[7]), .Y(n150) );
  INVXLM U13 ( .A(A[6]), .Y(n27) );
  OR2X2M U14 ( .A(n107), .B(n160), .Y(n3) );
  NAND2X2M U15 ( .A(n99), .B(n105), .Y(n4) );
  INVX4M U16 ( .A(A[4]), .Y(n21) );
  INVX2M U17 ( .A(B[2]), .Y(n142) );
  AOI222X4M U18 ( .A0(N109), .A1(n29), .B0(n11), .B1(n41), .C0(N125), .C1(n5), 
        .Y(n94) );
  XNOR2X4M U19 ( .A(A[6]), .B(n10), .Y(n134) );
  OAI31X2M U20 ( .A0(n127), .A1(n118), .A2(n117), .B0(n128), .Y(n120) );
  AOI211X2M U21 ( .A0(n14), .A1(n145), .B0(n124), .C0(n116), .Y(n117) );
  NOR2X2M U22 ( .A(n147), .B(B[7]), .Y(n137) );
  OAI21X2M U23 ( .A0(n137), .A1(n122), .B0(n138), .Y(N159) );
  NOR3BX2M U24 ( .AN(n105), .B(n162), .C(ALU_FUN[2]), .Y(n49) );
  INVX4M U25 ( .A(A[5]), .Y(n24) );
  NAND2XLM U26 ( .A(N126), .B(n5), .Y(n6) );
  NAND2X2M U27 ( .A(n42), .B(n154), .Y(n7) );
  NAND2X2M U28 ( .A(n14), .B(n30), .Y(n8) );
  CLKBUFX4M U29 ( .A(B[6]), .Y(n10) );
  NOR2X2M U30 ( .A(n142), .B(n17), .Y(n118) );
  NOR2X2M U31 ( .A(n141), .B(n11), .Y(n115) );
  AOI211X2M U32 ( .A0(n125), .A1(n154), .B0(n124), .C0(n123), .Y(n126) );
  NOR2X2M U33 ( .A(n143), .B(n20), .Y(n127) );
  NOR2X2M U34 ( .A(n9), .B(ALU_FUN[0]), .Y(n100) );
  BUFX6M U35 ( .A(A[0]), .Y(n11) );
  OAI21X1M U36 ( .A0(B[0]), .A1(n102), .B0(n103), .Y(n96) );
  OAI21X1M U37 ( .A0(B[1]), .A1(n87), .B0(n88), .Y(n84) );
  CLKINVX1M U38 ( .A(B[0]), .Y(n141) );
  INVXLM U39 ( .A(B[4]), .Y(n158) );
  INVXLM U40 ( .A(B[5]), .Y(n157) );
  INVXLM U41 ( .A(B[7]), .Y(n156) );
  NAND2X1M U42 ( .A(B[7]), .B(n147), .Y(n138) );
  INVX4M U43 ( .A(n4), .Y(n30) );
  INVX4M U44 ( .A(n4), .Y(n41) );
  INVX4M U45 ( .A(n3), .Y(n108) );
  INVX4M U46 ( .A(n3), .Y(n42) );
  OAI2BB1X2M U47 ( .A0N(N124), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[15]) );
  OAI2BB1X2M U48 ( .A0N(N123), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[14]) );
  OAI2BB1X2M U49 ( .A0N(N122), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[13]) );
  OAI2BB1X2M U50 ( .A0N(N121), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[12]) );
  OAI2BB1X2M U51 ( .A0N(N119), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[10]) );
  OAI2BB1X2M U52 ( .A0N(N120), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[11]) );
  OAI2BB1X2M U53 ( .A0N(N118), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[9]) );
  CLKBUFX6M U54 ( .A(n47), .Y(n111) );
  OAI2BB1X2M U55 ( .A0N(n163), .A1N(n105), .B0(n101), .Y(n47) );
  INVX2M U56 ( .A(n107), .Y(n163) );
  BUFX4M U57 ( .A(n46), .Y(n109) );
  BUFX4M U58 ( .A(n46), .Y(n110) );
  NOR2BX8M U59 ( .AN(n29), .B(n149), .Y(n31) );
  CLKAND2X6M U60 ( .A(n106), .B(n105), .Y(n50) );
  INVX4M U61 ( .A(n91), .Y(n161) );
  INVX2M U62 ( .A(n100), .Y(n160) );
  CLKBUFX6M U63 ( .A(n37), .Y(n28) );
  NOR2BX2M U64 ( .AN(n106), .B(n160), .Y(n37) );
  AND4X1M U65 ( .A(N159), .B(n99), .C(n9), .D(n159), .Y(n90) );
  AOI31X2M U66 ( .A0(n51), .A1(n52), .A2(n53), .B0(n149), .Y(ALU_OUT_Comb[6])
         );
  AOI22X1M U67 ( .A0(N106), .A1(n50), .B0(N97), .B1(n28), .Y(n51) );
  AOI221X2M U68 ( .A0(n161), .A1(A[7]), .B0(n108), .B1(n151), .C0(n54), .Y(n53) );
  AOI222X2M U69 ( .A0(N115), .A1(n29), .B0(n30), .B1(A[6]), .C0(N131), .C1(n5), 
        .Y(n52) );
  INVX4M U70 ( .A(ALU_FUN[0]), .Y(n159) );
  INVX4M U71 ( .A(ALU_FUN[1]), .Y(n162) );
  NOR2X4M U72 ( .A(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n106) );
  NAND2X2M U73 ( .A(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n107) );
  NAND3X2M U74 ( .A(n106), .B(ALU_FUN[0]), .C(n9), .Y(n101) );
  AND2X2M U75 ( .A(ALU_FUN[2]), .B(n162), .Y(n99) );
  AND3X2M U76 ( .A(n106), .B(n159), .C(n9), .Y(n46) );
  NAND3X4M U78 ( .A(n163), .B(n159), .C(n9), .Y(n36) );
  NAND2X4M U79 ( .A(EN), .B(n148), .Y(n32) );
  NAND3X2M U80 ( .A(n9), .B(ALU_FUN[0]), .C(n99), .Y(n91) );
  CLKBUFX6M U81 ( .A(n35), .Y(n29) );
  NOR3X2M U82 ( .A(n160), .B(ALU_FUN[2]), .C(n162), .Y(n35) );
  INVX4M U83 ( .A(n14), .Y(n154) );
  INVX2M U84 ( .A(n17), .Y(n153) );
  INVX2M U85 ( .A(n20), .Y(n152) );
  INVX2M U86 ( .A(A[6]), .Y(n151) );
  INVX6M U87 ( .A(EN), .Y(n149) );
  INVX6M U88 ( .A(n114), .Y(n112) );
  INVX4M U89 ( .A(n114), .Y(n113) );
  AOI22X1M U90 ( .A0(N100), .A1(n50), .B0(N91), .B1(n28), .Y(n93) );
  AOI211X2M U91 ( .A0(n108), .A1(n155), .B0(n96), .C0(n97), .Y(n95) );
  AOI222X2M U92 ( .A0(N92), .A1(n28), .B0(N110), .B1(n29), .C0(N101), .C1(n50), 
        .Y(n81) );
  AOI211X2M U93 ( .A0(n17), .A1(n161), .B0(n84), .C0(n85), .Y(n83) );
  AOI31X2M U94 ( .A0(n75), .A1(n76), .A2(n77), .B0(n149), .Y(ALU_OUT_Comb[2])
         );
  AOI22X1M U95 ( .A0(N102), .A1(n50), .B0(N93), .B1(n28), .Y(n75) );
  AOI221X2M U96 ( .A0(n20), .A1(n161), .B0(n108), .B1(n153), .C0(n78), .Y(n77)
         );
  AOI222X2M U97 ( .A0(N111), .A1(n29), .B0(n17), .B1(n30), .C0(N127), .C1(n5), 
        .Y(n76) );
  INVX4M U98 ( .A(n24), .Y(n25) );
  INVX4M U99 ( .A(n12), .Y(n13) );
  INVX4M U100 ( .A(n21), .Y(n22) );
  INVX4M U101 ( .A(n15), .Y(n16) );
  AOI31X2M U102 ( .A0(n69), .A1(n70), .A2(n71), .B0(n149), .Y(ALU_OUT_Comb[3])
         );
  AOI22X1M U103 ( .A0(N103), .A1(n50), .B0(N94), .B1(n28), .Y(n69) );
  AOI221X2M U104 ( .A0(n23), .A1(n161), .B0(n108), .B1(n152), .C0(n72), .Y(n71) );
  AOI222X2M U105 ( .A0(N112), .A1(n29), .B0(n20), .B1(n41), .C0(N128), .C1(n5), 
        .Y(n70) );
  INVX4M U106 ( .A(n18), .Y(n19) );
  AOI31X2M U107 ( .A0(n63), .A1(n64), .A2(n65), .B0(n149), .Y(ALU_OUT_Comb[4])
         );
  AOI22X1M U108 ( .A0(N104), .A1(n50), .B0(N95), .B1(n28), .Y(n63) );
  AOI221X2M U109 ( .A0(n161), .A1(n26), .B0(n108), .B1(n21), .C0(n66), .Y(n65)
         );
  AOI222X2M U110 ( .A0(N113), .A1(n29), .B0(n23), .B1(n30), .C0(N129), .C1(n5), 
        .Y(n64) );
  INVXLM U111 ( .A(n126), .Y(n146) );
  INVX2M U112 ( .A(n140), .Y(N158) );
  INVX2M U113 ( .A(n10), .Y(n144) );
  INVX4M U114 ( .A(n15), .Y(n17) );
  INVX4M U115 ( .A(n12), .Y(n14) );
  AOI31X2M U116 ( .A0(n57), .A1(n58), .A2(n59), .B0(n149), .Y(ALU_OUT_Comb[5])
         );
  AOI22X1M U117 ( .A0(N105), .A1(n50), .B0(N96), .B1(n28), .Y(n57) );
  AOI221X2M U118 ( .A0(n161), .A1(A[6]), .B0(n108), .B1(n24), .C0(n60), .Y(n59) );
  AOI222X2M U119 ( .A0(N114), .A1(n29), .B0(n26), .B1(n41), .C0(N130), .C1(n5), 
        .Y(n58) );
  AOI31X2M U120 ( .A0(n38), .A1(n39), .A2(n40), .B0(n149), .Y(ALU_OUT_Comb[7])
         );
  AOI22X1M U121 ( .A0(N107), .A1(n50), .B0(N98), .B1(n28), .Y(n38) );
  AOI221X2M U122 ( .A0(n108), .A1(n150), .B0(n41), .B1(A[7]), .C0(n43), .Y(n40) );
  AOI22X1M U123 ( .A0(N132), .A1(n5), .B0(N116), .B1(n29), .Y(n39) );
  AOI21X2M U124 ( .A0(n33), .A1(n34), .B0(n149), .Y(ALU_OUT_Comb[8]) );
  AOI21X2M U125 ( .A0(N99), .A1(n28), .B0(n148), .Y(n33) );
  AOI2BB2X2M U126 ( .B0(N117), .B1(n29), .A0N(n150), .A1N(n36), .Y(n34) );
  INVX4M U127 ( .A(n18), .Y(n20) );
  INVX4M U128 ( .A(n21), .Y(n23) );
  CLKBUFX6M U129 ( .A(ALU_FUN[3]), .Y(n9) );
  INVX4M U130 ( .A(n24), .Y(n26) );
  OAI222X1M U131 ( .A0(n55), .A1(n144), .B0(n10), .B1(n56), .C0(n36), .C1(n24), 
        .Y(n54) );
  AOI221X2M U132 ( .A0(A[6]), .A1(n109), .B0(n111), .B1(n151), .C0(n42), .Y(
        n56) );
  AOI221X2M U133 ( .A0(n110), .A1(n151), .B0(A[6]), .B1(n48), .C0(n41), .Y(n55) );
  INVX2M U134 ( .A(n92), .Y(n148) );
  AOI211X2M U135 ( .A0(N108), .A1(n50), .B0(n108), .C0(n111), .Y(n92) );
  INVX2M U136 ( .A(n11), .Y(n155) );
  INVX2M U137 ( .A(RST), .Y(n114) );
  INVX2M U138 ( .A(A[1]), .Y(n12) );
  INVX2M U139 ( .A(A[2]), .Y(n15) );
  INVX2M U140 ( .A(A[3]), .Y(n18) );
  INVXLM U141 ( .A(n115), .Y(n145) );
  AOI221X2M U142 ( .A0(n11), .A1(n109), .B0(n111), .B1(n155), .C0(n42), .Y(
        n102) );
  AOI31X2M U143 ( .A0(N157), .A1(n9), .A2(n104), .B0(n90), .Y(n103) );
  NOR3X2M U144 ( .A(n162), .B(ALU_FUN[2]), .C(ALU_FUN[0]), .Y(n104) );
  AOI221X2M U145 ( .A0(n14), .A1(n109), .B0(n111), .B1(n154), .C0(n42), .Y(n87) );
  AOI31X2M U146 ( .A0(N158), .A1(n9), .A2(n89), .B0(n90), .Y(n88) );
  NOR3X2M U147 ( .A(n159), .B(ALU_FUN[2]), .C(n162), .Y(n89) );
  OAI222X1M U148 ( .A0(n44), .A1(n156), .B0(B[7]), .B1(n45), .C0(n36), .C1(
        n151), .Y(n43) );
  AOI221X2M U149 ( .A0(n110), .A1(A[7]), .B0(n111), .B1(n150), .C0(n108), .Y(
        n45) );
  AOI221X2M U150 ( .A0(n110), .A1(n150), .B0(A[7]), .B1(n48), .C0(n30), .Y(n44) );
  OAI222X1M U151 ( .A0(n67), .A1(n158), .B0(B[4]), .B1(n68), .C0(n36), .C1(
        n152), .Y(n66) );
  AOI221X2M U152 ( .A0(n23), .A1(n109), .B0(n111), .B1(n21), .C0(n42), .Y(n68)
         );
  AOI221X2M U153 ( .A0(n110), .A1(n21), .B0(n23), .B1(n48), .C0(n41), .Y(n67)
         );
  OAI222X1M U154 ( .A0(n61), .A1(n157), .B0(B[5]), .B1(n62), .C0(n36), .C1(n21), .Y(n60) );
  AOI221X2M U155 ( .A0(n26), .A1(n109), .B0(n111), .B1(n24), .C0(n42), .Y(n62)
         );
  AOI221X2M U156 ( .A0(n110), .A1(n24), .B0(n26), .B1(n48), .C0(n30), .Y(n61)
         );
  OAI222X1M U157 ( .A0(n79), .A1(n142), .B0(B[2]), .B1(n80), .C0(n36), .C1(
        n154), .Y(n78) );
  AOI221X2M U158 ( .A0(n17), .A1(n109), .B0(n111), .B1(n153), .C0(n42), .Y(n80) );
  AOI221X2M U159 ( .A0(n110), .A1(n153), .B0(n17), .B1(n48), .C0(n41), .Y(n79)
         );
  OAI222X1M U160 ( .A0(n73), .A1(n143), .B0(B[3]), .B1(n74), .C0(n36), .C1(
        n153), .Y(n72) );
  AOI221X2M U161 ( .A0(n20), .A1(n109), .B0(n111), .B1(n152), .C0(n42), .Y(n74) );
  AOI221X2M U162 ( .A0(n110), .A1(n152), .B0(n20), .B1(n48), .C0(n30), .Y(n73)
         );
  OAI2B2X1M U163 ( .A1N(B[1]), .A0(n86), .B0(n36), .B1(n155), .Y(n85) );
  AOI221X2M U164 ( .A0(n110), .A1(n154), .B0(n14), .B1(n48), .C0(n30), .Y(n86)
         );
  OAI2B2X1M U165 ( .A1N(B[0]), .A0(n98), .B0(n91), .B1(n154), .Y(n97) );
  AOI221X2M U166 ( .A0(n109), .A1(n155), .B0(n11), .B1(n48), .C0(n41), .Y(n98)
         );
  NAND2BX1M U167 ( .AN(B[4]), .B(n23), .Y(n130) );
  NAND2BX1M U168 ( .AN(n23), .B(B[4]), .Y(n119) );
  CLKNAND2X2M U169 ( .A(n130), .B(n119), .Y(n132) );
  CLKNAND2X2M U170 ( .A(n17), .B(n142), .Y(n129) );
  NAND2BX1M U171 ( .AN(n118), .B(n129), .Y(n124) );
  AOI21X1M U172 ( .A0(n115), .A1(n154), .B0(B[1]), .Y(n116) );
  CLKNAND2X2M U173 ( .A(n20), .B(n143), .Y(n128) );
  NAND2BX1M U174 ( .AN(n26), .B(B[5]), .Y(n135) );
  OAI211X1M U175 ( .A0(n132), .A1(n120), .B0(n119), .C0(n135), .Y(n121) );
  NAND2BX1M U176 ( .AN(B[5]), .B(n26), .Y(n131) );
  AOI32X1M U177 ( .A0(n121), .A1(n131), .A2(n134), .B0(n10), .B1(n27), .Y(n122) );
  CLKNAND2X2M U178 ( .A(n11), .B(n141), .Y(n125) );
  OA21X1M U179 ( .A0(n125), .A1(n154), .B0(B[1]), .Y(n123) );
  AOI31X1M U180 ( .A0(n146), .A1(n129), .A2(n128), .B0(n127), .Y(n133) );
  OAI2B11X1M U181 ( .A1N(n133), .A0(n132), .B0(n131), .C0(n130), .Y(n136) );
  AOI32X1M U182 ( .A0(n136), .A1(n135), .A2(n134), .B0(A[6]), .B1(n144), .Y(
        n139) );
  AOI2B1X1M U183 ( .A1N(n139), .A0(n138), .B0(n137), .Y(n140) );
  NOR2X1M U184 ( .A(N159), .B(N158), .Y(N157) );
endmodule


module CLK_GATE ( CLK_EN, CLK, GATED_CLK );
  input CLK_EN, CLK;
  output GATED_CLK;


  TLATNCAX12M U0_TLATNCAX12M ( .E(CLK_EN), .CK(CLK), .ECK(GATED_CLK) );
endmodule


module RST_SYNC_0 ( CLK, RST, SYNC_RST );
  input CLK, RST;
  output SYNC_RST;
  wire   \sync_reg[0] ;

  DFFRQX2M \sync_reg_reg[1]  ( .D(\sync_reg[0] ), .CK(CLK), .RN(RST), .Q(
        SYNC_RST) );
  DFFRQX2M \sync_reg_reg[0]  ( .D(1'b1), .CK(CLK), .RN(RST), .Q(\sync_reg[0] )
         );
endmodule


module RST_SYNC_1 ( CLK, RST, SYNC_RST );
  input CLK, RST;
  output SYNC_RST;
  wire   \sync_reg[0] ;

  DFFRQX2M \sync_reg_reg[1]  ( .D(\sync_reg[0] ), .CK(CLK), .RN(RST), .Q(
        SYNC_RST) );
  DFFRQX2M \sync_reg_reg[0]  ( .D(1'b1), .CK(CLK), .RN(RST), .Q(\sync_reg[0] )
         );
endmodule


module FIFO_MEM_CNTRL ( Wdata, Winc, Rinc, W_CLK, W_RST, Wfull, W_addr, R_addr, 
        Rdata );
  input [7:0] Wdata;
  input [3:0] W_addr;
  input [3:0] R_addr;
  output [7:0] Rdata;
  input Winc, Rinc, W_CLK, W_RST, Wfull;
  wire   N10, N11, N12, \FIFO_MEM[0][7] , \FIFO_MEM[0][6] , \FIFO_MEM[0][5] ,
         \FIFO_MEM[0][4] , \FIFO_MEM[0][3] , \FIFO_MEM[0][2] ,
         \FIFO_MEM[0][1] , \FIFO_MEM[0][0] , \FIFO_MEM[1][7] ,
         \FIFO_MEM[1][6] , \FIFO_MEM[1][5] , \FIFO_MEM[1][4] ,
         \FIFO_MEM[1][3] , \FIFO_MEM[1][2] , \FIFO_MEM[1][1] ,
         \FIFO_MEM[1][0] , \FIFO_MEM[2][7] , \FIFO_MEM[2][6] ,
         \FIFO_MEM[2][5] , \FIFO_MEM[2][4] , \FIFO_MEM[2][3] ,
         \FIFO_MEM[2][2] , \FIFO_MEM[2][1] , \FIFO_MEM[2][0] ,
         \FIFO_MEM[3][7] , \FIFO_MEM[3][6] , \FIFO_MEM[3][5] ,
         \FIFO_MEM[3][4] , \FIFO_MEM[3][3] , \FIFO_MEM[3][2] ,
         \FIFO_MEM[3][1] , \FIFO_MEM[3][0] , \FIFO_MEM[4][7] ,
         \FIFO_MEM[4][6] , \FIFO_MEM[4][5] , \FIFO_MEM[4][4] ,
         \FIFO_MEM[4][3] , \FIFO_MEM[4][2] , \FIFO_MEM[4][1] ,
         \FIFO_MEM[4][0] , \FIFO_MEM[5][7] , \FIFO_MEM[5][6] ,
         \FIFO_MEM[5][5] , \FIFO_MEM[5][4] , \FIFO_MEM[5][3] ,
         \FIFO_MEM[5][2] , \FIFO_MEM[5][1] , \FIFO_MEM[5][0] ,
         \FIFO_MEM[6][7] , \FIFO_MEM[6][6] , \FIFO_MEM[6][5] ,
         \FIFO_MEM[6][4] , \FIFO_MEM[6][3] , \FIFO_MEM[6][2] ,
         \FIFO_MEM[6][1] , \FIFO_MEM[6][0] , \FIFO_MEM[7][7] ,
         \FIFO_MEM[7][6] , \FIFO_MEM[7][5] , \FIFO_MEM[7][4] ,
         \FIFO_MEM[7][3] , \FIFO_MEM[7][2] , \FIFO_MEM[7][1] ,
         \FIFO_MEM[7][0] , n12, n16, n18, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70,
         n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n13, n14, n15,
         n17, n19, n20, n21, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108,
         n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119,
         n120, n121, n122, n123, n124, n125, n126, n127, n128, n129, n130,
         n131, n132;
  assign N10 = R_addr[0];
  assign N11 = R_addr[1];
  assign N12 = R_addr[2];

  DFFRQX2M \FIFO_MEM_reg[1][7]  ( .D(n78), .CK(W_CLK), .RN(n115), .Q(
        \FIFO_MEM[1][7] ) );
  DFFRQX2M \FIFO_MEM_reg[1][6]  ( .D(n77), .CK(W_CLK), .RN(n115), .Q(
        \FIFO_MEM[1][6] ) );
  DFFRQX2M \FIFO_MEM_reg[1][5]  ( .D(n76), .CK(W_CLK), .RN(n115), .Q(
        \FIFO_MEM[1][5] ) );
  DFFRQX2M \FIFO_MEM_reg[1][4]  ( .D(n75), .CK(W_CLK), .RN(n115), .Q(
        \FIFO_MEM[1][4] ) );
  DFFRQX2M \FIFO_MEM_reg[1][3]  ( .D(n74), .CK(W_CLK), .RN(n116), .Q(
        \FIFO_MEM[1][3] ) );
  DFFRQX2M \FIFO_MEM_reg[1][2]  ( .D(n73), .CK(W_CLK), .RN(n116), .Q(
        \FIFO_MEM[1][2] ) );
  DFFRQX2M \FIFO_MEM_reg[1][1]  ( .D(n72), .CK(W_CLK), .RN(n116), .Q(
        \FIFO_MEM[1][1] ) );
  DFFRQX2M \FIFO_MEM_reg[1][0]  ( .D(n71), .CK(W_CLK), .RN(n116), .Q(
        \FIFO_MEM[1][0] ) );
  DFFRQX2M \FIFO_MEM_reg[5][7]  ( .D(n46), .CK(W_CLK), .RN(n118), .Q(
        \FIFO_MEM[5][7] ) );
  DFFRQX2M \FIFO_MEM_reg[5][6]  ( .D(n45), .CK(W_CLK), .RN(n118), .Q(
        \FIFO_MEM[5][6] ) );
  DFFRQX2M \FIFO_MEM_reg[5][5]  ( .D(n44), .CK(W_CLK), .RN(n118), .Q(
        \FIFO_MEM[5][5] ) );
  DFFRQX2M \FIFO_MEM_reg[5][4]  ( .D(n43), .CK(W_CLK), .RN(n118), .Q(
        \FIFO_MEM[5][4] ) );
  DFFRQX2M \FIFO_MEM_reg[5][3]  ( .D(n42), .CK(W_CLK), .RN(n118), .Q(
        \FIFO_MEM[5][3] ) );
  DFFRQX2M \FIFO_MEM_reg[5][2]  ( .D(n41), .CK(W_CLK), .RN(n118), .Q(
        \FIFO_MEM[5][2] ) );
  DFFRQX2M \FIFO_MEM_reg[5][1]  ( .D(n40), .CK(W_CLK), .RN(n118), .Q(
        \FIFO_MEM[5][1] ) );
  DFFRQX2M \FIFO_MEM_reg[5][0]  ( .D(n39), .CK(W_CLK), .RN(n118), .Q(
        \FIFO_MEM[5][0] ) );
  DFFRQX2M \FIFO_MEM_reg[3][7]  ( .D(n62), .CK(W_CLK), .RN(n117), .Q(
        \FIFO_MEM[3][7] ) );
  DFFRQX2M \FIFO_MEM_reg[3][6]  ( .D(n61), .CK(W_CLK), .RN(n117), .Q(
        \FIFO_MEM[3][6] ) );
  DFFRQX2M \FIFO_MEM_reg[3][5]  ( .D(n60), .CK(W_CLK), .RN(n117), .Q(
        \FIFO_MEM[3][5] ) );
  DFFRQX2M \FIFO_MEM_reg[3][4]  ( .D(n59), .CK(W_CLK), .RN(n117), .Q(
        \FIFO_MEM[3][4] ) );
  DFFRQX2M \FIFO_MEM_reg[3][3]  ( .D(n58), .CK(W_CLK), .RN(n117), .Q(
        \FIFO_MEM[3][3] ) );
  DFFRQX2M \FIFO_MEM_reg[3][2]  ( .D(n57), .CK(W_CLK), .RN(n117), .Q(
        \FIFO_MEM[3][2] ) );
  DFFRQX2M \FIFO_MEM_reg[3][1]  ( .D(n56), .CK(W_CLK), .RN(n117), .Q(
        \FIFO_MEM[3][1] ) );
  DFFRQX2M \FIFO_MEM_reg[3][0]  ( .D(n55), .CK(W_CLK), .RN(n117), .Q(
        \FIFO_MEM[3][0] ) );
  DFFRQX2M \FIFO_MEM_reg[7][7]  ( .D(n30), .CK(W_CLK), .RN(n119), .Q(
        \FIFO_MEM[7][7] ) );
  DFFRQX2M \FIFO_MEM_reg[7][6]  ( .D(n29), .CK(W_CLK), .RN(n119), .Q(
        \FIFO_MEM[7][6] ) );
  DFFRQX2M \FIFO_MEM_reg[7][5]  ( .D(n28), .CK(W_CLK), .RN(n119), .Q(
        \FIFO_MEM[7][5] ) );
  DFFRQX2M \FIFO_MEM_reg[7][4]  ( .D(n27), .CK(W_CLK), .RN(n119), .Q(
        \FIFO_MEM[7][4] ) );
  DFFRQX2M \FIFO_MEM_reg[7][3]  ( .D(n26), .CK(W_CLK), .RN(n120), .Q(
        \FIFO_MEM[7][3] ) );
  DFFRQX2M \FIFO_MEM_reg[7][2]  ( .D(n25), .CK(W_CLK), .RN(n120), .Q(
        \FIFO_MEM[7][2] ) );
  DFFRQX2M \FIFO_MEM_reg[7][1]  ( .D(n24), .CK(W_CLK), .RN(n120), .Q(
        \FIFO_MEM[7][1] ) );
  DFFRQX2M \FIFO_MEM_reg[7][0]  ( .D(n23), .CK(W_CLK), .RN(n120), .Q(
        \FIFO_MEM[7][0] ) );
  DFFRQX2M \FIFO_MEM_reg[2][7]  ( .D(n70), .CK(W_CLK), .RN(n116), .Q(
        \FIFO_MEM[2][7] ) );
  DFFRQX2M \FIFO_MEM_reg[2][6]  ( .D(n69), .CK(W_CLK), .RN(n116), .Q(
        \FIFO_MEM[2][6] ) );
  DFFRQX2M \FIFO_MEM_reg[2][5]  ( .D(n68), .CK(W_CLK), .RN(n116), .Q(
        \FIFO_MEM[2][5] ) );
  DFFRQX2M \FIFO_MEM_reg[2][4]  ( .D(n67), .CK(W_CLK), .RN(n116), .Q(
        \FIFO_MEM[2][4] ) );
  DFFRQX2M \FIFO_MEM_reg[2][3]  ( .D(n66), .CK(W_CLK), .RN(n116), .Q(
        \FIFO_MEM[2][3] ) );
  DFFRQX2M \FIFO_MEM_reg[2][2]  ( .D(n65), .CK(W_CLK), .RN(n116), .Q(
        \FIFO_MEM[2][2] ) );
  DFFRQX2M \FIFO_MEM_reg[2][1]  ( .D(n64), .CK(W_CLK), .RN(n116), .Q(
        \FIFO_MEM[2][1] ) );
  DFFRQX2M \FIFO_MEM_reg[2][0]  ( .D(n63), .CK(W_CLK), .RN(n116), .Q(
        \FIFO_MEM[2][0] ) );
  DFFRQX2M \FIFO_MEM_reg[6][7]  ( .D(n38), .CK(W_CLK), .RN(n119), .Q(
        \FIFO_MEM[6][7] ) );
  DFFRQX2M \FIFO_MEM_reg[6][6]  ( .D(n37), .CK(W_CLK), .RN(n119), .Q(
        \FIFO_MEM[6][6] ) );
  DFFRQX2M \FIFO_MEM_reg[6][5]  ( .D(n36), .CK(W_CLK), .RN(n119), .Q(
        \FIFO_MEM[6][5] ) );
  DFFRQX2M \FIFO_MEM_reg[6][4]  ( .D(n35), .CK(W_CLK), .RN(n119), .Q(
        \FIFO_MEM[6][4] ) );
  DFFRQX2M \FIFO_MEM_reg[6][3]  ( .D(n34), .CK(W_CLK), .RN(n119), .Q(
        \FIFO_MEM[6][3] ) );
  DFFRQX2M \FIFO_MEM_reg[6][2]  ( .D(n33), .CK(W_CLK), .RN(n119), .Q(
        \FIFO_MEM[6][2] ) );
  DFFRQX2M \FIFO_MEM_reg[6][1]  ( .D(n32), .CK(W_CLK), .RN(n119), .Q(
        \FIFO_MEM[6][1] ) );
  DFFRQX2M \FIFO_MEM_reg[6][0]  ( .D(n31), .CK(W_CLK), .RN(n119), .Q(
        \FIFO_MEM[6][0] ) );
  DFFRQX2M \FIFO_MEM_reg[0][7]  ( .D(n86), .CK(W_CLK), .RN(n115), .Q(
        \FIFO_MEM[0][7] ) );
  DFFRQX2M \FIFO_MEM_reg[0][6]  ( .D(n85), .CK(W_CLK), .RN(n115), .Q(
        \FIFO_MEM[0][6] ) );
  DFFRQX2M \FIFO_MEM_reg[0][5]  ( .D(n84), .CK(W_CLK), .RN(n115), .Q(
        \FIFO_MEM[0][5] ) );
  DFFRQX2M \FIFO_MEM_reg[0][4]  ( .D(n83), .CK(W_CLK), .RN(n115), .Q(
        \FIFO_MEM[0][4] ) );
  DFFRQX2M \FIFO_MEM_reg[0][3]  ( .D(n82), .CK(W_CLK), .RN(n115), .Q(
        \FIFO_MEM[0][3] ) );
  DFFRQX2M \FIFO_MEM_reg[0][2]  ( .D(n81), .CK(W_CLK), .RN(n115), .Q(
        \FIFO_MEM[0][2] ) );
  DFFRQX2M \FIFO_MEM_reg[0][1]  ( .D(n80), .CK(W_CLK), .RN(n115), .Q(
        \FIFO_MEM[0][1] ) );
  DFFRQX2M \FIFO_MEM_reg[0][0]  ( .D(n79), .CK(W_CLK), .RN(n115), .Q(
        \FIFO_MEM[0][0] ) );
  DFFRQX2M \FIFO_MEM_reg[4][7]  ( .D(n54), .CK(W_CLK), .RN(n117), .Q(
        \FIFO_MEM[4][7] ) );
  DFFRQX2M \FIFO_MEM_reg[4][6]  ( .D(n53), .CK(W_CLK), .RN(n117), .Q(
        \FIFO_MEM[4][6] ) );
  DFFRQX2M \FIFO_MEM_reg[4][5]  ( .D(n52), .CK(W_CLK), .RN(n117), .Q(
        \FIFO_MEM[4][5] ) );
  DFFRQX2M \FIFO_MEM_reg[4][4]  ( .D(n51), .CK(W_CLK), .RN(n117), .Q(
        \FIFO_MEM[4][4] ) );
  DFFRQX2M \FIFO_MEM_reg[4][3]  ( .D(n50), .CK(W_CLK), .RN(n118), .Q(
        \FIFO_MEM[4][3] ) );
  DFFRQX2M \FIFO_MEM_reg[4][2]  ( .D(n49), .CK(W_CLK), .RN(n118), .Q(
        \FIFO_MEM[4][2] ) );
  DFFRQX2M \FIFO_MEM_reg[4][1]  ( .D(n48), .CK(W_CLK), .RN(n118), .Q(
        \FIFO_MEM[4][1] ) );
  DFFRQX2M \FIFO_MEM_reg[4][0]  ( .D(n47), .CK(W_CLK), .RN(n118), .Q(
        \FIFO_MEM[4][0] ) );
  NOR2X1M U2 ( .A(Wfull), .B(W_addr[3]), .Y(n22) );
  AND2X2M U3 ( .A(W_addr[2]), .B(n16), .Y(n12) );
  NOR2BX4M U4 ( .AN(n16), .B(W_addr[2]), .Y(n18) );
  INVX2M U5 ( .A(W_addr[0]), .Y(n123) );
  INVX2M U6 ( .A(W_addr[1]), .Y(n124) );
  BUFX6M U7 ( .A(n122), .Y(n119) );
  BUFX6M U8 ( .A(n121), .Y(n118) );
  BUFX6M U9 ( .A(n121), .Y(n117) );
  BUFX6M U10 ( .A(n122), .Y(n116) );
  BUFX6M U11 ( .A(W_RST), .Y(n115) );
  BUFX2M U12 ( .A(n121), .Y(n120) );
  BUFX2M U13 ( .A(n122), .Y(n121) );
  INVX4M U14 ( .A(n1), .Y(n108) );
  INVX4M U15 ( .A(n1), .Y(n107) );
  INVX4M U16 ( .A(n2), .Y(n100) );
  INVX4M U17 ( .A(n2), .Y(n99) );
  BUFX2M U18 ( .A(W_RST), .Y(n122) );
  AND3X2M U19 ( .A(n123), .B(n124), .C(n12), .Y(n1) );
  INVX4M U20 ( .A(n4), .Y(n110) );
  INVX4M U21 ( .A(n4), .Y(n109) );
  INVX4M U22 ( .A(n7), .Y(n106) );
  INVX4M U23 ( .A(n7), .Y(n105) );
  INVX4M U24 ( .A(n5), .Y(n112) );
  INVX4M U25 ( .A(n5), .Y(n111) );
  INVX4M U26 ( .A(n8), .Y(n104) );
  INVX4M U27 ( .A(n8), .Y(n103) );
  INVX4M U28 ( .A(n3), .Y(n102) );
  INVX4M U29 ( .A(n3), .Y(n101) );
  INVX4M U30 ( .A(n6), .Y(n114) );
  INVX4M U31 ( .A(n6), .Y(n113) );
  AND3X2M U32 ( .A(n123), .B(n124), .C(n18), .Y(n2) );
  INVX6M U33 ( .A(n95), .Y(n94) );
  INVX6M U34 ( .A(n95), .Y(n93) );
  INVX4M U35 ( .A(n98), .Y(n97) );
  INVX4M U36 ( .A(n98), .Y(n96) );
  INVX4M U37 ( .A(Wdata[0]), .Y(n132) );
  INVX4M U38 ( .A(Wdata[1]), .Y(n131) );
  INVX4M U39 ( .A(Wdata[2]), .Y(n130) );
  INVX4M U40 ( .A(Wdata[3]), .Y(n129) );
  INVX4M U41 ( .A(Wdata[4]), .Y(n128) );
  INVX4M U42 ( .A(Wdata[5]), .Y(n127) );
  INVX4M U43 ( .A(Wdata[6]), .Y(n126) );
  INVX4M U44 ( .A(Wdata[7]), .Y(n125) );
  AND3X2M U45 ( .A(W_addr[0]), .B(n124), .C(n18), .Y(n3) );
  OAI2BB2X1M U46 ( .B0(n132), .B1(n112), .A0N(\FIFO_MEM[6][0] ), .A1N(n112), 
        .Y(n31) );
  OAI2BB2X1M U47 ( .B0(n131), .B1(n111), .A0N(\FIFO_MEM[6][1] ), .A1N(n111), 
        .Y(n32) );
  OAI2BB2X1M U48 ( .B0(n130), .B1(n112), .A0N(\FIFO_MEM[6][2] ), .A1N(n112), 
        .Y(n33) );
  OAI2BB2X1M U49 ( .B0(n129), .B1(n111), .A0N(\FIFO_MEM[6][3] ), .A1N(n111), 
        .Y(n34) );
  OAI2BB2X1M U50 ( .B0(n128), .B1(n112), .A0N(\FIFO_MEM[6][4] ), .A1N(n112), 
        .Y(n35) );
  OAI2BB2X1M U51 ( .B0(n127), .B1(n111), .A0N(\FIFO_MEM[6][5] ), .A1N(n111), 
        .Y(n36) );
  OAI2BB2X1M U52 ( .B0(n126), .B1(n112), .A0N(\FIFO_MEM[6][6] ), .A1N(n112), 
        .Y(n37) );
  OAI2BB2X1M U53 ( .B0(n125), .B1(n111), .A0N(\FIFO_MEM[6][7] ), .A1N(n111), 
        .Y(n38) );
  OAI2BB2X1M U54 ( .B0(n132), .B1(n110), .A0N(\FIFO_MEM[5][0] ), .A1N(n110), 
        .Y(n39) );
  OAI2BB2X1M U55 ( .B0(n131), .B1(n109), .A0N(\FIFO_MEM[5][1] ), .A1N(n109), 
        .Y(n40) );
  OAI2BB2X1M U56 ( .B0(n130), .B1(n110), .A0N(\FIFO_MEM[5][2] ), .A1N(n110), 
        .Y(n41) );
  OAI2BB2X1M U57 ( .B0(n129), .B1(n109), .A0N(\FIFO_MEM[5][3] ), .A1N(n109), 
        .Y(n42) );
  OAI2BB2X1M U58 ( .B0(n128), .B1(n110), .A0N(\FIFO_MEM[5][4] ), .A1N(n110), 
        .Y(n43) );
  OAI2BB2X1M U59 ( .B0(n127), .B1(n109), .A0N(\FIFO_MEM[5][5] ), .A1N(n109), 
        .Y(n44) );
  OAI2BB2X1M U60 ( .B0(n126), .B1(n110), .A0N(\FIFO_MEM[5][6] ), .A1N(n110), 
        .Y(n45) );
  OAI2BB2X1M U61 ( .B0(n125), .B1(n109), .A0N(\FIFO_MEM[5][7] ), .A1N(n109), 
        .Y(n46) );
  OAI2BB2X1M U62 ( .B0(n132), .B1(n108), .A0N(\FIFO_MEM[4][0] ), .A1N(n108), 
        .Y(n47) );
  OAI2BB2X1M U63 ( .B0(n131), .B1(n107), .A0N(\FIFO_MEM[4][1] ), .A1N(n107), 
        .Y(n48) );
  OAI2BB2X1M U64 ( .B0(n130), .B1(n108), .A0N(\FIFO_MEM[4][2] ), .A1N(n108), 
        .Y(n49) );
  OAI2BB2X1M U65 ( .B0(n129), .B1(n107), .A0N(\FIFO_MEM[4][3] ), .A1N(n107), 
        .Y(n50) );
  OAI2BB2X1M U66 ( .B0(n128), .B1(n108), .A0N(\FIFO_MEM[4][4] ), .A1N(n108), 
        .Y(n51) );
  OAI2BB2X1M U67 ( .B0(n127), .B1(n107), .A0N(\FIFO_MEM[4][5] ), .A1N(n107), 
        .Y(n52) );
  OAI2BB2X1M U68 ( .B0(n126), .B1(n108), .A0N(\FIFO_MEM[4][6] ), .A1N(n108), 
        .Y(n53) );
  OAI2BB2X1M U69 ( .B0(n125), .B1(n107), .A0N(\FIFO_MEM[4][7] ), .A1N(n107), 
        .Y(n54) );
  OAI2BB2X1M U70 ( .B0(n132), .B1(n106), .A0N(\FIFO_MEM[3][0] ), .A1N(n106), 
        .Y(n55) );
  OAI2BB2X1M U71 ( .B0(n131), .B1(n105), .A0N(\FIFO_MEM[3][1] ), .A1N(n105), 
        .Y(n56) );
  OAI2BB2X1M U72 ( .B0(n130), .B1(n106), .A0N(\FIFO_MEM[3][2] ), .A1N(n106), 
        .Y(n57) );
  OAI2BB2X1M U73 ( .B0(n129), .B1(n105), .A0N(\FIFO_MEM[3][3] ), .A1N(n105), 
        .Y(n58) );
  OAI2BB2X1M U74 ( .B0(n128), .B1(n106), .A0N(\FIFO_MEM[3][4] ), .A1N(n106), 
        .Y(n59) );
  OAI2BB2X1M U75 ( .B0(n127), .B1(n105), .A0N(\FIFO_MEM[3][5] ), .A1N(n105), 
        .Y(n60) );
  OAI2BB2X1M U76 ( .B0(n126), .B1(n106), .A0N(\FIFO_MEM[3][6] ), .A1N(n106), 
        .Y(n61) );
  OAI2BB2X1M U77 ( .B0(n125), .B1(n105), .A0N(\FIFO_MEM[3][7] ), .A1N(n105), 
        .Y(n62) );
  OAI2BB2X1M U78 ( .B0(n132), .B1(n104), .A0N(\FIFO_MEM[2][0] ), .A1N(n104), 
        .Y(n63) );
  OAI2BB2X1M U79 ( .B0(n131), .B1(n103), .A0N(\FIFO_MEM[2][1] ), .A1N(n103), 
        .Y(n64) );
  OAI2BB2X1M U80 ( .B0(n130), .B1(n104), .A0N(\FIFO_MEM[2][2] ), .A1N(n104), 
        .Y(n65) );
  OAI2BB2X1M U81 ( .B0(n129), .B1(n103), .A0N(\FIFO_MEM[2][3] ), .A1N(n103), 
        .Y(n66) );
  OAI2BB2X1M U82 ( .B0(n128), .B1(n104), .A0N(\FIFO_MEM[2][4] ), .A1N(n104), 
        .Y(n67) );
  OAI2BB2X1M U83 ( .B0(n127), .B1(n103), .A0N(\FIFO_MEM[2][5] ), .A1N(n103), 
        .Y(n68) );
  OAI2BB2X1M U84 ( .B0(n126), .B1(n104), .A0N(\FIFO_MEM[2][6] ), .A1N(n104), 
        .Y(n69) );
  OAI2BB2X1M U85 ( .B0(n125), .B1(n103), .A0N(\FIFO_MEM[2][7] ), .A1N(n103), 
        .Y(n70) );
  OAI2BB2X1M U86 ( .B0(n132), .B1(n102), .A0N(\FIFO_MEM[1][0] ), .A1N(n102), 
        .Y(n71) );
  OAI2BB2X1M U87 ( .B0(n131), .B1(n101), .A0N(\FIFO_MEM[1][1] ), .A1N(n101), 
        .Y(n72) );
  OAI2BB2X1M U88 ( .B0(n130), .B1(n102), .A0N(\FIFO_MEM[1][2] ), .A1N(n102), 
        .Y(n73) );
  OAI2BB2X1M U89 ( .B0(n129), .B1(n101), .A0N(\FIFO_MEM[1][3] ), .A1N(n101), 
        .Y(n74) );
  OAI2BB2X1M U90 ( .B0(n128), .B1(n102), .A0N(\FIFO_MEM[1][4] ), .A1N(n102), 
        .Y(n75) );
  OAI2BB2X1M U91 ( .B0(n127), .B1(n101), .A0N(\FIFO_MEM[1][5] ), .A1N(n101), 
        .Y(n76) );
  OAI2BB2X1M U92 ( .B0(n126), .B1(n102), .A0N(\FIFO_MEM[1][6] ), .A1N(n102), 
        .Y(n77) );
  OAI2BB2X1M U93 ( .B0(n125), .B1(n101), .A0N(\FIFO_MEM[1][7] ), .A1N(n101), 
        .Y(n78) );
  OAI2BB2X1M U94 ( .B0(n132), .B1(n100), .A0N(\FIFO_MEM[0][0] ), .A1N(n100), 
        .Y(n79) );
  OAI2BB2X1M U95 ( .B0(n131), .B1(n99), .A0N(\FIFO_MEM[0][1] ), .A1N(n99), .Y(
        n80) );
  OAI2BB2X1M U96 ( .B0(n130), .B1(n100), .A0N(\FIFO_MEM[0][2] ), .A1N(n100), 
        .Y(n81) );
  OAI2BB2X1M U97 ( .B0(n129), .B1(n99), .A0N(\FIFO_MEM[0][3] ), .A1N(n99), .Y(
        n82) );
  OAI2BB2X1M U98 ( .B0(n128), .B1(n100), .A0N(\FIFO_MEM[0][4] ), .A1N(n100), 
        .Y(n83) );
  OAI2BB2X1M U99 ( .B0(n127), .B1(n99), .A0N(\FIFO_MEM[0][5] ), .A1N(n99), .Y(
        n84) );
  OAI2BB2X1M U100 ( .B0(n126), .B1(n100), .A0N(\FIFO_MEM[0][6] ), .A1N(n100), 
        .Y(n85) );
  OAI2BB2X1M U101 ( .B0(n125), .B1(n99), .A0N(\FIFO_MEM[0][7] ), .A1N(n99), 
        .Y(n86) );
  OAI2BB2X1M U102 ( .B0(n114), .B1(n132), .A0N(\FIFO_MEM[7][0] ), .A1N(n114), 
        .Y(n23) );
  OAI2BB2X1M U103 ( .B0(n113), .B1(n131), .A0N(\FIFO_MEM[7][1] ), .A1N(n113), 
        .Y(n24) );
  OAI2BB2X1M U104 ( .B0(n114), .B1(n130), .A0N(\FIFO_MEM[7][2] ), .A1N(n114), 
        .Y(n25) );
  OAI2BB2X1M U105 ( .B0(n113), .B1(n129), .A0N(\FIFO_MEM[7][3] ), .A1N(n113), 
        .Y(n26) );
  OAI2BB2X1M U106 ( .B0(n114), .B1(n128), .A0N(\FIFO_MEM[7][4] ), .A1N(n114), 
        .Y(n27) );
  OAI2BB2X1M U107 ( .B0(n113), .B1(n127), .A0N(\FIFO_MEM[7][5] ), .A1N(n113), 
        .Y(n28) );
  OAI2BB2X1M U108 ( .B0(n114), .B1(n126), .A0N(\FIFO_MEM[7][6] ), .A1N(n114), 
        .Y(n29) );
  OAI2BB2X1M U109 ( .B0(n113), .B1(n125), .A0N(\FIFO_MEM[7][7] ), .A1N(n113), 
        .Y(n30) );
  AND3X2M U110 ( .A(n12), .B(n124), .C(W_addr[0]), .Y(n4) );
  AND3X2M U111 ( .A(n12), .B(n123), .C(W_addr[1]), .Y(n5) );
  AND3X2M U112 ( .A(W_addr[0]), .B(n12), .C(W_addr[1]), .Y(n6) );
  AND3X2M U113 ( .A(W_addr[1]), .B(W_addr[0]), .C(n18), .Y(n7) );
  AND2X2M U114 ( .A(n22), .B(Winc), .Y(n16) );
  AND3X2M U115 ( .A(W_addr[1]), .B(n123), .C(n18), .Y(n8) );
  MX2X2M U116 ( .A(n10), .B(n9), .S0(N12), .Y(Rdata[0]) );
  MX4X1M U117 ( .A(\FIFO_MEM[4][0] ), .B(\FIFO_MEM[5][0] ), .C(
        \FIFO_MEM[6][0] ), .D(\FIFO_MEM[7][0] ), .S0(n93), .S1(n96), .Y(n9) );
  MX4X1M U118 ( .A(\FIFO_MEM[0][0] ), .B(\FIFO_MEM[1][0] ), .C(
        \FIFO_MEM[2][0] ), .D(\FIFO_MEM[3][0] ), .S0(n94), .S1(n97), .Y(n10)
         );
  MX2X2M U119 ( .A(n13), .B(n11), .S0(N12), .Y(Rdata[1]) );
  MX4X1M U120 ( .A(\FIFO_MEM[4][1] ), .B(\FIFO_MEM[5][1] ), .C(
        \FIFO_MEM[6][1] ), .D(\FIFO_MEM[7][1] ), .S0(n93), .S1(n96), .Y(n11)
         );
  MX4X1M U121 ( .A(\FIFO_MEM[0][1] ), .B(\FIFO_MEM[1][1] ), .C(
        \FIFO_MEM[2][1] ), .D(\FIFO_MEM[3][1] ), .S0(n94), .S1(n97), .Y(n13)
         );
  MX2X2M U122 ( .A(n15), .B(n14), .S0(N12), .Y(Rdata[2]) );
  MX4X1M U123 ( .A(\FIFO_MEM[4][2] ), .B(\FIFO_MEM[5][2] ), .C(
        \FIFO_MEM[6][2] ), .D(\FIFO_MEM[7][2] ), .S0(n93), .S1(n96), .Y(n14)
         );
  MX4X1M U124 ( .A(\FIFO_MEM[0][2] ), .B(\FIFO_MEM[1][2] ), .C(
        \FIFO_MEM[2][2] ), .D(\FIFO_MEM[3][2] ), .S0(n94), .S1(n97), .Y(n15)
         );
  MX2X2M U125 ( .A(n19), .B(n17), .S0(N12), .Y(Rdata[3]) );
  MX4X1M U126 ( .A(\FIFO_MEM[4][3] ), .B(\FIFO_MEM[5][3] ), .C(
        \FIFO_MEM[6][3] ), .D(\FIFO_MEM[7][3] ), .S0(n93), .S1(n96), .Y(n17)
         );
  MX4X1M U127 ( .A(\FIFO_MEM[0][3] ), .B(\FIFO_MEM[1][3] ), .C(
        \FIFO_MEM[2][3] ), .D(\FIFO_MEM[3][3] ), .S0(n94), .S1(n97), .Y(n19)
         );
  MX2X2M U128 ( .A(n21), .B(n20), .S0(N12), .Y(Rdata[4]) );
  MX4X1M U129 ( .A(\FIFO_MEM[4][4] ), .B(\FIFO_MEM[5][4] ), .C(
        \FIFO_MEM[6][4] ), .D(\FIFO_MEM[7][4] ), .S0(n93), .S1(n96), .Y(n20)
         );
  MX4X1M U130 ( .A(\FIFO_MEM[0][4] ), .B(\FIFO_MEM[1][4] ), .C(
        \FIFO_MEM[2][4] ), .D(\FIFO_MEM[3][4] ), .S0(n94), .S1(n97), .Y(n21)
         );
  MX2X2M U131 ( .A(n88), .B(n87), .S0(N12), .Y(Rdata[5]) );
  MX4X1M U132 ( .A(\FIFO_MEM[4][5] ), .B(\FIFO_MEM[5][5] ), .C(
        \FIFO_MEM[6][5] ), .D(\FIFO_MEM[7][5] ), .S0(n93), .S1(n96), .Y(n87)
         );
  MX4X1M U133 ( .A(\FIFO_MEM[0][5] ), .B(\FIFO_MEM[1][5] ), .C(
        \FIFO_MEM[2][5] ), .D(\FIFO_MEM[3][5] ), .S0(n94), .S1(n97), .Y(n88)
         );
  MX2X2M U134 ( .A(n90), .B(n89), .S0(N12), .Y(Rdata[6]) );
  MX4X1M U135 ( .A(\FIFO_MEM[4][6] ), .B(\FIFO_MEM[5][6] ), .C(
        \FIFO_MEM[6][6] ), .D(\FIFO_MEM[7][6] ), .S0(n93), .S1(n96), .Y(n89)
         );
  MX4X1M U136 ( .A(\FIFO_MEM[0][6] ), .B(\FIFO_MEM[1][6] ), .C(
        \FIFO_MEM[2][6] ), .D(\FIFO_MEM[3][6] ), .S0(n94), .S1(n97), .Y(n90)
         );
  MX2X2M U137 ( .A(n92), .B(n91), .S0(N12), .Y(Rdata[7]) );
  MX4X1M U138 ( .A(\FIFO_MEM[4][7] ), .B(\FIFO_MEM[5][7] ), .C(
        \FIFO_MEM[6][7] ), .D(\FIFO_MEM[7][7] ), .S0(n93), .S1(n96), .Y(n91)
         );
  MX4X1M U139 ( .A(\FIFO_MEM[0][7] ), .B(\FIFO_MEM[1][7] ), .C(
        \FIFO_MEM[2][7] ), .D(\FIFO_MEM[3][7] ), .S0(n94), .S1(n97), .Y(n92)
         );
  INVX2M U140 ( .A(N10), .Y(n95) );
  INVX2M U141 ( .A(N11), .Y(n98) );
endmodule


module FIFO_WR ( W_CLK, W_RST, Winc, wq2_rptr, Wptr, Waddr, FULL );
  input [3:0] wq2_rptr;
  output [3:0] Wptr;
  output [3:0] Waddr;
  input W_CLK, W_RST, Winc;
  output FULL;
  wire   N7, N8, N9, N21, n5, n6, n9, n11, n12, n14, n15, n17, n18, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, \r58/carry[3] ,
         \r58/carry[2] , n1, n2, n4, n7, n8, n10, n13, n16, n19;

  DFFRQX2M \gray_wr_ptr_reg[2]  ( .D(n27), .CK(W_CLK), .RN(n1), .Q(Wptr[2]) );
  DFFRQX2M \gray_wr_ptr_reg[0]  ( .D(n29), .CK(W_CLK), .RN(n1), .Q(Wptr[0]) );
  DFFRQX2M \gray_wr_ptr_reg[3]  ( .D(n32), .CK(W_CLK), .RN(n1), .Q(Wptr[3]) );
  DFFRQX2M \gray_wr_ptr_reg[1]  ( .D(n28), .CK(W_CLK), .RN(n1), .Q(Wptr[1]) );
  DFFRQX2M \Waddr_reg[3]  ( .D(n30), .CK(W_CLK), .RN(n1), .Q(Waddr[3]) );
  DFFRQX2M \Waddr_reg[2]  ( .D(n31), .CK(W_CLK), .RN(n1), .Q(Waddr[2]) );
  DFFRQX4M \Waddr_reg[0]  ( .D(n34), .CK(W_CLK), .RN(n1), .Q(Waddr[0]) );
  DFFRQX4M \Waddr_reg[1]  ( .D(n33), .CK(W_CLK), .RN(n1), .Q(Waddr[1]) );
  ADDHX4M U3 ( .A(Waddr[3]), .B(\r58/carry[3] ), .CO(N21), .S(N9) );
  INVX4M U4 ( .A(n11), .Y(n4) );
  INVX4M U5 ( .A(n2), .Y(n1) );
  INVX2M U6 ( .A(W_RST), .Y(n2) );
  OAI222X1M U7 ( .A0(N8), .A1(n5), .B0(N9), .B1(n6), .C0(n4), .C1(n19), .Y(n27) );
  NAND2X4M U8 ( .A(Winc), .B(n22), .Y(n11) );
  NAND2X2M U9 ( .A(N9), .B(n4), .Y(n5) );
  OAI22X1M U10 ( .A0(n4), .A1(n13), .B0(n17), .B1(n6), .Y(n31) );
  OAI22X1M U11 ( .A0(n4), .A1(n10), .B0(n17), .B1(n9), .Y(n33) );
  NAND2X2M U12 ( .A(N7), .B(n4), .Y(n9) );
  NAND2X2M U13 ( .A(N8), .B(n4), .Y(n6) );
  INVX2M U14 ( .A(n22), .Y(FULL) );
  NOR3X4M U15 ( .A(n10), .B(n8), .C(n13), .Y(n15) );
  OAI32X2M U16 ( .A0(Waddr[0]), .A1(n17), .A2(n11), .B0(n4), .B1(n8), .Y(n34)
         );
  OAI222X1M U17 ( .A0(N7), .A1(n6), .B0(N8), .B1(n9), .C0(n4), .C1(n16), .Y(
        n28) );
  INVX2M U18 ( .A(Wptr[1]), .Y(n16) );
  OAI2B2X1M U19 ( .A1N(Waddr[3]), .A0(n14), .B0(n15), .B1(n5), .Y(n30) );
  NOR2X2M U20 ( .A(N9), .B(n11), .Y(n14) );
  AO21XLM U21 ( .A0(n11), .A1(Wptr[0]), .B0(n12), .Y(n29) );
  OAI32X2M U22 ( .A0(n11), .A1(N7), .A2(Waddr[0]), .B0(n9), .B1(n8), .Y(n12)
         );
  AO21XLM U23 ( .A0(n11), .A1(Wptr[3]), .B0(n18), .Y(n32) );
  OAI32X2M U24 ( .A0(n11), .A1(N9), .A2(n7), .B0(n5), .B1(N21), .Y(n18) );
  INVX2M U25 ( .A(N21), .Y(n7) );
  XNOR2X2M U26 ( .A(wq2_rptr[2]), .B(n19), .Y(n25) );
  NAND4X2M U27 ( .A(n23), .B(n24), .C(n25), .D(n26), .Y(n22) );
  XNOR2X2M U28 ( .A(Wptr[0]), .B(wq2_rptr[0]), .Y(n23) );
  XNOR2X2M U29 ( .A(Wptr[1]), .B(wq2_rptr[1]), .Y(n24) );
  CLKXOR2X2M U30 ( .A(wq2_rptr[3]), .B(Wptr[3]), .Y(n26) );
  INVX2M U31 ( .A(Wptr[2]), .Y(n19) );
  ADDHX4M U32 ( .A(Waddr[1]), .B(Waddr[0]), .CO(\r58/carry[2] ), .S(N7) );
  ADDHX4M U33 ( .A(Waddr[2]), .B(\r58/carry[2] ), .CO(\r58/carry[3] ), .S(N8)
         );
  NOR2BX4M U34 ( .AN(n15), .B(Waddr[3]), .Y(n17) );
  INVX2M U35 ( .A(Waddr[0]), .Y(n8) );
  INVX2M U36 ( .A(Waddr[1]), .Y(n10) );
  INVX2M U37 ( .A(Waddr[2]), .Y(n13) );
endmodule


module FIFO_RD ( R_CLK, R_RST, Rinc, rq2_wptr, rptr, raddr, EMPTY );
  input [3:0] rq2_wptr;
  output [3:0] rptr;
  output [3:0] raddr;
  input R_CLK, R_RST, Rinc;
  output EMPTY;
  wire   N6, N7, N8, N9, N21, n7, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, \r58/carry[3] , \r58/carry[2] , n1,
         n2, n4, n5, n6, n8;
  wire   [3:0] gray_rd_ptr;

  DFFRHQX8M \raddr_reg[2]  ( .D(n22), .CK(R_CLK), .RN(n1), .Q(raddr[2]) );
  DFFRX1M \raddr_reg[3]  ( .D(n25), .CK(R_CLK), .RN(n1), .Q(raddr[3]), .QN(n7)
         );
  DFFRQX1M \gray_rd_ptr_reg[3]  ( .D(n24), .CK(R_CLK), .RN(n1), .Q(
        gray_rd_ptr[3]) );
  DFFRQX1M \gray_rd_ptr_reg[2]  ( .D(n19), .CK(R_CLK), .RN(n1), .Q(
        gray_rd_ptr[2]) );
  DFFRQX1M \gray_rd_ptr_reg[1]  ( .D(n20), .CK(R_CLK), .RN(n1), .Q(
        gray_rd_ptr[1]) );
  DFFRQX1M \gray_rd_ptr_reg[0]  ( .D(n21), .CK(R_CLK), .RN(n1), .Q(
        gray_rd_ptr[0]) );
  DFFRQX4M \raddr_reg[0]  ( .D(n26), .CK(R_CLK), .RN(n1), .Q(raddr[0]) );
  DFFRX4M \raddr_reg[1]  ( .D(n23), .CK(R_CLK), .RN(n1), .Q(raddr[1]) );
  ADDHX1M U3 ( .A(raddr[3]), .B(\r58/carry[3] ), .CO(N21), .S(N9) );
  ADDHX1M U4 ( .A(raddr[2]), .B(\r58/carry[2] ), .CO(\r58/carry[3] ), .S(N8)
         );
  ADDHX2M U5 ( .A(raddr[1]), .B(raddr[0]), .CO(\r58/carry[2] ), .S(N7) );
  CLKXOR2X2M U6 ( .A(n6), .B(n5), .Y(rptr[2]) );
  CLKXOR2X2M U7 ( .A(n8), .B(n6), .Y(rptr[1]) );
  INVX4M U8 ( .A(n2), .Y(n1) );
  INVX2M U9 ( .A(R_RST), .Y(n2) );
  XNOR2X4M U10 ( .A(n5), .B(N21), .Y(rptr[3]) );
  INVX4M U11 ( .A(n11), .Y(n4) );
  INVX2M U12 ( .A(N9), .Y(n5) );
  INVX2M U13 ( .A(n14), .Y(EMPTY) );
  CLKXOR2X2M U14 ( .A(N6), .B(N7), .Y(rptr[0]) );
  INVX2M U15 ( .A(N8), .Y(n6) );
  INVX2M U16 ( .A(N7), .Y(n8) );
  NAND2X4M U17 ( .A(Rinc), .B(n14), .Y(n11) );
  XNOR2X2M U18 ( .A(gray_rd_ptr[1]), .B(rq2_wptr[1]), .Y(n15) );
  OAI22X1M U19 ( .A0(n4), .A1(n7), .B0(n5), .B1(n12), .Y(n25) );
  NAND2X2M U20 ( .A(n4), .B(n13), .Y(n12) );
  NAND4X2M U21 ( .A(raddr[2]), .B(raddr[1]), .C(raddr[0]), .D(n7), .Y(n13) );
  NAND4X2M U22 ( .A(n15), .B(n16), .C(n17), .D(n18), .Y(n14) );
  XNOR2X2M U23 ( .A(gray_rd_ptr[3]), .B(rq2_wptr[3]), .Y(n17) );
  XNOR2X2M U24 ( .A(gray_rd_ptr[2]), .B(rq2_wptr[2]), .Y(n18) );
  XNOR2X2M U25 ( .A(gray_rd_ptr[0]), .B(rq2_wptr[0]), .Y(n16) );
  OAI2BB2X1M U26 ( .B0(n8), .B1(n12), .A0N(n11), .A1N(raddr[1]), .Y(n23) );
  OAI2BB2X1M U27 ( .B0(n6), .B1(n12), .A0N(n11), .A1N(raddr[2]), .Y(n22) );
  AO2B2X2M U28 ( .B0(n11), .B1(raddr[0]), .A0(N6), .A1N(n12), .Y(n26) );
  AO22X1M U29 ( .A0(rptr[2]), .A1(n4), .B0(n11), .B1(gray_rd_ptr[2]), .Y(n19)
         );
  AO22X1M U30 ( .A0(rptr[3]), .A1(n4), .B0(n11), .B1(gray_rd_ptr[3]), .Y(n24)
         );
  INVX2M U31 ( .A(raddr[0]), .Y(N6) );
  AO22X1M U32 ( .A0(rptr[0]), .A1(n4), .B0(n11), .B1(gray_rd_ptr[0]), .Y(n21)
         );
  AO22X1M U33 ( .A0(rptr[1]), .A1(n4), .B0(n11), .B1(gray_rd_ptr[1]), .Y(n20)
         );
endmodule


module DF_SYNC_0 ( CLK, RST, ASYNC_IN, SYNC_OUT );
  input [3:0] ASYNC_IN;
  output [3:0] SYNC_OUT;
  input CLK, RST;
  wire   \sync_reg[3][0] , \sync_reg[2][0] , \sync_reg[1][0] ,
         \sync_reg[0][0] , n1, n2;

  DFFRQX1M \sync_reg_reg[3][1]  ( .D(\sync_reg[3][0] ), .CK(CLK), .RN(n1), .Q(
        SYNC_OUT[3]) );
  DFFRQX1M \sync_reg_reg[2][1]  ( .D(\sync_reg[2][0] ), .CK(CLK), .RN(n1), .Q(
        SYNC_OUT[2]) );
  DFFRQX1M \sync_reg_reg[1][1]  ( .D(\sync_reg[1][0] ), .CK(CLK), .RN(n1), .Q(
        SYNC_OUT[1]) );
  DFFRQX1M \sync_reg_reg[0][1]  ( .D(\sync_reg[0][0] ), .CK(CLK), .RN(n1), .Q(
        SYNC_OUT[0]) );
  DFFRQX1M \sync_reg_reg[3][0]  ( .D(ASYNC_IN[3]), .CK(CLK), .RN(n1), .Q(
        \sync_reg[3][0] ) );
  DFFRQX1M \sync_reg_reg[2][0]  ( .D(ASYNC_IN[2]), .CK(CLK), .RN(n1), .Q(
        \sync_reg[2][0] ) );
  DFFRQX1M \sync_reg_reg[1][0]  ( .D(ASYNC_IN[1]), .CK(CLK), .RN(n1), .Q(
        \sync_reg[1][0] ) );
  DFFRQX1M \sync_reg_reg[0][0]  ( .D(ASYNC_IN[0]), .CK(CLK), .RN(n1), .Q(
        \sync_reg[0][0] ) );
  INVX4M U3 ( .A(n2), .Y(n1) );
  INVX2M U4 ( .A(RST), .Y(n2) );
endmodule


module DF_SYNC_1 ( CLK, RST, ASYNC_IN, SYNC_OUT );
  input [3:0] ASYNC_IN;
  output [3:0] SYNC_OUT;
  input CLK, RST;
  wire   \sync_reg[3][0] , \sync_reg[2][0] , \sync_reg[1][0] ,
         \sync_reg[0][0] , n1, n2;

  DFFRQX2M \sync_reg_reg[2][1]  ( .D(\sync_reg[2][0] ), .CK(CLK), .RN(n1), .Q(
        SYNC_OUT[2]) );
  DFFRQX2M \sync_reg_reg[3][1]  ( .D(\sync_reg[3][0] ), .CK(CLK), .RN(n1), .Q(
        SYNC_OUT[3]) );
  DFFRQX2M \sync_reg_reg[1][1]  ( .D(\sync_reg[1][0] ), .CK(CLK), .RN(n1), .Q(
        SYNC_OUT[1]) );
  DFFRQX2M \sync_reg_reg[0][1]  ( .D(\sync_reg[0][0] ), .CK(CLK), .RN(n1), .Q(
        SYNC_OUT[0]) );
  DFFRQX2M \sync_reg_reg[3][0]  ( .D(ASYNC_IN[3]), .CK(CLK), .RN(n1), .Q(
        \sync_reg[3][0] ) );
  DFFRQX2M \sync_reg_reg[0][0]  ( .D(ASYNC_IN[0]), .CK(CLK), .RN(n1), .Q(
        \sync_reg[0][0] ) );
  DFFRQX2M \sync_reg_reg[2][0]  ( .D(ASYNC_IN[2]), .CK(CLK), .RN(n1), .Q(
        \sync_reg[2][0] ) );
  DFFRQX2M \sync_reg_reg[1][0]  ( .D(ASYNC_IN[1]), .CK(CLK), .RN(n1), .Q(
        \sync_reg[1][0] ) );
  INVX4M U3 ( .A(n2), .Y(n1) );
  INVX2M U4 ( .A(RST), .Y(n2) );
endmodule


module ASYNC_FIFO ( W_CLK, W_RST, W_INC, R_CLK, R_RST, R_INC, WR_DATA, FULL, 
        RD_DATA, EMPTY );
  input [7:0] WR_DATA;
  output [7:0] RD_DATA;
  input W_CLK, W_RST, W_INC, R_CLK, R_RST, R_INC;
  output FULL, EMPTY;
  wire   n1, n2;
  wire   [3:0] W_addr;
  wire   [3:0] R_addr;
  wire   [3:0] sync_Rd_ptr;
  wire   [3:0] W_ptr;
  wire   [3:0] sync_Wr_ptr;
  wire   [3:0] R_ptr;

  FIFO_MEM_CNTRL DUT_fifo_mem ( .Wdata(WR_DATA), .Winc(W_INC), .Rinc(R_INC), 
        .W_CLK(W_CLK), .W_RST(n1), .Wfull(FULL), .W_addr(W_addr), .R_addr(
        R_addr), .Rdata(RD_DATA) );
  FIFO_WR DUT_fifo_wr ( .W_CLK(W_CLK), .W_RST(n1), .Winc(W_INC), .wq2_rptr(
        sync_Rd_ptr), .Wptr(W_ptr), .Waddr(W_addr), .FULL(FULL) );
  FIFO_RD DUT_fifo_rd ( .R_CLK(R_CLK), .R_RST(R_RST), .Rinc(R_INC), .rq2_wptr(
        sync_Wr_ptr), .rptr(R_ptr), .raddr(R_addr), .EMPTY(EMPTY) );
  DF_SYNC_0 DUT_W2R ( .CLK(R_CLK), .RST(R_RST), .ASYNC_IN(W_ptr), .SYNC_OUT(
        sync_Wr_ptr) );
  DF_SYNC_1 DUT_R2W ( .CLK(W_CLK), .RST(n1), .ASYNC_IN(R_ptr), .SYNC_OUT(
        sync_Rd_ptr) );
  INVX2M U1 ( .A(n2), .Y(n1) );
  INVX2M U2 ( .A(W_RST), .Y(n2) );
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
  INVX2M U1 ( .A(A[0]), .Y(SUM[0]) );
  CLKXOR2X2M U2 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
endmodule


module CLKDiv_0 ( I_ref_clk, I_rst_n, I_clk_en, I_div_ratio, O_div_clk );
  input [7:0] I_div_ratio;
  input I_ref_clk, I_rst_n, I_clk_en;
  output O_div_clk;
  wire   div_clk, odd_edge_tog, N16, N17, N18, N19, N20, N21, N22, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n1, n2, n3, n4, n5, n6, n7, n8, n9,
         n10, n11, n12, n13, n14, n15, n16, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46;
  wire   [6:0] count;
  wire   [6:0] edge_flip_half;

  CLKDiv_0_DW01_inc_0 add_44 ( .A(count), .SUM({N22, N21, N20, N19, N18, N17, 
        N16}) );
  DFFRQX2M div_clk_reg ( .D(n18), .CK(I_ref_clk), .RN(n2), .Q(div_clk) );
  DFFSQX2M odd_edge_tog_reg ( .D(n17), .CK(I_ref_clk), .SN(n2), .Q(
        odd_edge_tog) );
  DFFRQX2M \count_reg[6]  ( .D(n19), .CK(I_ref_clk), .RN(n2), .Q(count[6]) );
  DFFRQX4M \count_reg[0]  ( .D(n25), .CK(I_ref_clk), .RN(n2), .Q(count[0]) );
  DFFRQX2M \count_reg[5]  ( .D(n20), .CK(I_ref_clk), .RN(n2), .Q(count[5]) );
  DFFRQX2M \count_reg[4]  ( .D(n21), .CK(I_ref_clk), .RN(n2), .Q(count[4]) );
  DFFRQX2M \count_reg[3]  ( .D(n22), .CK(I_ref_clk), .RN(n2), .Q(count[3]) );
  DFFRQX2M \count_reg[2]  ( .D(n23), .CK(I_ref_clk), .RN(n2), .Q(count[2]) );
  DFFRQX2M \count_reg[1]  ( .D(n24), .CK(I_ref_clk), .RN(n2), .Q(count[1]) );
  NOR4X2M U3 ( .A(n34), .B(n35), .C(n36), .D(n37), .Y(n33) );
  NOR2X4M U4 ( .A(n5), .B(I_div_ratio[4]), .Y(n6) );
  AND3X4M U5 ( .A(n12), .B(n13), .C(n46), .Y(n11) );
  NAND4X2M U6 ( .A(n30), .B(n31), .C(n32), .D(n33), .Y(n15) );
  AO22XLM U7 ( .A0(n1), .A1(count[6]), .B0(N22), .B1(n11), .Y(n19) );
  AO22XLM U8 ( .A0(n1), .A1(count[1]), .B0(N17), .B1(n11), .Y(n24) );
  AO22XLM U9 ( .A0(n1), .A1(count[2]), .B0(N18), .B1(n11), .Y(n23) );
  AO22XLM U10 ( .A0(n1), .A1(count[3]), .B0(N19), .B1(n11), .Y(n22) );
  AO22XLM U11 ( .A0(n1), .A1(count[4]), .B0(N20), .B1(n11), .Y(n21) );
  AO22XLM U12 ( .A0(n1), .A1(count[5]), .B0(N21), .B1(n11), .Y(n20) );
  NAND2BX2M U13 ( .AN(I_div_ratio[2]), .B(edge_flip_half[0]), .Y(n4) );
  OR2X2M U14 ( .A(n4), .B(I_div_ratio[3]), .Y(n5) );
  OAI2BB1XLM U15 ( .A0N(I_div_ratio[1]), .A1N(I_div_ratio[2]), .B0(n4), .Y(
        edge_flip_half[1]) );
  INVX4M U16 ( .A(n3), .Y(n2) );
  INVX2M U17 ( .A(I_rst_n), .Y(n3) );
  CLKBUFX6M U18 ( .A(n10), .Y(n1) );
  OAI21X2M U19 ( .A0(n26), .A1(n27), .B0(I_clk_en), .Y(n10) );
  INVX2M U20 ( .A(I_div_ratio[1]), .Y(edge_flip_half[0]) );
  INVX2M U21 ( .A(I_div_ratio[5]), .Y(n9) );
  OAI2BB1X1M U22 ( .A0N(n4), .A1N(I_div_ratio[3]), .B0(n5), .Y(
        edge_flip_half[2]) );
  AO21XLM U23 ( .A0(n5), .A1(I_div_ratio[4]), .B0(n6), .Y(edge_flip_half[3])
         );
  CLKNAND2X2M U24 ( .A(n6), .B(n9), .Y(n7) );
  OAI21X1M U25 ( .A0(n6), .A1(n9), .B0(n7), .Y(edge_flip_half[4]) );
  XNOR2X1M U26 ( .A(I_div_ratio[6]), .B(n7), .Y(edge_flip_half[5]) );
  NOR2X1M U27 ( .A(I_div_ratio[6]), .B(n7), .Y(n8) );
  CLKXOR2X2M U28 ( .A(I_div_ratio[7]), .B(n8), .Y(edge_flip_half[6]) );
  MX2X6M U29 ( .A(I_ref_clk), .B(div_clk), .S0(n46), .Y(O_div_clk) );
  AO22X1M U30 ( .A0(n1), .A1(count[0]), .B0(N16), .B1(n11), .Y(n25) );
  CLKINVX1M U31 ( .A(n1), .Y(n46) );
  CLKXOR2X2M U32 ( .A(div_clk), .B(n14), .Y(n18) );
  AOI21X1M U33 ( .A0(n13), .A1(n12), .B0(n1), .Y(n14) );
  OR2X1M U34 ( .A(n15), .B(I_div_ratio[0]), .Y(n12) );
  XNOR2X1M U35 ( .A(odd_edge_tog), .B(n16), .Y(n17) );
  OR2X1M U36 ( .A(n13), .B(n1), .Y(n16) );
  OR3X1M U37 ( .A(I_div_ratio[2]), .B(I_div_ratio[3]), .C(I_div_ratio[1]), .Y(
        n27) );
  OR4X1M U38 ( .A(I_div_ratio[7]), .B(I_div_ratio[4]), .C(I_div_ratio[5]), .D(
        I_div_ratio[6]), .Y(n26) );
  CLKNAND2X2M U39 ( .A(n28), .B(I_div_ratio[0]), .Y(n13) );
  MXI2X1M U40 ( .A(n29), .B(n15), .S0(odd_edge_tog), .Y(n28) );
  CLKXOR2X2M U41 ( .A(edge_flip_half[2]), .B(count[2]), .Y(n37) );
  CLKXOR2X2M U42 ( .A(edge_flip_half[1]), .B(count[1]), .Y(n36) );
  CLKXOR2X2M U43 ( .A(edge_flip_half[0]), .B(count[0]), .Y(n35) );
  CLKXOR2X2M U44 ( .A(edge_flip_half[6]), .B(count[6]), .Y(n34) );
  XNOR2X1M U45 ( .A(count[4]), .B(edge_flip_half[4]), .Y(n32) );
  XNOR2X1M U46 ( .A(count[5]), .B(edge_flip_half[5]), .Y(n31) );
  XNOR2X1M U47 ( .A(count[3]), .B(edge_flip_half[3]), .Y(n30) );
  NAND4X1M U48 ( .A(n38), .B(n39), .C(n40), .D(n41), .Y(n29) );
  NOR4X1M U49 ( .A(n42), .B(n43), .C(n44), .D(n45), .Y(n41) );
  CLKXOR2X2M U50 ( .A(count[2]), .B(I_div_ratio[3]), .Y(n45) );
  CLKXOR2X2M U51 ( .A(count[1]), .B(I_div_ratio[2]), .Y(n44) );
  CLKXOR2X2M U52 ( .A(count[0]), .B(I_div_ratio[1]), .Y(n43) );
  CLKXOR2X2M U53 ( .A(count[6]), .B(I_div_ratio[7]), .Y(n42) );
  XNOR2X1M U54 ( .A(I_div_ratio[5]), .B(count[4]), .Y(n40) );
  XNOR2X1M U55 ( .A(I_div_ratio[6]), .B(count[5]), .Y(n39) );
  XNOR2X1M U56 ( .A(I_div_ratio[4]), .B(count[3]), .Y(n38) );
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
  INVX2M U1 ( .A(A[0]), .Y(SUM[0]) );
  CLKXOR2X2M U2 ( .A(carry[6]), .B(A[6]), .Y(SUM[6]) );
endmodule


module CLKDiv_1 ( I_ref_clk, I_rst_n, I_clk_en, I_div_ratio, O_div_clk );
  input [7:0] I_div_ratio;
  input I_ref_clk, I_rst_n, I_clk_en;
  output O_div_clk;
  wire   div_clk, odd_edge_tog, N16, N17, N18, N19, N20, N21, N22, n1, n2, n3,
         n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55;
  wire   [6:0] count;
  wire   [6:0] edge_flip_half;

  CLKDiv_1_DW01_inc_0 add_44 ( .A(count), .SUM({N22, N21, N20, N19, N18, N17, 
        N16}) );
  DFFRQX2M div_clk_reg ( .D(n54), .CK(I_ref_clk), .RN(n2), .Q(div_clk) );
  DFFSQX2M odd_edge_tog_reg ( .D(n55), .CK(I_ref_clk), .SN(n2), .Q(
        odd_edge_tog) );
  DFFRQX2M \count_reg[6]  ( .D(n53), .CK(I_ref_clk), .RN(n2), .Q(count[6]) );
  DFFRQX4M \count_reg[0]  ( .D(n47), .CK(I_ref_clk), .RN(n2), .Q(count[0]) );
  DFFRQX2M \count_reg[5]  ( .D(n52), .CK(I_ref_clk), .RN(n2), .Q(count[5]) );
  DFFRQX2M \count_reg[4]  ( .D(n51), .CK(I_ref_clk), .RN(n2), .Q(count[4]) );
  DFFRQX2M \count_reg[3]  ( .D(n50), .CK(I_ref_clk), .RN(n2), .Q(count[3]) );
  DFFRQX2M \count_reg[2]  ( .D(n49), .CK(I_ref_clk), .RN(n2), .Q(count[2]) );
  DFFRQX2M \count_reg[1]  ( .D(n48), .CK(I_ref_clk), .RN(n2), .Q(count[1]) );
  NAND2BX2M U3 ( .AN(I_div_ratio[2]), .B(edge_flip_half[0]), .Y(n4) );
  NOR4X2M U4 ( .A(n34), .B(n35), .C(n36), .D(n37), .Y(n33) );
  NOR2X4M U5 ( .A(n5), .B(I_div_ratio[4]), .Y(n6) );
  AND3X4M U6 ( .A(n12), .B(n13), .C(n46), .Y(n11) );
  OR2X2M U7 ( .A(n4), .B(I_div_ratio[3]), .Y(n5) );
  OAI2BB1XLM U8 ( .A0N(I_div_ratio[1]), .A1N(I_div_ratio[2]), .B0(n4), .Y(
        edge_flip_half[1]) );
  NAND4X2M U9 ( .A(n30), .B(n31), .C(n32), .D(n33), .Y(n15) );
  AO22XLM U10 ( .A0(n1), .A1(count[6]), .B0(N22), .B1(n11), .Y(n53) );
  AO22XLM U11 ( .A0(n1), .A1(count[1]), .B0(N17), .B1(n11), .Y(n48) );
  AO22XLM U12 ( .A0(n1), .A1(count[2]), .B0(N18), .B1(n11), .Y(n49) );
  AO22XLM U13 ( .A0(n1), .A1(count[3]), .B0(N19), .B1(n11), .Y(n50) );
  AO22XLM U14 ( .A0(n1), .A1(count[4]), .B0(N20), .B1(n11), .Y(n51) );
  AO22XLM U15 ( .A0(n1), .A1(count[5]), .B0(N21), .B1(n11), .Y(n52) );
  OAI2BB1XLM U16 ( .A0N(n4), .A1N(I_div_ratio[3]), .B0(n5), .Y(
        edge_flip_half[2]) );
  INVX4M U17 ( .A(n3), .Y(n2) );
  INVX2M U18 ( .A(I_div_ratio[1]), .Y(edge_flip_half[0]) );
  INVX2M U19 ( .A(I_rst_n), .Y(n3) );
  CLKBUFX6M U20 ( .A(n10), .Y(n1) );
  OAI21X2M U21 ( .A0(n26), .A1(n27), .B0(I_clk_en), .Y(n10) );
  INVX2M U22 ( .A(I_div_ratio[5]), .Y(n9) );
  AO21XLM U23 ( .A0(n5), .A1(I_div_ratio[4]), .B0(n6), .Y(edge_flip_half[3])
         );
  CLKNAND2X2M U24 ( .A(n6), .B(n9), .Y(n7) );
  OAI21X1M U25 ( .A0(n6), .A1(n9), .B0(n7), .Y(edge_flip_half[4]) );
  XNOR2X1M U26 ( .A(I_div_ratio[6]), .B(n7), .Y(edge_flip_half[5]) );
  NOR2X1M U27 ( .A(I_div_ratio[6]), .B(n7), .Y(n8) );
  CLKXOR2X2M U28 ( .A(I_div_ratio[7]), .B(n8), .Y(edge_flip_half[6]) );
  MX2X6M U29 ( .A(I_ref_clk), .B(div_clk), .S0(n46), .Y(O_div_clk) );
  AO22X1M U30 ( .A0(n1), .A1(count[0]), .B0(N16), .B1(n11), .Y(n47) );
  CLKINVX1M U31 ( .A(n1), .Y(n46) );
  CLKXOR2X2M U32 ( .A(div_clk), .B(n14), .Y(n54) );
  AOI21X1M U33 ( .A0(n13), .A1(n12), .B0(n1), .Y(n14) );
  OR2X1M U34 ( .A(n15), .B(I_div_ratio[0]), .Y(n12) );
  XNOR2X1M U35 ( .A(odd_edge_tog), .B(n16), .Y(n55) );
  OR2X1M U36 ( .A(n13), .B(n1), .Y(n16) );
  OR3X1M U37 ( .A(I_div_ratio[2]), .B(I_div_ratio[3]), .C(I_div_ratio[1]), .Y(
        n27) );
  OR4X1M U38 ( .A(I_div_ratio[7]), .B(I_div_ratio[4]), .C(I_div_ratio[5]), .D(
        I_div_ratio[6]), .Y(n26) );
  CLKNAND2X2M U39 ( .A(n28), .B(I_div_ratio[0]), .Y(n13) );
  MXI2X1M U40 ( .A(n29), .B(n15), .S0(odd_edge_tog), .Y(n28) );
  CLKXOR2X2M U41 ( .A(edge_flip_half[2]), .B(count[2]), .Y(n37) );
  CLKXOR2X2M U42 ( .A(edge_flip_half[1]), .B(count[1]), .Y(n36) );
  CLKXOR2X2M U43 ( .A(edge_flip_half[0]), .B(count[0]), .Y(n35) );
  CLKXOR2X2M U44 ( .A(edge_flip_half[6]), .B(count[6]), .Y(n34) );
  XNOR2X1M U45 ( .A(count[4]), .B(edge_flip_half[4]), .Y(n32) );
  XNOR2X1M U46 ( .A(count[5]), .B(edge_flip_half[5]), .Y(n31) );
  XNOR2X1M U47 ( .A(count[3]), .B(edge_flip_half[3]), .Y(n30) );
  NAND4X1M U48 ( .A(n38), .B(n39), .C(n40), .D(n41), .Y(n29) );
  NOR4X1M U49 ( .A(n42), .B(n43), .C(n44), .D(n45), .Y(n41) );
  CLKXOR2X2M U50 ( .A(count[2]), .B(I_div_ratio[3]), .Y(n45) );
  CLKXOR2X2M U51 ( .A(count[1]), .B(I_div_ratio[2]), .Y(n44) );
  CLKXOR2X2M U52 ( .A(count[0]), .B(I_div_ratio[1]), .Y(n43) );
  CLKXOR2X2M U53 ( .A(count[6]), .B(I_div_ratio[7]), .Y(n42) );
  XNOR2X1M U54 ( .A(I_div_ratio[5]), .B(count[4]), .Y(n40) );
  XNOR2X1M U55 ( .A(I_div_ratio[6]), .B(count[5]), .Y(n39) );
  XNOR2X1M U56 ( .A(I_div_ratio[4]), .B(count[3]), .Y(n38) );
endmodule


module CLKDIV_MUX ( IN, OUT );
  input [5:0] IN;
  output [7:0] OUT;
  wire   n5, n6, n7, n8, n9, n2, n3, n4, n10, n11, n12;
  assign OUT[4] = 1'b0;
  assign OUT[5] = 1'b0;
  assign OUT[6] = 1'b0;
  assign OUT[7] = 1'b0;

  AND2X2M U3 ( .A(n3), .B(n2), .Y(OUT[2]) );
  INVX2M U4 ( .A(IN[1]), .Y(n11) );
  AND2X2M U5 ( .A(n12), .B(n11), .Y(n2) );
  OAI211X4M U6 ( .A0(n8), .A1(n9), .B0(n12), .C0(n11), .Y(OUT[0]) );
  NOR4X2M U7 ( .A(IN[5]), .B(IN[4]), .C(IN[3]), .D(n10), .Y(n8) );
  INVXLM U8 ( .A(n6), .Y(n3) );
  NOR3X8M U9 ( .A(n7), .B(IN[1]), .C(IN[0]), .Y(OUT[1]) );
  NAND4BX2M U10 ( .AN(IN[3]), .B(IN[4]), .C(n10), .D(n4), .Y(n7) );
  NAND4BX2M U11 ( .AN(IN[4]), .B(IN[3]), .C(n10), .D(n4), .Y(n6) );
  NOR4X6M U12 ( .A(n5), .B(IN[3]), .C(IN[5]), .D(IN[4]), .Y(OUT[3]) );
  NAND3X2M U13 ( .A(n12), .B(n11), .C(IN[2]), .Y(n5) );
  NAND2X2M U14 ( .A(n7), .B(n6), .Y(n9) );
  INVX2M U15 ( .A(IN[2]), .Y(n10) );
  INVX2M U16 ( .A(IN[0]), .Y(n12) );
  INVX2M U17 ( .A(IN[5]), .Y(n4) );
endmodule


module System_TOP ( RST, UART_CLK, REF_CLK, RX_IN, TX_OUT, parity_error, 
        framing_error );
  input RST, UART_CLK, REF_CLK, RX_IN;
  output TX_OUT, parity_error, framing_error;
  wire   SYNC_UART_RST, UART_TX_CLK, UART_TX_Busy, UART_RX_CLK, UART_RX_V_OUT,
         UART_TX_V_SYNC, SYNC_REF_RST, UART_RX_V_SYNC, UART_TX_Busy_PULSE,
         ALU_OUT_VLD, RF_RdData_VLD, FIFO_FULL, ALU_EN, CLKG_EN, RF_WrEn,
         RF_RdEn, UART_TX_VLD, ALU_CLK, n2, n3, n4, n5, n6;
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
  wire   [7:0] DIV_RATIO;
  wire   [7:0] DIV_RATIO_RX;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3;

  UART DUT_UART ( .PAR_EN(UART_Config[0]), .PAR_TYP(UART_Config[1]), .RST(n4), 
        .TX_CLK(UART_TX_CLK), .TX_IN_VLD(n6), .TX_IN_P(UART_TX_SYNC), 
        .TX_OUT_S(TX_OUT), .TX_OUT_VLD(UART_TX_Busy), .RX_CLK(UART_RX_CLK), 
        .prescale(UART_Config[7:2]), .RX_IN_S(RX_IN), .RX_OUT_P(UART_RX_OUT), 
        .RX_OUT_VLD(UART_RX_V_OUT), .parr_err(parity_error), .Framing_error(
        framing_error) );
  DATA_SYNC DUT_DATA_SYNC ( .CLK(REF_CLK), .RST(n2), .bus_enable(UART_RX_V_OUT), .Unsync_bus(UART_RX_OUT), .sync_bus(UART_RX_SYNC), .enable_pulse(
        UART_RX_V_SYNC) );
  PULSE_GEN DUT_PULSE_GEN ( .CLK(UART_TX_CLK), .RST(n4), .LVL_SIG(UART_TX_Busy), .PULSE_SIG(UART_TX_Busy_PULSE) );
  SYS_CTRL DUT_SYS_CTRL ( .CLK(REF_CLK), .RST(n2), .ALU_OUT(ALU_OUT), 
        .OUT_Valid(ALU_OUT_VLD), .RdData(RF_RdData), .RdData_Valid(
        RF_RdData_VLD), .RX_P_DATA(UART_RX_SYNC), .RX_D_VLD(UART_RX_V_SYNC), 
        .FIFO_FULL(FIFO_FULL), .parity_error(parity_error), .Framing_error(
        framing_error), .ALU_FUN(ALU_FUN), .ALU_EN(ALU_EN), .CLK_EN(CLKG_EN), 
        .Address(RF_Address), .WrEn(RF_WrEn), .RdEn(RF_RdEn), .WrData(
        RF_WrData), .TX_P_DATA(UART_TX_IN), .TX_D_VLD(UART_TX_VLD) );
  RegFile DUT_REGFILE ( .CLK(REF_CLK), .RST(n2), .RdEn(RF_RdEn), .WrEn(RF_WrEn), .Address(RF_Address), .WrData(RF_WrData), .RdData(RF_RdData), .RdData_VLD(
        RF_RdData_VLD), .REG0(Operand_A), .REG1(Operand_B), .REG2(UART_Config), 
        .REG3(DIV_RATIO) );
  ALU DUT_ALU ( .A(Operand_A), .B(Operand_B), .EN(ALU_EN), .ALU_FUN(ALU_FUN), 
        .CLK(ALU_CLK), .RST(n2), .ALU_OUT(ALU_OUT), .OUT_VALID(ALU_OUT_VLD) );
  CLK_GATE DUT_CLK_GATE ( .CLK_EN(CLKG_EN), .CLK(REF_CLK), .GATED_CLK(ALU_CLK)
         );
  RST_SYNC_0 DUT_RST_SYNC_1 ( .CLK(REF_CLK), .RST(RST), .SYNC_RST(SYNC_REF_RST) );
  RST_SYNC_1 DUT_RST_SYNC_2 ( .CLK(UART_CLK), .RST(RST), .SYNC_RST(
        SYNC_UART_RST) );
  ASYNC_FIFO DUT_FIFO ( .W_CLK(REF_CLK), .W_RST(n2), .W_INC(UART_TX_VLD), 
        .R_CLK(UART_TX_CLK), .R_RST(n4), .R_INC(UART_TX_Busy_PULSE), .WR_DATA(
        UART_TX_IN), .FULL(FIFO_FULL), .RD_DATA(UART_TX_SYNC), .EMPTY(
        UART_TX_V_SYNC) );
  CLKDiv_0 DUT_CLKDIV_TX ( .I_ref_clk(UART_CLK), .I_rst_n(n4), .I_clk_en(1'b1), 
        .I_div_ratio(DIV_RATIO), .O_div_clk(UART_TX_CLK) );
  CLKDiv_1 DUT_CLKDIV_RX ( .I_ref_clk(UART_CLK), .I_rst_n(n4), .I_clk_en(1'b1), 
        .I_div_ratio({1'b0, 1'b0, 1'b0, 1'b0, DIV_RATIO_RX[3:0]}), .O_div_clk(
        UART_RX_CLK) );
  CLKDIV_MUX DUT_CLKDIV_MUX ( .IN(UART_Config[7:2]), .OUT({
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, DIV_RATIO_RX[3:0]})
         );
  INVX2M U2 ( .A(UART_TX_V_SYNC), .Y(n6) );
  INVX4M U3 ( .A(n5), .Y(n4) );
  INVX4M U4 ( .A(n3), .Y(n2) );
  INVX2M U5 ( .A(SYNC_UART_RST), .Y(n5) );
  INVX2M U6 ( .A(SYNC_REF_RST), .Y(n3) );
endmodule

