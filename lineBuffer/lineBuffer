`timescale 1ns / 1ps
module lineBuffer(
input   i_clk,
input   i_rst,
input [7:0] i_data,
input   i_data_valid,
output [23:0] o_data,
input   i_rd_data   // indicate data should be read from the line buffer. like axi ready signal\
);


reg [7:0] line[511:0];  // line buffer. 8bit pixel * 512
reg [8:0] wrPntr; // write pointer
reg [8:0] rdPntr;

always @ (posedge i_clk or negedge i_rst) begin
    if(i_data_valid)
        line[wrPntr] <= i_data;
end

always @ (posedge i_clk or negedge i_rst) begin
    if(!i_rst)
        wrPntr <= 'd0;
    else if(i_data_valid)
        wrPntr <= wrPntr + 'd1;
    else
        wrPntr <= wrPntr;
end

always @ (posedge i_clk or negedge i_rst) begin
    if(!i_rst)
        rdPntr <= 'd0;
    else if(i_rd_data)
        rdPntr <= rdPntr + 'd1;
    else
        rdPntr <= rdPntr;
end

assign o_data = {line[rdPntr], line[rdPntr+1], line[rdPntr+2]};

endmodule

