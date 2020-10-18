LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY dividerInterface IS
   PORT (
      clk : IN STD_LOGIC;
      habilitaLeitura : IN STD_LOGIC;
      limpaLeitura : IN STD_LOGIC;
      timeSelector : IN STD_LOGIC;
      leituraUmSegundo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)

   );
END ENTITY;

ARCHITECTURE interface OF dividerInterface IS
   SIGNAL sinalUmSegundo : STD_LOGIC;
   SIGNAL saidaNormal, saidaFast, saidaclk_reg1seg : STD_LOGIC;

	-- Opções de clock para alternar a base de tempo
   CONSTANT fastDivisor : NATURAL := 31250;
   CONSTANT divisor : NATURAL := 25000000;

BEGIN

   tempo : ENTITY work.divider
      GENERIC MAP(divisor => divisor)
      PORT MAP(
         clk => clk,
         outputClk => saidaNormal);

   tempoFast : ENTITY work.divider
      GENERIC MAP(divisor => fastDivisor)
      PORT MAP(
         clk => clk,
         outputClk => saidaFast);

   saidaclk_reg1seg <= saidaFast WHEN timeSelector = '1' ELSE
      saidaNormal;

   registraUmSegundo : ENTITY work.flipFlop
      PORT MAP(
         DIN => '1', DOUT => sinalUmSegundo,
         ENABLE => '1', CLK => saidaclk_reg1seg,
         RST => limpaLeitura);

   -- Faz o tristate de saida:
   leituraUmSegundo <= ("0000000" & sinalUmSegundo) WHEN habilitaLeitura = '1' ELSE
      (OTHERS => 'Z');

END ARCHITECTURE interface;