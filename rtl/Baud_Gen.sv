import UART_pkg::*;

module Baud_Gen #(
    parameter int BAUD_RATE = 921600,
    parameter int CLK_FREQ = 100_000_000
) (
    input  logic clk,
    input  logic reset_n,
    output logic BCLK
);

    localparam int Final_value = (CLK_FREQ / (BAUD_RATE * OVERSAMPLE)) + 0.5;
    localparam logic [15:0] DIVISOR = 16'(Final_value);
    
    logic [15:0] counter;
    
    always_ff @(posedge clk or posedge reset_n) begin
        if (reset_n == 1'b0) begin
            BCLK    <= 1'b0;
            counter <= '0;
        end
        else if (counter == (DIVISOR - 16'd1)) begin
            BCLK    <= 1'b1;
            counter <= '0;
        end
        else begin
            BCLK    <= 1'b0;
            counter <= counter + 1;
        end
    end
endmodule
