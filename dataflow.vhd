LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

--Fluxo de dados

ENTITY dataflow IS
	GENERIC (
		DATA_WIDTH : NATURAL := 16;
		ADDR_WIDTH : NATURAL := 10
	);

	PORT (
		-- Input ports
		controlmuxPC : IN STD_LOGIC := '0'; --Seletor para o mux PC
		controlmuxULAImediato : IN STD_LOGIC := '0'; --Seletor para o mux ULA
		controlmuxImediatoRAM : IN STD_LOGIC := '0'; --Seletor para o mux RAM
		controlRegisterDatabase : IN STD_LOGIC := '0'; --Enable para escrita em C no banco de registradores
		seletorUla : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		habLeituraMEM : IN STD_LOGIC := '0';
		habEscritaMEM : IN STD_LOGIC := '0';
		data_input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		clk : IN STD_LOGIC;

		-- Output ports
		instruction : OUT STD_LOGIC_VECTOR(26 DOWNTO 0);
		output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		flagZeroOutput : OUT STD_LOGIC
	);
END ENTITY;
ARCHITECTURE arch_name OF dataflow IS
	SIGNAL saidaMuxPC, saidaMuxULAImediato, saidaMuxImediatoRam, saidaULA, saidaSum, saidaPC, saidaRegisterA, saidaRegisterB : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL preInstruction : STD_LOGIC_VECTOR(26 DOWNTO 0); 
	SIGNAL preFlagZero : STD_LOGIC;

BEGIN
	MUXPC : ENTITY work.muxGenerico2x1
		PORT MAP(
			entradaA_MUX => saidaSum,
			entradaB_MUX => preInstruction(7 DOWNTO 0),
			seletor_MUX => controlmuxPC,
			saida_MUX => saidaMuxPC);

	PC : ENTITY work.genericRegister
		PORT MAP(
			DIN => saidaMuxPC,
			DOUT => saidaPC,
			ENABLE => '1',
			w => '1',
			CLK => clk,
			RST => '0');

	ADDER : ENTITY work.adder
		PORT MAP(
			A => "00000001",
			B => saidaPC,
			output => saidaSum);

	ROM : ENTITY work.rom
		PORT MAP(
			address => saidaPC,
			data => preInstruction);

	REGISTERDATABASE : ENTITY work.registerDatabase
		PORT MAP(
			clk => clk,
			addressA => preInstruction(22 DOWNTO 18),
			addressB => preInstruction(17 DOWNTO 13),
			addressC => preInstruction(12 DOWNTO 8),
			dataWriteC => saidaMuxULAImediato,
			enableC => controlRegisterDatabase,
			outputA => saidaRegisterA,
			outputB => saidaRegisterB);

	MUXIMEDIATORAM : ENTITY work.muxGenerico2x1
		PORT MAP(
			entradaA_MUX => data_input,
			entradaB_MUX => preInstruction(7 DOWNTO 0),
			seletor_MUX => controlmuxImediatoRAM,
			saida_MUX => saidaMuxImediatoRam);

	MUXULAIMEDIATO : ENTITY work.muxGenerico2x1
		PORT MAP(
			entradaA_MUX => saidaMuxImediatoRam,
			entradaB_MUX => saidaULA,
			seletor_MUX => controlmuxULAImediato,
			saida_MUX => saidaMuxULAImediato);

	ULA : ENTITY work.ula
		PORT MAP(
			entradaA => saidaRegisterA,
			entradaB => saidaRegisterB,
			seletor => seletorUla,
			saida => saidaULA,
			flagZero => flagZeroOutput);

	instruction <= preInstruction;
	output <= saidaRegisterB;

END ARCHITECTURE;