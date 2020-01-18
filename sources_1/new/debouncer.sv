`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2018 09:04:49 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer(input clk,
    input PB,
    input PB_state

    );
    
    logic [20:0] PB_cnt = 21'b0;
    
    always @(posedge clk)
        if(PB)
        begin
            if(!PB_state)
                PB_cnt <= PB_cnt + 1'b1;
        end
        else
            PB_cnt <= 21'b0;
        assign PB_state = PB_cnt[20];
endmodule
