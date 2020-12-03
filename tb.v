
/* tb.v */

`include "mem.v"
`include "analog_to_digital.v"
`timescale 1s/1ms

module testbench () ;


/* 1 Hz Clock */
reg clk = 1;
always #0.5 clk = ~clk;


/* RAM */
reg   [2:0] address ; // Address input
wire [15:0] data    ; // Data I/O
reg         WE      ; // Write Enable
reg         OE      ; // Output Enable

RAM memory (
    .address( address ) ,
    .data( data )       ,
    .WE( WE )           ,
    .OE( OE )
);

reg  [15:0] data_write;
assign data = ( ~OE & WE )  ? data_write
            : 'hz
;


/* AtoD */
wire  [15:0] digital;
AtoD sound (
    .digital( digital )
);

/* Test */
initial begin
$dumpfile ( "dump.vcd" ) ;
$dumpvars ( );
//\\ =========================== \\//



#10

//\\ =========================== \\//
$finish ;
end

endmodule
