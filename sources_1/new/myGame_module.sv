`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2018 09:23:37 AM
// Design Name: 
// Module Name: game_module
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


module myGame_module(input clk, chPlayer, rowSel1, rowSel2, rowSel3, rowSel4, newGame,

    // FPGA pins for 8x8 display
	output reset_out, //shift register's reset
	output OE, 	//output enable, active low 
	output SH_CP,  //pulse to the shift register
	output ST_CP,  //pulse to store shift register
	output DS, 	//shift register's serial input data
	output [7:0] col_select // active column, active high
                   );
                   
    logic [2:0] col_num;
                   
    // initial rgb      
    logic [0:7] [7:0] image_red = {8'b00000011, 8'b00000011, 8'b00110011, 8'b00110011, 8'b00110011, 8'b00000011, 8'b00000011, 8'b00000000};
    logic [0:7] [7:0] image_green = {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
    logic [0:7] [7:0] image_blue = {8'b00000000, 8'b00001100, 8'b00001100, 8'b11001100, 8'b00001100, 8'b00001100, 8'b00000000, 8'b00000000};
          
    int cnt1 = 0;
    int cnt2 = 0;
    int cnt3 = 0;
    int cnt4 = 0;
    
    logic prev_rowSel1 = 0;
    logic prev_rowSel2 = 0;
    logic prev_rowSel3 = 0;
    logic prev_rowSel4 = 0;
    logic prev_chPl = 0;
    
    logic curr_rowSel1 = 0;
    logic curr_rowSel2 = 0;
    logic curr_rowSel3 = 0;
    logic curr_rowSel4 = 0;
    logic curr_chPl = 0;
    
    logic row1Boolean = 1;
    logic row2Boolean = 1; 
    logic row3Boolean = 1;
    logic row4Boolean = 1;
    
    logic [3:0] leftPlayer = 4'b0000;
                           
    always_ff@(posedge clk)
    begin
    
        prev_rowSel1 = curr_rowSel1;
        curr_rowSel1 = rowSel1;
            
        prev_rowSel2 = curr_rowSel2;
        curr_rowSel2 = rowSel2;
        
        prev_rowSel3 = curr_rowSel3;
        curr_rowSel3 = rowSel3;
        
        prev_rowSel4 = curr_rowSel4;
        curr_rowSel4 = rowSel4;
        
        prev_chPl = curr_chPl;
        curr_chPl = chPlayer;
        
        if(newGame)
        begin
            image_red = {8'b00000011, 8'b00000011, 8'b00110011, 8'b00110011, 8'b00110011, 8'b00000011, 8'b00000011, 8'b00000000};
            image_green = {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
            image_blue = {8'b00000000, 8'b00001100, 8'b00001100, 8'b11001100, 8'b00001100, 8'b00001100, 8'b00000000, 8'b00000000};      
            
            cnt1 = 0;
            cnt2 = 0;
            cnt3 = 0;
            cnt4 = 0;
            
            prev_rowSel1 = 0;
            prev_rowSel2 = 0;
            prev_rowSel3 = 0;
            prev_rowSel4 = 0;
            prev_chPl = 0;
            
            curr_rowSel1 = 0;
            curr_rowSel2 = 0;
            curr_rowSel3 = 0;
            curr_rowSel4 = 0;
            curr_chPl = 0;
            
            row1Boolean = 1;
            row2Boolean = 1; 
            row3Boolean = 1;
            row4Boolean = 1; 
            
            leftPlayer = 4'b0000;
            
            
        end
        else
        begin
            if (curr_rowSel4 && !prev_rowSel4 && row4Boolean && image_red[0][0] != 0)
            begin
                row3Boolean = 0;
                row2Boolean = 0;
                row1Boolean = 0;
                cnt4++;
                case(cnt4)
                    1:
                    begin
                      image_red[6][0] = 0;
                     image_red[6][1] = 0;
                    end
                    2:
                    begin
                         image_red[5][0] = 0;
                         image_red[5][1] = 0;
                    end
                    3:
                    begin
                        image_red[4][0]=0;
                        image_red[4][1]=0;
                       
                    end
                    4:
                    begin
                        image_red[3][0] = 0;
                        image_red[3][1] = 0;
                    end
                    5:
                    begin
                        image_red[2][0] = 0;
                        image_red[2][1] = 0;
                    end
                    6:
                    begin
                        image_red[1][0] = 0;
                        image_red[1][1] = 0;
                    end
                    7:
                    begin
                        image_red[0][0] = 0;
                        image_red[0][1] = 0;
                        leftPlayer++;
                        row3Boolean = 1;
                        row2Boolean = 1;
                        row1Boolean = 1;
                        
                    end
                endcase    
            end
            //------------------------------------------------------
            else if(curr_rowSel3 && !prev_rowSel3 && row3Boolean && image_blue[1][2] != 0 )
            begin
                row4Boolean = 0;
                row2Boolean = 0;
                row1Boolean = 0;            
                cnt3++;
                case(cnt3)
                    1:
                    begin
                        image_blue[5][2]=0;
                        image_blue[5][3]=0;
                    end
                    2:
                    begin
                        image_blue[4][2]=0;
                        image_blue[4][3]=0;           
                    end
                    3:
                    begin
                        image_blue[3][2]=0;
                        image_blue[3][3]=0;
                    end
                    4:
                    begin
                        image_blue[2][2]=0;
                        image_blue[2][3]=0;
                    end
                    5:
                    begin
                        image_blue[1][2]=0;
                        image_blue[1][3]=0;
                        row4Boolean = 1;
                        row2Boolean = 1;
                        row1Boolean = 1;
                        leftPlayer++;
                    end
                endcase
            end
            //------------------------------------------------------
            else if(curr_rowSel2 && !prev_rowSel2 && row2Boolean && image_red[2][4] != 0)
            begin
                row4Boolean = 0;
                row3Boolean = 0;
                row1Boolean = 0;
                cnt2++;
                case(cnt2)
                1:
                begin
                    image_red[4][4]=0;
                    image_red[4][5]=0;
                end
                2:
                begin
                    image_red[3][4]=0;
                    image_red[3][5]=0;
                end
                3:
                begin
                    image_red[2][4] = 0;
                    image_red[2][5] = 0;
                    row4Boolean = 1;
                    row3Boolean = 1;
                    row1Boolean = 1;
                    leftPlayer++;
                end
                endcase
            end
            //------------------------------------------------------
            else if(curr_rowSel1 && !prev_rowSel1 && row1Boolean && image_blue[3][6] != 0)
            begin
                row4Boolean = 0;
                row3Boolean = 0;
                row2Boolean = 0;
                cnt1++;
                case(cnt1)
                1:
                 begin
                    image_blue[3][6] = 0;
                    image_blue[3][7] = 0;
                    row4Boolean = 1;
                    row3Boolean = 1;
                    row2Boolean = 1;
                    leftPlayer++;
                 end
                endcase
            end
            //--------------------------------------------------------
            else if (curr_chPl && !prev_chPl)
            begin
            
                row1Boolean = 1;
                row4Boolean = 1;
                row3Boolean = 1;
                row2Boolean = 1;
                leftPlayer++;

                    
            end
            
            else if (image_red[0][0] == 0 && image_blue[1][2] == 0 && image_red[2][4] == 0  && image_blue[3][6] == 0)
            begin
                if(leftPlayer%2==1)
                    begin
                        image_red = {8'b00010000, 
                                     8'b00111000, 
                                     8'b01111100, 
                                     8'b11111110,
                                     8'b00111000, 
                                     8'b00111000, 
                                     8'b00111000, 
                                     8'b00111000};
                                     
                        image_green = {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
                        image_blue = {8'b00010000, 8'b00111000, 8'b01111100, 8'b11111110, 8'b00111000, 8'b00111000, 8'b00111000, 8'b00111000};
                    end
                else
                    begin
                        image_red = {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
                        image_green = {8'b00111000, 8'b00111000, 8'b00111000, 8'b00111000, 8'b11111110, 8'b01111100, 8'b00111000, 8'b00010000};
                        image_blue = {8'b00111000, 8'b00111000, 8'b00111000, 8'b00111000, 8'b11111110, 8'b01111100, 8'b00111000, 8'b00010000};
                    end          
            end
                     
        end   
    end
    
    // This module displays 8x8 image on LED display module. 
    display_8x8 display_8x8_0(
        .clk(clk),
        
        // RGB data for display current column
        .red_vect_in(image_red[col_num]),
        .green_vect_in(image_green[col_num]),
        .blue_vect_in(image_blue[col_num]),
        
        .col_data_capture(), // unused
        .col_num(col_num),
        
        // FPGA pins for display
        .reset_out(reset_out),
        .OE(OE),
        .SH_CP(SH_CP),
        .ST_CP(ST_CP),
        .DS(DS),
        .col_select(col_select)   
    );
    
               
endmodule
