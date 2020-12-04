
/* parameters.v */


`define ClkFreq     50000000
`define ClkPeri     0.00000002
// `define ClkFreq     1000000
// `define ClkPeri     0.000001

`define SoundFreq   44100
`define SoundPeri   0.0000226757



`define DelayDataWidth 16
`define DelayAddrWidth 3
`define DelayDepth ( 1 << `DelayAddrWidth ) // 8


`timescale 1s/1ns
