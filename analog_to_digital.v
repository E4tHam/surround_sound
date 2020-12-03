
/* analog_to_digital.v */

`timescale 1s/1ms


module AtoD
# (
    parameter FILE_LENGTH = 64
)
(
    output   [15:0] digital
);

    // black box
    reg  [15:0] BB [FILE_LENGTH-1:0];
    
    assign digital = BB[i];

    integer i = 0;
    always #0.5 i = (i + 1) % FILE_LENGTH;


    // initialize BB with instructions
    initial begin
        $readmemh( "wave.dat", BB );
        i = 0;
    end


endmodule
