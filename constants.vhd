LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE constants IS

    CONSTANT OPCODE_WIDHT : NATURAL := 4;
    CONSTANT REG_WIDHT : NATURAL := 5;
    SUBTYPE opCode IS STD_LOGIC_VECTOR(OPCODE_WIDHT - 1 DOWNTO 0);
    SUBTYPE registers IS STD_LOGIC_VECTOR(REG_WIDHT - 1 DOWNTO 0);

	 -- Constantes das instruções do Opcode.
    CONSTANT lea : opCode := "0000";
    CONSTANT add : opCode := "0001";
    CONSTANT subw : opCode := "0010";
    CONSTANT store : opCode := "0011";
    CONSTANT mov : opCode := "0100";
    CONSTANT load : opCode := "0101";
    CONSTANT jmp : opCode := "0110";
    CONSTANT andw : opCode := "1100";
    CONSTANT orw : opCode := "1110";
    CONSTANT je : opCode := "1001";
    CONSTANT notw : opCode := "1010";
    CONSTANT nop : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";

	 -- Constantes dos registradores.
    CONSTANT R00 : registers := "00000";
    CONSTANT R01 : registers := "00001";
    CONSTANT R02 : registers := "00010";
    CONSTANT R03 : registers := "00011";
    CONSTANT R04 : registers := "00100";
    CONSTANT R05 : registers := "00101";
    CONSTANT R06 : registers := "00110";
    CONSTANT R07 : registers := "00111";
    CONSTANT R08 : registers := "01000";
    CONSTANT R09 : registers := "01001";
    CONSTANT R10 : registers := "01010";
    CONSTANT R11 : registers := "01011";
    CONSTANT R12 : registers := "01100";
    CONSTANT R13 : registers := "01101";
    CONSTANT R14 : registers := "01110";
    CONSTANT R15 : registers := "01111";
    CONSTANT R16 : registers := "10000";
    CONSTANT R17 : registers := "10001";
    CONSTANT R18 : registers := "10010";
    CONSTANT R19 : registers := "10011";
    CONSTANT R20 : registers := "10100";
    CONSTANT R21 : registers := "10101";
    CONSTANT R22 : registers := "10110";
    CONSTANT R23 : registers := "10111";
    CONSTANT R24 : registers := "11000";
    CONSTANT R25 : registers := "11001";
    CONSTANT R26 : registers := "11010";
    CONSTANT R27 : registers := "11011";
    CONSTANT R28 : registers := "11100";
    CONSTANT R29 : registers := "11101";
    CONSTANT R30 : registers := "11110";
    CONSTANT R31 : registers := "11111";

END PACKAGE constants;