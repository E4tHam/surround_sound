
/* parameters.v */


// `define ClkFreq     50000000
`define ClkFreq     1000000
`define ClkPeri     ( 1.0 / `ClkFreq )

`define SoundFreq   44100
`define SoundPeri   ( 1.0 / `SoundFreq )



`define DelayDataWidth 16
`define DelayAddrWidth 3
`define DelayDepth ( 1 << `DelayAddrWidth ) // 8


`timescale 1s/1ns
