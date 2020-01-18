`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2018 07:39:34 PM
// Design Name: 
// Module Name: scoreboard_right
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


module scoreboard_left(input clk, resetScore, dl, il,
                output logic [3:0] leftscoreLeft, leftscoreRight
    );
    
    logic prev_dl = 0;
    logic cur_dl = 0;
    logic prev_il = 0;
    logic cur_il = 0;
    
    always_ff@(posedge clk)
    begin
        prev_dl = cur_dl;
        cur_dl = dl;
           
        prev_il = cur_il;
        cur_il = il;     
        if(resetScore)
        begin
            leftscoreLeft = 4'b0000;
            leftscoreRight = 4'b0000;
        end
        else
        begin
        
            if(cur_il && !prev_il)
            begin
               
                if(leftscoreRight == 4'b0101)
                begin
                    leftscoreRight =4'b0000;
                    leftscoreLeft = leftscoreLeft + 4'b0001;
                end
                else
                    leftscoreRight = leftscoreRight + 4'b0001;
                    
                if(leftscoreRight == 4'b0101 && leftscoreLeft == 4'b0101)
                begin
                    leftscoreRight = 4'b0000;
                    leftscoreLeft = 4'b0000;
                end                         
            end        
       
            else if(cur_dl && !prev_dl)
            begin
                if(leftscoreRight == 4'b0000 && leftscoreLeft == 4'b0000)
                begin
                        leftscoreRight = 4'b1001;
                        leftscoreLeft = 4'b1001;
                end
                else if(leftscoreRight == 4'b0000)
                begin
                    leftscoreLeft = leftscoreLeft - 4'b0001; 
                    leftscoreRight = 4'b0101;
                end
                else
                    leftscoreRight = leftscoreRight - 4'b0001;
            end                    
        end
     end
endmodule
