`timescale 1ns/1ns;
module RST_Sync_tb #(
    parameter NUM_STAGES =3
) ();
    reg RST_tb;
    reg clk_tb;
    wire Sync_RST_tb;

    parameter Clock_Period =10 ;
    always #(Clock_Period/2) clk_tb = ~clk_tb;

    initial begin
        $dumpfile("RST_Sync.vcd");
        $dumpvars;

        clk_tb='b0;
        RST_tb='b0;
        #Clock_Period;
        $display("Test Case #1 RST");
        if (!Sync_RST_tb) begin
            $display("Passed");
        end else begin
            $display("Failed");
        end

        RST_tb='b1;
        $display("Test Case #2 Asynchrounous De-assertion");
        repeat(NUM_STAGES-1)#Clock_Period;
        if (!Sync_RST_tb) begin
            #Clock_Period;
            if (Sync_RST_tb) begin
                $display("Passed");
            end else begin
                $display("Failed");
            end
        end else begin
            $display("Failed");
        end

        RST_tb='b0;
        $display("Test Case #2 synchrounous Assertion");
        #Clock_Period;
        if (!Sync_RST_tb) begin
            $display("Passed");
        end else begin
            $display("Failed");
        end

        $stop;






    end





RST_Sync #(
    .NUM_STAGES (NUM_STAGES )
)
u_RST_Sync(
    .RST      (RST_tb      ),
    .clk      (clk_tb      ),
    .Sync_RST (Sync_RST_tb )
);

    
endmodule