// Implementation of the Stop Watch using Finite State Machine of Mealy Model 
// Max count is 9999 meaning 99.99 seconds

module StopWatch(SSR,rst,clk,count);
// Ports
input [2:0] SSR; // Start, Stop, Reset
input rst;
input clk;
output reg [13:0] count;

reg [1:0] state;
reg [1:0] next;

// State declaration
parameter Idle = 0;
parameter Running = 1;
parameter Stopped = 2;

// Reset condition 
always @(posedge clk or negedge rst or next)
    begin
        if (!rst)
            begin
            state <= Idle;
            count <= 0;
            end
        else if (rst)
            state <= next;
    end

// State Transition
// Inputs are taken in one-hot encoding methodology
  // State transiton is depending on both input (SSR) and current state 
always @(posedge clk)
    begin
        if (SSR == 3'd4)    // 100 -> Start
            next <= Running;
        else if (SSR == 3'd1) // 001 -> Reset
            begin
            next <= Idle;
            count = 0;
            end
      else if (SSR == 3'd2) // 010 -> Stop the Watch
            next <= Stopped;
      // else 
      //       next <= 2'bx
    end
    
// After retrieving the state
// Circuit after FSM basic block
  // Output is dependent on the current state and the input
always @(posedge clk)
    begin   
      if (state == Running && count < 9999) // end timer is 99.99 seconds
                count = count + 1;
        else if (count == 9999)
            count = 0;
        else if(state == Stopped)
            count = count;
        
    end
endmodule



