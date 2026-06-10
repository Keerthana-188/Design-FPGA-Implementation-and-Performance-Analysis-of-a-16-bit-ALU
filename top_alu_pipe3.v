`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2026 22:12:09
// Design Name: 
// Module Name: top_alu_pipe3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_alu_pipe3(
    input sysclk,
    input [3:0] sw,
    input btn0,
    input btn1,
    input btn2,
    input btn3,
    output reg [3:0] led
);

reg [15:0] A = 0;
reg [15:0] B = 0;
reg [2:0] opcode = 0;
reg [31:0] result_reg = 0;
reg [1:0] display_sel = 0;

// Edge detection
reg btn0_d, btn1_d, btn2_d, btn3_d;

always @(posedge sysclk) begin
    btn0_d <= btn0;
    btn1_d <= btn1;
    btn2_d <= btn2;
    btn3_d <= btn3;
end

wire btn0_pulse = btn0 & ~btn0_d;
wire btn1_pulse = btn1 & ~btn1_d;
wire btn2_pulse = btn2 & ~btn2_d;
wire btn3_pulse = btn3 & ~btn3_d;

// Instantiate pipelined ALU
wire [31:0] alu_result;
wire zero_flag;

alu16_pipe3_mul_opt uut(
    .sysclk(sysclk),
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(alu_result),
    .zero_flag(zero_flag)
);

always @(posedge sysclk) begin

    if(btn0_pulse)
        A <= (A << 4) | sw;

    if(btn1_pulse)
        B <= (B << 4) | sw;

    if(btn2_pulse)
        opcode <= sw[2:0];

    // Capture pipelined result
    result_reg <= alu_result;

    if(btn3_pulse)
        display_sel <= display_sel + 1;

    case(display_sel)
        2'b00: led <= result_reg[3:0];
        2'b01: led <= result_reg[7:4];
        2'b10: led <= result_reg[11:8];
        2'b11: led <= result_reg[15:12];
    endcase

end

endmodule
