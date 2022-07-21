module Data_Sync #(
    parameter NUM_STAGES =2,UNSYNC_BUS_WIDTH=8,BUS_WIDTH=1
) (
    input  wire [UNSYNC_BUS_WIDTH-1:0] Unsync_Bus,
    input  wire                        Enable    ,
    input  wire                        clk       ,
    input  wire                        rst       ,
    output reg  [UNSYNC_BUS_WIDTH-1:0] Sync_Bus  ,
    output reg                         Enable_Pulse              
);
    wire Enable_Sync ;
    wire Pulse_out;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            Sync_Bus<='b0;

        end else if (Pulse_out) begin
            Sync_Bus<=Unsync_Bus;

        end 
    end

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            Enable_Pulse<='b0;

        end else begin
            Enable_Pulse<=Pulse_out;

        end 
    end

    Multi_Flop_Synchronizer_Multi_bits #(
        .NUM_STAGES (NUM_STAGES ),
        .BUS_WIDTH  (BUS_WIDTH )
    )
    u_Multi_Flop_Synchronizer_Multi_bits(
    	.ASYNC (Enable ),
        .CLK   (clk   ),
        .RST   (rst   ),
        .SYNC  (Enable_Sync  )
    );
    

    Pulse_Gen u_Pulse_Gen(
    	.Signal_in (Enable_Sync ),
        .clk       (clk       ),
        .rst       (rst       ),
        .Pulse_out (Pulse_out )
    );
    
endmodule