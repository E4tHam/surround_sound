
/* delaydampener.v */


module Dampener (
    input     [7:0] theta       ,
    output    [7:0] damp
);
    reg     [7:0] temp;
    assign damp = temp;
    always @ *
        temp = theta;

endmodule
