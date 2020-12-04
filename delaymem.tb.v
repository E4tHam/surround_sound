
/* delaymem.tb.v */


`include "modules/delaymem.v"
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


/* Test */
initial begin
$dumpfile ( "dump.vcd" ) ;
$dumpvars ( );
//\\ =========================== \\//




//\\ =========================== \\//
$finish ;
end

endmodule
