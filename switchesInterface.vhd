LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY switchesInterface IS
   PORT (
      input  : IN STD_LOGIC_VECTOR(8 downto 0);
		switches  : IN STD_LOGIC_VECTOR(9 downto 0);
      output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   );
END ENTITY;

ARCHITECTURE interface OF switchesInterface IS
  
BEGIN
	 output <= "0000000" & switches(0) WHEN input(0) = '1' ELSE
    "0000000" & switches(1) WHEN input(1) = '1' ELSE
    "0000000" & switches(2) WHEN input(2) = '1' ELSE
    "0000000" & switches(3) WHEN input(3) = '1' ELSE
    "0000000" & switches(4) WHEN input(4) = '1' ELSE
    "0000000" & switches(5) WHEN input(5) = '1' ELSE
    "0000000" & switches(6) WHEN input(6) = '1' ELSE
    "0000000" & switches(7) WHEN input(7) = '1' ELSE
    "0000000" & switches(8) WHEN input(8) = '1' ELSE
    (OTHERS => 'Z');

END ARCHITECTURE interface;