import UART_pkg::*;

module UART_Top 
(
    input  logic                  UCLK,      
    input  logic                  reset_n,      

    // SYSTEM BUS INTERFACE 
    // Write (CPU send data to UART)
    input  logic [DATA_WIDTH-1:0] W_data,     
    input  logic                  wr_uart,    // Write Enable
    output logic                  tx_full,    

    // Read (CPU read data from UART)
    output logic [DATA_WIDTH-1:0] R_data,     
    input  logic                  rd_uart,    // Read Enable
    output logic                  rx_empty,   

    // PHYSICAL INTERFACE 
    input  logic                  rx,         // Wire serial receive
    output logic                  tx          // Wire serial transmit
);


    logic BCLK; // TX & RX

    // BAUD GENERATOR
    Baud_Gen baud_generator_blk (
        .clk     (UCLK),
        .reset_n (reset_n),
        .BCLK    (BCLK)
    );

    TX_Top tx_top_blk (
        .UCLK    (UCLK),
        .BCLK    (BCLK),
        .reset_n (reset_n),
        .W_data  (W_data),
        .wr_uart (wr_uart),
        .tx_full (tx_full),
        .tx      (tx)          
    );

    // RECEIVE DATA  RX_TOP
    RX_Top rx_top_blk (
        .UCLK     (UCLK),
        .BCLK     (BCLK),
        .reset_n  (reset_n),
        .rx       (rx),        
        .R_data   (R_data),
        .rd_uart  (rd_uart),
        .rx_empty (rx_empty)
    );

endmodule
