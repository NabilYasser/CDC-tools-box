module Pulse_Gen (
    input  wire Signal_in,
    input  wire clk      ,
    input  wire rst      ,
    output wire Pulse_out
);
    reg Q;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            Q<='b0;
        end else begin
            Q<=Signal_in;
        end
    end

    assign Pulse_out= ((~Q) & Signal_in);

endmodule