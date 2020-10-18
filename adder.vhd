LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY adder IS
    GENERIC (
        dataWidth : NATURAL := 8
    );
    PORT (
        A, B : IN STD_LOGIC_VECTOR((dataWidth - 1) DOWNTO 0);
        output : OUT STD_LOGIC_VECTOR((dataWidth - 1) DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavior OF adder IS
BEGIN
    output <= STD_LOGIC_VECTOR(unsigned(A) + unsigned(B));
END ARCHITECTURE;