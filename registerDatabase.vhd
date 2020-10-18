LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY registerDatabase IS
    GENERIC (
        dataWidth : NATURAL := 8;
        addressWidth : NATURAL := 5
    );
    PORT (
        clk : IN STD_LOGIC;
        addressA : IN STD_LOGIC_VECTOR((addressWidth - 1) DOWNTO 0);
        addressB : IN STD_LOGIC_VECTOR((addressWidth - 1) DOWNTO 0);
        addressC : IN STD_LOGIC_VECTOR((addressWidth - 1) DOWNTO 0);
        dataWriteC : IN STD_LOGIC_VECTOR((dataWidth - 1) DOWNTO 0);
        enableC : IN STD_LOGIC := '0';

        outputA : OUT STD_LOGIC_VECTOR((dataWidth - 1) DOWNTO 0);
        outputB : OUT STD_LOGIC_VECTOR((dataWidth - 1) DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavior OF registerDatabase IS

    SUBTYPE palavra_t IS STD_LOGIC_VECTOR((dataWidth - 1) DOWNTO 0);
    TYPE memoria_t IS ARRAY(2 ** addressWidth - 1 DOWNTO 0) OF palavra_t;
    SHARED VARIABLE registrador : memoria_t;

BEGIN
    PROCESS (clk) IS
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (enableC = '1') THEN
                registrador(to_integer(unsigned(addressC))) := dataWriteC;
            END IF;
        END IF;
    END PROCESS;
    outputA <= registrador(to_integer(unsigned(addressA)));
    outputB <= registrador(to_integer(unsigned(addressB)));
END ARCHITECTURE;