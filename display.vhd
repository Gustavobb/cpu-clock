LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY display IS
    PORT (
        -- Input ports
        data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        -- Output ports
        output : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavior OF display IS
    --
    --       0
    --      ---
    --     |   |
    --    5|   |1
    --     | 6 |
    --      ---
    --     |   |
    --    4|   |2
    --     |   |
    --      ---
    --       3
    --
    SIGNAL preOutput : STD_LOGIC_VECTOR(6 DOWNTO 0);
BEGIN
    preOutput <= "1000000" WHEN data = "0000" ELSE ---0
        "1111001" WHEN data = "0001" ELSE ---1
        "0100100" WHEN data = "0010" ELSE ---2
        "0110000" WHEN data = "0011" ELSE ---3
        "0011001" WHEN data = "0100" ELSE ---4
        "0010010" WHEN data = "0101" ELSE ---5
        "0000010" WHEN data = "0110" ELSE ---6
        "1111000" WHEN data = "0111" ELSE ---7
        "0000000" WHEN data = "1000" ELSE ---8
        "0010000" WHEN data = "1001" ELSE ---9
        "1111111"; -- Apaga todos segmentos.
    output <= preOutput;
END ARCHITECTURE;