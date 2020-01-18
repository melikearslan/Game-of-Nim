`timescale 1ns / 1ps

module top_callModule(input clk, 
                // scoreboard
                input reset, dl, dr, il, ir,
                // rgb display
                input chPlayer, rowSel1, rowSel2, rowSel3, rowSel4, newGame,
                // FPGA pins for 8x8 display
                                   output reset_out, //shift register's reset
                                   output OE,     //output enable, active low 
                                   output SH_CP,  //pulse to the shift register
                                   output ST_CP,  //pulse to store shift register
                                   output DS,     //shift register's serial input data
                                   output [7:0] col_select, // active column, active high


                output logic a, b, c, d, e, f, g, dp, [3:0]an          
    );
    logic [3:0] leftscoreLeft, leftscoreRight, rightscoreRight , rightscoreLeft;
    scoreboard_right boardright(clk, reset, dr, ir, rightscoreLeft, rightscoreRight);
    scoreboard_left boardleft(clk, reset, dl, il, leftscoreLeft, leftscoreRight);
    SevSeg_4digit segment(clk,
        rightscoreRight, rightscoreLeft, leftscoreRight, leftscoreLeft, //user inputs for each digit (hexadecimal value)
        a, b, c, d, e, f, g, dp, // just connect them to FPGA pins (individual LEDs).
        an // just connect them to FPGA pins (enable vector for 4 digits active low)
        );
    
    logic debouncerRow1, debouncerRow2, debouncerRow3, debouncerRow4, debouncerNew;
    debouncer(clk, rowSel1, debouncerRow1);
    debouncer(clk, rowSel2, debouncerRow2);
    debouncer(clk, rowSel3, debouncerRow3);
    debouncer(clk, rowSel4, debouncerRow4);
    debouncer(clk, chPlayer, debouncerChange);
    
     
            
    myGame_module game(clk, debouncerChange, debouncerRow1, debouncerRow2, debouncerRow3, debouncerRow4, newGame, reset_out, OE, SH_CP, ST_CP, DS, col_select);
   
endmodule
