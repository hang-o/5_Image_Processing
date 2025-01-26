`timescale 1ns / 1ps
module conv(
input i_clk,
// 24 pixels * 3 line buffers
input [71:0]i_pixel_data, // 8bit * 9pixel. data comming from line buffer.
input        i_pixel_data_valid,
output reg [7:0] o_convolved_data,
output reg   o_convolved_data_valid
    );
    
integer i; 
reg [7:0] kernel [8:0]; // kernel value.
reg [15:0] multData[8:0]; // 8bit * 8bit = 16bit. 
reg [15:0] sumDataInt;
reg [15:0] sumData;
reg multDataValid;
reg sumDataValid;
reg convolved_data_valid;

initial
begin
    for(i=0;i<9;i=i+1)
    begin
        kernel[i] = 1;
    end
end    
    
always @(posedge i_clk)
begin
    for(i=0;i<9;i=i+1)
    begin
        multData[i] <= kernel[i]*i_pixel_data[i*8+:8];
    end
    multDataValid <= i_pixel_data_valid; // pipelining for data processing
end

// sumDataInt : sum Data Intermmeditae. summation multData[i]
always @(*)
begin
    sumDataInt = 0;
    for(i=0;i<9;i=i+1)
    begin
        sumDataInt = sumDataInt + multData[i];
    end
end

// for timing constraint
always @(posedge i_clk)
begin
    sumData <= sumDataInt;
    sumDataValid <= multDataValid; // pipelining for data processing
end
    
always @(posedge i_clk)
begin
    o_convolved_data <= sumData/9;
    o_convolved_data_valid <= sumDataValid; // pipelining for data processing
end
    
endmodule
