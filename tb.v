
/* delay.tb.v */

`include "modules/delay.v"
`include "modules/misc/atod.v"
`include "src/parameters.v"


module testbench () ;


/* 44.1 kHz Clock */

// 50 MHz Clock
reg clk = 1;
always #( `ClkPeri / 2 ) clk = ~clk;

/* Delay */

reg       [7:0] theta           ;
reg       [7:0] distance        ;
wire     [15:0] signal_in       ;
wire     [15:0] signal_out      ;

Delay DELAY_BOX (
    .clk( clk )                 ,
    .theta( theta )             ,
    .distance( distance )       ,
    .signal_in( signal_in )     ,
    .signal_out( signal_out )
);

/* AtoD */
AtoD sound (
    .digital( signal_in )
);


/* Test */
integer i;
initial begin
$dumpfile ( "dump.vcd" ) ;
$dumpvars ( );
//\\ =========================== \\//

theta = 'H00;
distance = 'D0;

// #( 50 * `SoundPeri )

for ( i = 0; i < 255; i++ ) begin
    distance += 1;
    #( `SoundPeri );
end


//\\ =========================== \\//
$finish ;
end

endmodule
