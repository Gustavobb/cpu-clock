LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY divider IS
    GENERIC (divisor : NATURAL := 25000000);
    PORT (
        clk : IN STD_LOGIC;
        outputClk : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE divInteiro OF divider IS
    SIGNAL tick : STD_LOGIC := '0';
    SIGNAL contador : INTEGER RANGE 0 TO divisor + 1 := 0;
BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF contador = divisor THEN
                contador <= 0;
                tick <= NOT tick;
            ELSE
                contador <= contador + 1;
            END IF;
        END IF;
    END PROCESS;
    outputClk <= tick;
END ARCHITECTURE divInteiro;