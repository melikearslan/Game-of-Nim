`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2018 04:59:53 PM
// Design Name: 
// Module Name: scoreboard
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


module scoreboard(input logic reset, dl, dr, il, ir,
                output logic [3:0] leftscore, leftscores, rightscore , rightscores

    );
    
    
    always_ff@(posedge reset or posedge dl or posedge dr or posedge il or posedge ir)
    
    begin
        if(reset)
        begin
            rightscore = 4'b0000;
            leftscore = 4'b0000;
            rightscores = 4'b0000;
            leftscores = 4'b0000;
        end
        else
        begin
        //-----------------------------------------------------
            if(il)
            begin
                if(leftscore == 9)
                begin
                    leftscore =4'b0000;
                    leftscores = leftscores+1;
                end
                else
                    leftscore = leftscore+1;
                    
                if(leftscore == 9 && leftscores == 9)
                begin
                    leftscores = 4'b0000;
                    leftscore = 4'b0000;
                end
            end
//       //--------------------------------------------------
            else if(ir)
            begin
                if(rightscore == 9)
                begin
                    rightscore =4'b0000;
                    rightscores = rightscores+1;
                end
                else
                    rightscore = rightscore+1;
                if(rightscore == 9 && rightscores == 9)
                begin
                    rightscores = 4'b0000;
                    rightscore = 4'b0000;
                end
            end        
//      //-------------------------------------------------         
            else if(dr)
            begin
                if(rightscore == 0)
                begin
                    rightscores = rightscores-1; 
                    rightscore = 9;
                end
                else
                    rightscore = rightscore -1;

                if(rightscore == 0 && rightscores == 0)
                begin
                        rightscores = 4'b1001;
                        rightscore = 9;
                end
            end           
//      //---------------------------------------------------    
            else if(dl)
            begin
                if(leftscore == 0)
                begin
                    leftscores = leftscores-1; 
                    leftscore = 9;
                end
                else
                    leftscore = leftscore -1;
            
                if(leftscore == 0 && leftscores == 0)
                begin
                    leftscores = 4'b1001;
                    leftscore = 9;
                end
            end
//      //-------------------------------------------------------              
        end
    end
    
//    SevSeg_4digit
//       (clk,
//        rightscore, rightscores, leftscore, leftscores, //user inputs for each digit (hexadecimal value)
//        a, b, c, d, e, f, g, .dp(\<const0> ), // just connect them to FPGA pins (individual LEDs).
//        an // just connect them to FPGA pins (enable vector for 4 digits active low)
//        );
        
endmodule
