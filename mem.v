
/* mem.v */


module RAM
# (
    parameter   ADDR_WIDTH  = 3 ,
    parameter   DEPTH       = 8 ,
    parameter   DATA_WIDTH  = 16
) (
    input  [ADDR_WIDTH-1:0] address , // Address input
    inout  [DATA_WIDTH-1:0] data    , // Data I/O
    input                   WE      , // Write Enable
    input                   OE        // Output Enable
);


    reg [DATA_WIDTH-1:0] MEM [DEPTH-1:0] ;

    // data is output only when OE==1
    assign data = ( ~WE & OE ) ? MEM[address]
                : 'bz
    ;

    // if WE, MEM[address] = data
    always @ *
        if ( WE & ~OE )
            MEM[address] <= data;

    // if WE and OE, display "ERROR"
    always @ *
        if ( WE & OE )
            $display( "RAM ERROR: OE and WE both active" );

    // data initialized to all 1s
    integer i;
    initial for ( i = 0; i < DEPTH; i = i+1 ) begin
        MEM[i] <= { DATA_WIDTH{1'b1} } ;
        // Make MEM values visible in GTKWave
        $dumpvars( 1, MEM[i] );
    end

endmodule
