`timescale 1ns/1ns;
module Data_Sync_tb #(
    parameter NUM_STAGES =2,UNSYNC_BUS_WIDTH=8,BUS_WIDTH=1
) ();


    reg [UNSYNC_BUS_WIDTH-1:0]   Unsync_Bus_tb;
    reg                          Enable_tb    ;
    reg                          clk_tb       ;
    reg                          rst_tb       ;
    wire  [UNSYNC_BUS_WIDTH-1:0] Sync_Bus_tb  ;
    wire                         Enable_Pulse_tb;   

    parameter Clock_Period = 10 ;
    always #(Clock_Period/2) clk_tb=~clk_tb;

    initial begin
        $dumpfile("Data_Sync.vcd");
        $dumpvars;

        clk_tb='b0;
        rst_tb='b0;
        Unsync_Bus_tb='b11111111;
        Enable_tb='b0;
        #Clock_Period;
        $display("Test Case #1 RST" );
        if (~(Sync_Bus_tb && Enable_Pulse_tb )) begin
            $display("Passesd" );
        end else begin
            $display("Failed" );
        end

        rst_tb='b1;
        #Clock_Period;
        $display("Test Case #2 Enable=0 No New data should be stored" );
        if ((Sync_Bus_tb =='b0) && (Enable_Pulse_tb =='b0)) begin
            $display("Passesd" );
        end else begin
            $display("Failed" );
        end

        Enable_tb='b1;
        repeat(NUM_STAGES)#Clock_Period;
        $display("Test Case #3 Enable=1 A pulse should be gen for ONE clock cycle" );
        if (!Enable_Pulse_tb) begin
            #Clock_Period;
            if (Enable_Pulse_tb) begin
                #Clock_Period;
                if (!Enable_Pulse_tb) begin
                    $display("Passesd" );
                end else begin
                    $display("Failed" );
                end
            end else begin
                $display("Failed" );
            end
        end else begin
            $display("Failed" );
        end

        $display("Test Case #4 Data should be stored" );
        if (Sync_Bus_tb==Unsync_Bus_tb) begin
            $display("Passesd" );
        end else begin
            $display("Failed" );
        end

        $stop;







        
    end

    

    Data_Sync #(
        .NUM_STAGES       (NUM_STAGES       ),
        .UNSYNC_BUS_WIDTH (UNSYNC_BUS_WIDTH ),
        .BUS_WIDTH        (BUS_WIDTH        )
    )
    u_Data_Sync(
    	.Unsync_Bus   (Unsync_Bus_tb   ),
        .Enable       (Enable_tb       ),
        .clk          (clk_tb          ),
        .rst          (rst_tb          ),
        .Sync_Bus     (Sync_Bus_tb     ),
        .Enable_Pulse (Enable_Pulse_tb )
    );
    
endmodule