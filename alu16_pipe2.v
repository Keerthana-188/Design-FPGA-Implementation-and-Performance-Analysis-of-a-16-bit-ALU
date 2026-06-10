`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2026 21:36:39
// Design Name: 
// Module Name: alu16_pipe2
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


module alu16_pipe2(
    input sysclk,
    input [15:0] A,
    input [15:0] B,
    input [2:0] opcode,
    output reg [31:0] result,
    output reg zero_flag
);

// ==================================================
// Stage 1 Registers (Input Stage)
// ==================================================

reg [15:0] A_reg, B_reg;
reg [2:0]  opcode_reg;

always @(posedge sysclk) begin
    A_reg <= A;
    B_reg <= B;
    opcode_reg <= opcode;
end


// ==================================================
// Stage 1 Fast ALU Logic (ADD/SUB/AND/OR)
// ==================================================

reg [31:0] fast_alu_out;

always @(*) begin
    case(opcode_reg)
        3'b000: fast_alu_out = A_reg + B_reg;   // ADD
        3'b001: fast_alu_out = A_reg - B_reg;   // SUB
        3'b010: fast_alu_out = A_reg & B_reg;   // AND
        3'b011: fast_alu_out = A_reg | B_reg;   // OR
        default: fast_alu_out = 32'd0;
    endcase
end


// ==================================================
// Stage 2 Multiplier (DSP with internal register)
// ==================================================

(* use_dsp = "yes" *)
reg [31:0] mul_stage;

always @(posedge sysclk) begin
    mul_stage <= A_reg * B_reg;
end


// ==================================================
// Stage 2 Output Selection + Register
// ==================================================

always @(posedge sysclk) begin
    case(opcode_reg)
        3'b100: result <= mul_stage;        // MUL (pipelined)
        default: result <= fast_alu_out;    // Other ops
    endcase

    zero_flag <= (result == 0);
end

endmodule    
