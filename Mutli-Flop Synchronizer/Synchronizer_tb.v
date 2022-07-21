`timescale 1ns/1ns;
module Synchronizer_tb #(
    parameter NUM_STAGES=2,BUS_WIDTH=1
) (

);
    reg [BUS_WIDTH-1:0]  ASYNC_tb;
    reg  CLK_tb;
    reg  RST_tb;
    wire [BUS_WIDTH-1:0]  SYNC_tb;

parameter Clock_Period = 10;
integer i;

always #(Clock_Period/2) CLK_tb= ~ CLK_tb;

initial begin
    $dumpfile("Synchronizer.vcd");
    $dumpvars ;

    CLK_tb=1'b0;
    RST_tb=1'b0;
    ASYNC_tb='b1;
    #Clock_Period;
    $display("Test Case #1 RST");
    if (SYNC_tb == 'b0) begin
        $display("Passed");
    end else begin
        $display("Failed");
    end

    RST_tb=1'b1;
    repeat(NUM_STAGES)#Clock_Period;
    $display("Test Case #2 SYNC after NUM_STAGES Clocks");
    if (SYNC_tb == ASYNC_tb) begin
        $display("Passed");
    end else begin
        $display("Failed");
    end
    #Clock_Period;
    $stop;

    

end

Multi_Flop_Synchronizer_Multi_bits #(
    .NUM_STAGES (NUM_STAGES ),
    .BUS_WIDTH  (BUS_WIDTH  )
)
u_Multi_Flop_Synchronizer_Multi_bits(
    .ASYNC (ASYNC_tb ),
    .CLK   (CLK_tb   ),
    .RST   (RST_tb   ),
    .SYNC  (SYNC_tb  )
);

    
endmodule