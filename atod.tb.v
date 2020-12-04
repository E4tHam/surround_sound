
/* atod.tb.v */

`include "modules/misc/atod.v"
`timescale 1s/1ms

module testbench () ;


/* 1 Hz Clock */
reg clk = 1;
always #0.5 clk = ~clk;


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




//\\ =========================== \\//
$finish ;
end

endmodule
