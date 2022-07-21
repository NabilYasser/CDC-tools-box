module RST_Sync #(
    parameter NUM_STAGES =2
) (
    input wire RST,
    input wire clk,
    output wire Sync_RST
);
    Multi_Flop_Synchronizer #(
        .NUM_STAGES (NUM_STAGES )
    )
    u_Multi_Flop_Synchronizer(
    	.async ('b1 ),
        .clk   (clk   ),
        .rst   (RST   ),
        .sync  (Sync_RST )
    );
    
    
endmodule