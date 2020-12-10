
/* delaydampener.v */


module Dampener (
    input     [7:0] theta       ,
    input     [7:0] distance    ,
    output    [7:0] damp
);
    /* https://www.desmos.com/calculator/ivhkp9vjnw */
    integer at;
    assign damp = at;
    always @ *
        at = 262.781 - ( 738152.288 / ( distance + 53 )**2 );

endmodule
