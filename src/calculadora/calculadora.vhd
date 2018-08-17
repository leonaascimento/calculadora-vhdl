library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculadora is
	generic (bit_size : natural := 8; bcd_size_in_bytes : integer := 4);
	port (clock_50 : in std_logic;
			key : in std_logic_vector (3 downto 0);
			sw : in std_logic_vector (9 downto 0);
			ledg : out std_logic_vector (7 downto 0);
			ledr : out std_logic_vector (9 downto 0);
			hex3, hex2, hex1, hex0 : out std_logic_vector (6 downto 0);
			
			result : buffer signed(bit_size - 1 downto 0);
			overflow : buffer std_logic;
			pwm_duty : buffer std_logic_vector(bit_size - 1 downto 0);
			operator : buffer std_logic_vector(1 downto 0);
			set_operator : buffer std_logic;
			aux_result, aux_first, aux_second : buffer signed(bit_size - 1 downto 0);
			stack_push_value : buffer signed(bit_size - 1 downto 0);
			stack_push, stack_pop : buffer std_logic);
end calculadora;

architecture behavior of calculadora is
	component arithmetic is
		generic (bit_size : natural := 8);
		port (
			op : in std_logic_vector(1 downto 0);
			first, second : in signed(bit_size - 1 downto 0);
			result : out signed(bit_size - 1 downto 0);
			overflow : out std_logic);
	end component;
	
	component latch_d is
		generic (bit_size : natural := 8);
		port (enable : in std_logic;
				d : in std_logic_vector(bit_size - 1 downto 0);
				q : out std_logic_vector(bit_size - 1 downto 0));
	end component;
	
	component stack is
		generic (stack_size : natural := 16; bit_size : natural := 8);
		port (
			clk, reset : in std_logic;
			push, pop : in std_logic;
			push_value : in signed(bit_size - 1 downto 0);
			pop_first, pop_second : out signed(bit_size - 1 downto 0));
	end component;
	
	component operator_adapter is
	port (
		clk : in std_logic;
		in_operator : in std_logic_vector(3 downto 0);
		set_operator : out std_logic;
		out_operator : out std_logic_vector(1 downto 0));
	end component;

	component controller is
		generic (bit_size : natural := 8);
		port (
			clk, reset, set_operand, set_operator : in std_logic;
			operand : in signed(bit_size - 1 downto 0);
			result : in signed(bit_size - 1 downto 0);
			stack_push, stack_pop : out std_logic;
			stack_push_value : out signed(bit_size - 1 downto 0));
	end component;
	
	--signal result : signed(bit_size - 1 downto 0);
	--signal overflow : std_logic;
	--signal pwm_duty : std_logic_vector(bit_size - 1 downto 0);
	
	--signal stack_push_value : signed(bit_size - 1 downto 0);
	--signal stack_push, stack_pop : std_logic;
	--signal operator : std_logic_vector(1 downto 0);
	--signal set_operator : std_logic;
	--signal aux_result, aux_first, aux_second : signed(bit_size - 1 downto 0);
	
	signal aux_bcd : std_logic_vector(bcd_size_in_bytes * 4 - 1 downto 0);
	signal aux_hex3, aux_hex2, aux_hex1, aux_hex0 : std_logic_vector (6 downto 0);
	signal pwm_out : std_logic;
	signal pwm_bar : std_logic_vector (0 to 6);
	
	component double_dabble is
		generic	(bin_size_in_bits : integer := 8;
					 bcd_size_in_bytes : integer := 4);			
		port		(bin : in std_logic_vector(bin_size_in_bits - 1 downto 0);
					 bcd : out std_logic_vector(bcd_size_in_bytes * 4 - 1 downto 0));
	end component;
	
	component display7seg is
		port (bcd : in std_logic_vector (3 downto 0);
				seg : out std_logic_vector (0 to 6));
	end component;
	
	component pwm_module is
		port (clk, enable, reset : in std_logic;
				duty : in std_logic_vector (7 downto 0);
				pwm_out : out std_logic);
	end component;
begin
	ledg <= (others => overflow);
	ledr <= (others => aux_result(aux_result'high));
	result <= aux_result;
	
	pwm0: pwm_module port map(
		clk => clock_50,
		enable => '0',
		reset => '0',
		duty => pwm_duty,
		pwm_out => pwm_out);
	
	dd0: double_dabble port map(
		bin => std_logic_vector(unsigned(aux_result)),
		bcd => aux_bcd);
		
	ds0: display7seg port map(
		bcd => aux_bcd(3 downto 0),
		seg => aux_hex0);
	ds1: display7seg port map(
		bcd => aux_bcd(7 downto 4),
		seg => aux_hex1);
	ds2: display7seg port map(
		bcd => aux_bcd(11 downto 8),
		seg => aux_hex2);
	ds3: display7seg port map(
		bcd => aux_bcd(15 downto 12),
		seg => aux_hex3);
		
	pwm_bar <= (others => pwm_out);
	hex0 <= not (aux_hex0 and pwm_bar);
	hex1 <= not (aux_hex1 and pwm_bar);
	hex2 <= not (aux_hex2 and pwm_bar);
	hex3 <= not (aux_hex3 and pwm_bar);
	
	mem0: latch_d port map(
		enable	=> sw(9),
		d			=> sw(8 downto 1),
		q			=> pwm_duty);
	
	ctrl0: controller port map(
		clk 					=> clock_50,
		reset 				=> '0',
		set_operand 		=> sw(0),
		set_operator 		=> set_operator,
		operand 				=> signed(sw(8 downto 1)),
		result				=> aux_result,
		stack_push			=> stack_push,
		stack_pop			=> stack_pop,
		stack_push_value	=> stack_push_value);
		
	stk0: stack port map(
		clk			=> clock_50,
		reset			=> '0',
		push			=> stack_push,
		pop			=> stack_pop,
		push_value	=> stack_push_value,
		pop_first	=> aux_first,
		pop_second	=> aux_second);

	opa0: operator_adapter port map(
		clk				=> clock_50,
		in_operator		=> key,
		set_operator	=> set_operator,
		out_operator	=> operator);
		
	arit0: arithmetic port map(
		op			=> operator,
		first		=> aux_first,
		second	=> aux_second,
		result	=> aux_result,
		overflow	=> overflow);
end behavior;
