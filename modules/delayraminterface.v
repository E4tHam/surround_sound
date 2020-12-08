
/* delayraminterface.v */


`include "src/parameters.v"

module RAM_Interface (
    input           clk         ,
    input     [7:0] damp        ,
    input     [7:0] distance    ,
    input    [15:0] signal_in   ,
    output   [15:0] signal_out  ,

    output[`DelayAddrWidth-1:0] address     , // Address input
    inout [`DelayDataWidth-1:0] data        , // Data I/O
    output                      WE          , // Write Enable
    output                      OE            // Output Enable
);


    reg   [`DelayDataWidth-1:0] data_write;
    assign data = ( ~OE & WE )  ? data_write
                : 'hz
    ;

    wire  [`DelayAddrWidth-1:0] read_address;// address of the sample out
    reg   [`DelayAddrWidth-1:0] load_address;// address of the current sample

    reg   [`DelayDataWidth-1:0] read_sample;
    reg   [`DelayDataWidth-1:0] current_sample;

    assign signal_out = read_sample;

    initial begin
        load_address = 0;
        current_sample = 0;
    end

    assign read_address = ( `DelayDepth + load_address - distance ) % `DelayDepth;

    // handle reading and writing from ram
    reg ramfunction;
    assign address = ( ramfunction )    ? load_address  : read_address  ;
    assign WE      = ( ramfunction )    ? 1             : 0             ;
    assign OE      = ( ramfunction )    ? 0             : 1             ;


    integer at;

    // on each new sample:
    always @ ( posedge clk ) begin
        // do a weighted average of current sample with previous sample
        at = current_sample - signal_in;
        at *= damp;
        at /= 255;
        at += signal_in;
        current_sample = at;

        // put that new sample into ram
        ramfunction = 1;
        data_write = current_sample;

        @ ( negedge clk );

        // find read sample
        ramfunction = 0;
        #0.00000002
        read_sample = data; // outputs to signal_out

        // increment
        load_address = ( load_address + 1 ) % `DelayDepth;
    end

endmodule
