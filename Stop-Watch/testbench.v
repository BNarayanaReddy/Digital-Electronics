`timescale 1us/1ps // 1 micro-second
// Company: 
// Engineer: B Lakshmi Narayana Reddy
// 
// Create Date: 04/18/2024 01:45:53 PM
// Design Name: Test bench for Stop Watch
// Module Name: test_tb
// Project Name: Stop Watch
// Target Devices: 
// Tool Versions: 
// Description: 
// Dependencies:  
// Revision:
// Revision 0.01 - File Created
// Platform : Xilinx software

module StopWatch_tb;
reg [2:0] SSR;
reg rst;
reg clk;
wire [13:0] count;

// Object instatiation
StopWatch SW2(SSR,rst,clk,count);
  
// Toggling clock
initial 
    begin
    clk = 0;
    forever
        begin
        #5000; // 0.5 millisec = 500 microsec
        clk = ~clk;
        end
    end

// Testing with the reset

initial
    begin
        rst = 0;
        #1 rst = 1;  // 1 microsecs 
    end

// Monitor from console
always @*
    $monitor($time, "Count : %d", count);
    

// Testing the model with the following inputs
always 
    begin   
    SSR = 4; #110000000;   // 1.1 X 10^{-6} X 100 -> 110 seconds
    SSR = 2; #100000000;   // 100 sec
    SSR = 1; #100000000;  //  100 sec
    
    $finish;   // Collapse the simulation
    end
            
endmodule
