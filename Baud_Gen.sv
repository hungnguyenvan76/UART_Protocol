module Baud_Gen #(
    parameter int BAUD_RATE = 921600;
    parameter int OVERSAMPLE = 16;
    parameter int CLK_FREQ = 100_000_000;
) (
    input  logic clk,
    input  logic reset,
    output logic BCLK
)

    localparam int Final_value = (CLK_FREQ / (BAUD_RATE * OVERSAMPLE)) + 0.5;
    localparam logic [15:0] DIVISOR = 16'(Final_value);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            BCLK    <= 1b'0;
            counter <= '0;
        end
        else if (counter == (DIVISOR - 16'd1)) begin
            BCLK    <= 1'b1;
            counter <= '0;
        end
        else begin
            BCLK    <= 1b'0;
            counter <= counter + 1;
        end
    end
endmodule
