
// Convenient stuff

parameter ZERO  =  1'b0;
parameter FALSE =  1'b0;
parameter ONE   =  1'b1;
parameter TRUE  =  1'b1;

// Control signals

parameter CONTROL_SIGNALS = 16;

parameter PCI   =  0; // Program counter in
parameter PCO   =  1; // Program counter out
parameter PCS   =  2; // Program counter step
parameter AI    =  3; // A register in
parameter AO    =  4; // A register out
parameter BI    =  5; // B register in
parameter BO    =  6; // B register out
parameter MAI   =  7; // Memory address register in
parameter MI    =  8; // Memory in
parameter MO    =  9; // Memory out
parameter II    = 10; // Instruction register in
parameter OI    = 11; // Operand register in
parameter ALO   = 12; // ALU out
parameter ALS   = 13; // ALU subtract
parameter OUI   = 14; // Out register in

// Instructions

parameter NOP   =  0; // No operation
parameter LDA   =  1; // Load A from memory address
parameter ADD   =  2; // Add value from address to A 
parameter SUB   =  3; // Subtract value from address from A
parameter STA   =  4; // Store A to address
parameter LDI   =  5; // Load value into A
parameter JMP   =  6; // Jump to address
parameter OUT   =  7; // A to out
