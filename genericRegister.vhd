LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY genericRegister IS
    GENERIC (
        dataWidth : NATURAL := 8
    );
    PORT (
        DIN : IN STD_LOGIC_VECTOR(dataWidth - 1 DOWNTO 0);
        DOUT : OUT STD_LOGIC_VECTOR(dataWidth - 1 DOWNTO 0);
        ENABLE : IN STD_LOGIC;
        CLK, RST, w : IN STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavior OF genericRegister IS
BEGIN
    PROCESS (RST, CLK)
    BEGIN
        IF (RST = '1') THEN
            DOUT <= (OTHERS => '0');
        ELSE
            IF (rising_edge(CLK)) THEN
                IF (ENABLE = '1' AND w = '1') THEN
                    DOUT <= DIN;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;