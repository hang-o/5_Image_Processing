lineBuffer.v

# Signal

i_clk : clock

i_rst : reset (negedge)

[7:0]i_data : input pixel(8bit)

i_data_valid : valid signal for i_dawta

[23:0] o_data : 3 pixel output(24bit)

i_rd_data : indicate data should be read from the line buffer. like axi ready signal for slave

## description

line bufffer for image processing

reg [7:0] line[511:0] : line buffer 8bit * 512 pixel

reg [8:0] wrPntr : write pointer. 9bit. express decimal 512

reg [8:0] rdPntr : read pointer. 9bit. express decimal 512


## Simulation

![image](https://github.com/hang-o/5_Image_Processing/blob/main/lineBuffer/lineBuffer_simulation.png)


# 개선해야할 부분

parameter  SIZE = 512;

reg [7:0] line[SIZE-1:0];

reg [$clog2(SIZE)-1:0] wrPntr;

reg [$clog2(SIZE)-1:0] rdPntr;


