
/* delay.v */


`include "modules/delaymem.v"
`include "modules/delayraminterface.v"
`include "modules/delaydampener.v"
`include "modules/CLK_44kHz.v"


module Delay (
    input           clk         ,
    input     [7:0] theta       ,
    input     [7:0] distance    ,
    input    [15:0] signal_in   ,
    output   [15:0] signal_out
);

    /* 44 kHz CLK */
    wire clk_s;
    CLK_44kHz clk_converter (
        .clkIn( clk )   ,
        .clkOut( clk_s )
    );

    /* Dampener */
    wire  [7:0] damp    ;
    Dampener damp_value (
        .theta( theta )         ,
        .distance( distance )   ,
        .damp( damp )
    );


    /* RAM */
    wire  [2:0] address ; // Address input
    wire [15:0] data    ; // Data I/O
    wire        WE      ; // Write Enable
    wire        OE      ; // Output Enable

    RAM memory (
        .address( address ) ,
        .data( data )       ,
        .WE( WE )           ,
        .OE( OE )
    );


    /* RAM Interface */
    RAM_Interface interface (
        .clk( clk_s )               ,
        .damp( damp )               ,
        .distance( distance )       ,
        .signal_in( signal_in )     ,
        .signal_out( signal_out )   ,

        .address( address )         ,
        .data( data )               ,
        .WE( WE )                   ,
        .OE( OE )
    );

endmodule
