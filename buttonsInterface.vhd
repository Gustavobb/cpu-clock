LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY buttonsInterface IS
   PORT (
      input  : IN STD_LOGIC_VECTOR(3 downto 0);
		buttons  : IN STD_LOGIC_VECTOR(3 downto 0);
      output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   );
END ENTITY;

ARCHITECTURE interface OF buttonsInterface IS
  
BEGIN
    output <= "0000000" & NOT buttons(3) WHEN input(0) = '1' ELSE -- hour
    "0000000" & NOT buttons(2) WHEN input(1) = '1' ELSE -- min
    "0000000" & NOT buttons(1) WHEN input(2) = '1' ELSE -- sec
    "0000000" & buttons(0) WHEN input(3) = '1' ELSE -- ok
    (OTHERS => 'Z');

END ARCHITECTURE interface;