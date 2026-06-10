`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2026 22:16:51
// Design Name: 
// Module Name: alu16_pipe3_mul_opt
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


module alu16_pipe3_mul_opt(
    input sysclk,
    input [15:0] A,
    input [15:0] B,
    input [2:0] opcode,
    output reg [31:0] result,
    output reg zero_flag
);

// ===================================================
// Stage 1: Input Registers
// ===================================================

reg [15:0] A_reg1, B_reg1;
reg [2:0]  opcode_reg1;

always @(posedge sysclk) begin
    A_reg1 <= A;
    B_reg1 <= B;
    opcode_reg1 <= opcode;
end


// ===================================================
// Stage 2: Execution Stage
// ===================================================

// Fast ALU operations
reg [31:0] fast_alu_reg;

// Multiplier stage
(* use_dsp = "yes" *)
reg [31:0] mul_reg;

always @(posedge sysclk) begin

    // Fast ALU operations registered
    case(opcode_reg1)
        3'b000: fast_alu_reg <= A_reg1 + B_reg1;
        3'b001: fast_alu_reg <= A_reg1 - B_reg1;
        3'b010: fast_alu_reg <= A_reg1 & B_reg1;
        3'b011: fast_alu_reg <= A_reg1 | B_reg1;
        default: fast_alu_reg <= 32'd0;
    endcase

    // Multiplier registered separately
    mul_reg <= A_reg1 * B_reg1;

end


// ===================================================
// Stage 3: Output Selection Stage
// ===================================================

reg [2:0] opcode_reg2;

always @(posedge sysclk) begin
    opcode_reg2 <= opcode_reg1;
end

always @(posedge sysclk) begin

    case(opcode_reg2)
        3'b100: result <= mul_reg;
        default: result <= fast_alu_reg;
    endcase

    zero_flag <= (result == 0);

end

endmodule
