module Multi_Flop_Synchronizer #(
    parameter NUM_STAGES =2 
) (
    input  wire  async,
    input  wire  clk  ,
    input  wire  rst  ,
    output reg   sync
);
reg [NUM_STAGES-2:0] Q  ;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            {sync,Q}<='b0;
        end else begin
            {sync,Q}<={Q[NUM_STAGES-2],Q[NUM_STAGES-3:0],async};
        end
    end

endmodule

module Multi_Flop_Synchronizer_Multi_bits #(
    parameter NUM_STAGES =2,BUS_WIDTH=5
) (
    input  wire [BUS_WIDTH-1:0] ASYNC,
    input  wire  CLK  ,
    input  wire  RST  ,
    output wire  [BUS_WIDTH-1:0] SYNC
);
genvar i;

    generate
        for (i =0 ;i<=BUS_WIDTH-1; i=i+1 ) begin
            Multi_Flop_Synchronizer #(.NUM_STAGES(NUM_STAGES)) u0  (.async(ASYNC[i]),.clk(CLK),.rst(RST),.sync(SYNC[i])) ;
        end

    endgenerate
        

endmodule
