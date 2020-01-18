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


module scoreboard_right(input clk, reset, dr, ir,
                output logic [3:0] rightscoreLeft, rightscoreRight
    );
    
    logic prev_dr = 0;
    logic cur_dr = 0;
    logic prev_ir = 0;
    logic cur_ir = 0;
    
    always_ff@(posedge clk)
        
        begin
            prev_dr = cur_dr;
            cur_dr = dr;
            
            prev_ir = cur_ir;
            cur_ir = ir;
             
            if(reset)
            begin
                
                prev_dr = 0;
                cur_dr = 0;
                prev_ir = 0;
                cur_ir = 0;
                rightscoreLeft = 4'b0000;
                rightscoreRight = 4'b0000;

            end  
            else
            begin      
                if(cur_dr && !prev_dr)
                begin
                      if(rightscoreRight == 0 && rightscoreLeft == 0)
                      begin
                          rightscoreRight = 9;
                          rightscoreLeft = 9;
                      end
                      
                      else if(rightscoreRight == 0)
                      begin
                          rightscoreLeft = rightscoreLeft-1; 
                          rightscoreRight = 9;
                      end
                      else
                          rightscoreRight = rightscoreRight -1;
                end   
        
                if(cur_ir && !prev_ir)
                begin
                    if(rightscoreRight == 9)
                    begin
                        rightscoreRight = 0;
                        rightscoreLeft = rightscoreLeft+1;
                    end
                    else
                        rightscoreRight = rightscoreRight+1;
                        
                    if(rightscoreRight == 9 && rightscoreLeft == 9)
                    begin
                        rightscoreRight = 0;
                        rightscoreLeft = 0;
                    end
                end  
            end            
        end
        
endmodule
