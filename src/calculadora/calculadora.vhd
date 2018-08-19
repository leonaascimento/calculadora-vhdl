library nightjar;
use nightjar.common.all;

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
			pwm_duty : buffer std_logic_vector(bit_size - 1 downto 0) := (others => '1');
			operator : buffer std_logic_vector(1 downto 0);
			set_operator : buffer std_logic;
			aux_result, aux_first, aux_second : buffer signed(bit_size - 1 downto 0);
			stack_push_value : buffer signed(bit_size - 1 downto 0);
			stack_push, stack_pop : buffer std_logic;
			
			aux_bcd : buffer std_logic_vector(bcd_size_in_bytes * 4 - 1 downto 0);
			aux_hex3, aux_hex2, aux_hex1, aux_hex0 : buffer std_logic_vector (6 downto 0);
			pwm_out : buffer std_logic;
			pwm_out_vector : buffer std_logic_vector (6 downto 0)
			);
end calculadora;

architecture behavior of calculadora is
begin
	ledg <= (others => overflow);
	ledr <= (others => aux_result(aux_result'high));
	result <= aux_result;
	
	pwm_out_vector <= (others => pwm_out);
	
	hex0 <= not (aux_hex0 and pwm_out_vector);
	hex1 <= not (aux_hex1 and pwm_out_vector);
	hex2 <= not (aux_hex2 and pwm_out_vector);
	hex3 <= not (aux_hex3 and pwm_out_vector);
	
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
	
	pwm0: pwm_controller port map(
		clk => clock_50,
		enable => '1',
		reset => '0',
		set_duty => sw(9),
		duty => sw(8 downto 1),
		pwm_out => pwm_out);
	
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
		in_operator		=> not key,
		set_operator	=> set_operator,
		out_operator	=> operator);
		
	arit0: arithmetic port map(
		op			=> operator,
		first		=> aux_first,
		second	=> aux_second,
		result	=> aux_result,
		overflow	=> overflow);
end behavior;
