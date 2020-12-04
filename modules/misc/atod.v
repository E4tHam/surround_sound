
/* analog_to_digital.v */


`include "src/parameters.v"


module AtoD
# (
    parameter FILE_LENGTH = ( 1 * `SoundFreq )
)
(
    output   [15:0] digital
);

    // black box
    reg  [15:0] BB [0:FILE_LENGTH-1];

    assign digital = BB[i];

    integer i = 0;
    always #( `SoundPeri )
        i = (i + 1) % FILE_LENGTH;


    // initialize BB with instructions
    initial begin
        $readmemh( "src/wave.dat", BB );
        i = 0;
    end


endmodule
