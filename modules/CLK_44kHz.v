
/* CLK_44kHz.v */


`include "src/parameters.v"

module CLK_44kHz
# (
    parameter   ClkInFreq   = `ClkFreq                      ,
    parameter   ClkOutFreq  = `SoundFreq                    ,
    parameter   Cycles      = ( ClkInFreq / ClkOutFreq / 2 )
) (
    input       clkIn                                       ,
    output reg  clkOut
);

    integer clki;

    initial begin
        clki    <= 0 ;
        clkOut  <= 1 ;
    end

    always @ ( posedge clkIn ) begin
        clki += 1;
        if ( clki == Cycles ) begin
            clki = 0;
            clkOut <= ~clkOut;
        end
    end

endmodule