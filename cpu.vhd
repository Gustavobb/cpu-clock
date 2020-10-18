LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- CPU elaborada pela unidade de controle e o fluxo de dados 

ENTITY cpu IS
  GENERIC (
    DATA_WIDTH : NATURAL := 16;
    ADDR_WIDTH : NATURAL := 12
  );

  PORT (
    -- Input ports
    clk : IN STD_LOGIC;
    data_input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    --leituraSegundo : IN STD_LOGIC;

    -- Output ports
    address : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    data_output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    w : OUT STD_LOGIC;
    r : OUT STD_LOGIC;
    instructionOutput : OUT STD_LOGIC_VECTOR(26 DOWNTO 0)
  );
END ENTITY;
ARCHITECTURE arch_name OF cpu IS
  SIGNAL palavraControle : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL instruction : STD_LOGIC_VECTOR(26 DOWNTO 0);
  SIGNAL flagZeroCpu : STD_LOGIC;

  ALIAS opCode : STD_LOGIC_VECTOR(3 DOWNTO 0) IS instruction(26 DOWNTO 23);

BEGIN

--Fluxo de dados
  FD : ENTITY work.dataflow
    PORT MAP(
      clk => clk,
      controlMuxPC => palavraControle(8), --Seletor do mux PC
      controlmuxULAImediato => palavraControle(7), --Seletor do mux ULA
      controlmuxImediatoRAM => palavraControle(6), --Seletor do mux RAM
      controlRegisterDatabase => palavraControle(5), --Habilita escrita em C no banco de registradores
      seletorUla => palavraControle(4 DOWNTO 2),
      habLeituraMEM => palavraControle(1),
      habEscritaMEM => palavraControle(0),
      instruction => instruction,
      flagZeroOutput => flagZeroCpu,
      data_input => data_input,
      output => data_output);
		
--Unidade de controle
  UC : ENTITY work.controlUnit GENERIC MAP (DATA_WIDTH => DATA_WIDTH, ADDR_WIDTH => ADDR_WIDTH)
    PORT MAP(
      palavraControle => palavraControle, --Output com a palavra controle
      opCode => opCode,
      flagZeroCU => flagZeroCpu);

  address <= instruction(7 DOWNTO 0);
  w <= palavraControle(0); --Utilizado no toplevel para habilitar escrita no registrador para o display e na ram
  r <= palavraControle(1); --Utilizado no toplevel para habilitar leitura para ram
  instructionOutput <= instruction;

END ARCHITECTURE;