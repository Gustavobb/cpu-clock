LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.constants.ALL;

ENTITY controlUnit IS
  GENERIC (
    DATA_WIDTH : NATURAL := 8;
    ADDR_WIDTH : NATURAL := 8
  );

  PORT (
    -- Input ports
    opCode : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    flagZeroCU : IN STD_LOGIC;

    -- Output ports
    palavraControle : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
  );
END ENTITY;
ARCHITECTURE arch_name OF controlUnit IS
  ALIAS selMuxJumpPC : STD_LOGIC IS palavraControle(8);
  ALIAS selMuxULAImed : STD_LOGIC IS palavraControle(7);
  ALIAS selMuxRAMImed : STD_LOGIC IS palavraControle(6);
  ALIAS HabEscritaRegister : STD_LOGIC IS palavraControle(5);
  ALIAS selOperacaoULA : STD_LOGIC_VECTOR(2 DOWNTO 0) IS palavraControle(4 DOWNTO 2);
  ALIAS habLeituraMEM : STD_LOGIC IS palavraControle(1);
  ALIAS habEscritaMEM : STD_LOGIC IS palavraControle(0);

BEGIN

 --                                                                     Opcodes:

 
     --       selMuxJumpPC selMuxRAMImed  selMuxULAImed  HabEscritaRegister  selOperacaoULA  habLeituraMEM  habEscritaMEM
    -- jmp        1             1              0                0                 010              0             0
    -- add        0             1              1                1                 000              0             0
    -- sub        0             1              1                1                 001              0             0
    -- je    		1             1              0                0                 001              0             0
    -- lea      	0             1              0                1                 010              0             0 
    -- andw       0             1              1                1                 110              0             0
    -- notw       0             1              1                1                 101              0             0
    -- orw        0             1              1                1                 111              0             0
    -- store      0             1              0                0                 010              0             1
	 -- load       0             0              0                1                 010              1             0
	 
  selMuxJumpPC <= '1' WHEN (opCode = je AND flagZeroCU = '1') OR opCode = jmp ELSE 
    '0';
  selMuxRAMImed <= '0' WHEN opCode = load ELSE
    '1';
  selMuxULAImed <= '1' WHEN (opCode = add OR opCode = subw OR opCode = andw OR opCode = notw OR opCode = orw) ELSE
    '0';
  selOperacaoULA <= "000" WHEN opCode = add ELSE
    "001" WHEN (opCode = subw OR opCode = je) ELSE
    "010" WHEN opCode = load ELSE
    "101" WHEN opCode = notw ELSE
    "110" WHEN opCode = andw ELSE
    "111" WHEN opCode = orw ELSE
    "010";

  HabEscritaRegister <= '1' WHEN (opCode = add OR opCode = subw OR opCode = andw OR opCode = notw OR opCode = orw OR opCode = lea OR opCode = load) ELSE
    '0';
  habLeituraMEM <= '1' WHEN opCode = load ELSE
    '0';
  habEscritaMEM <= '1' WHEN (opCode = store) ELSE
    '0';

END ARCHITECTURE;