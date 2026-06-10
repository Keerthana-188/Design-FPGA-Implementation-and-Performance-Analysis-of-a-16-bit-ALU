`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2026 20:40:06
// Design Name: 
// Module Name: alu16_nonpipe
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


module alu16_nonpipe(
    input  [15:0] A,
    input  [15:0] B,
    input  [2:0]  opcode,
    output reg [31:0] result,
    output reg zero_flag
);

always @(*) begin
    case(opcode)
        3'b000: result = A + B;       // ADD
        3'b001: result = A - B;       // SUB
        3'b010: result = A & B;       // AND
        3'b011: result = A | B;       // OR
        3'b100: result = A * B;       // MUL
        default: result = 32'd0;
    endcase

    zero_flag = (result == 0);
end

endmodule
