
/* delaymem.v */


`include "src/parameters.v"

module RAM
# (
    parameter   DATA_WIDTH  = `DelayDataWidth   ,
    parameter   ADDR_WIDTH  = `DelayAddrWidth   ,
    parameter   DEPTH       = `DelayDepth
) (
    input  [ADDR_WIDTH-1:0] address , // Address input
    inout  [DATA_WIDTH-1:0] data    , // Data I/O
    input                   WE      , // Write Enable
    input                   OE        // Output Enable
);


    reg [DATA_WIDTH-1:0] MEM [0:DEPTH-1] ;

    // data is output only when OE==1
    assign data = ( ~WE & OE ) ? MEM[address]
                : 'Bz
    ;

    always @ * begin
        // if WE, MEM[address] = data
        if ( WE & ~OE )
            MEM[address] <= data;
        // if WE and OE, display "ERROR"
        if ( WE & OE )
            $display( "RAM ERROR: OE and WE both active" );
    end

    // data initialized to all 1s
    integer i;
    initial for ( i = 0; i < DEPTH; i = i+1 ) begin
        // MEM[i] <= { DATA_WIDTH{1'b1} } ;
        // Make MEM values visible in GTKWave
        $dumpvars( 1, MEM[i] );
    end

endmodule
