library nightjar;
use nightjar.common.all;
use nightjar.math.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculadora is
	generic (
		sizeof_stack         : natural := 10;
		sizeof_operand       : natural := 8;
		sizeof_duty          : natural := 8;
		sizeof_display_array : natural := 3);
	port (
		clock_50 : in  std_logic;
		key      : in  std_logic_vector(3 downto 0);
		sw       : in  std_logic_vector(9 downto 0);
		ledg     : out std_logic_vector(7 downto 0);
		ledr     : out std_logic_vector(9 downto 0);
		hex3     : out std_logic_vector(6 downto 0);
		hex2     : out std_logic_vector(6 downto 0);
		hex1     : out std_logic_vector(6 downto 0);
		hex0     : out std_logic_vector(6 downto 0));
end calculadora;

architecture behavior of calculadora is
	signal stack_push_value   : signed(sizeof_operand - 1 downto 0);
	signal stack_push         : std_logic;
	signal stack_pop          : std_logic;
	
	signal set_operator       : std_logic;
	signal operator           : std_logic_vector(1 downto 0);
	signal first_operand      : signed(sizeof_operand - 1 downto 0);
	signal second_operand     : signed(sizeof_operand - 1 downto 0);
	signal operation_result   : signed(sizeof_operand - 1 downto 0);
	signal operation_overflow : std_logic;
	
	signal bcd_result         : std_logic_vector(sizeof_display_array * 4 - 1 downto 0);
	signal hex3_result_sign   : std_logic_vector(6 downto 0);
	signal hex2_result        : std_logic_vector(6 downto 0);
	signal hex1_result        : std_logic_vector(6 downto 0);
	signal hex0_result        : std_logic_vector(6 downto 0);
	
	signal pwm_out            : std_logic;
	signal pwm_out_vector     : std_logic_vector(6 downto 0);
begin
	-- exibir sinal negativo no display #3 caso o numero seja negativo
	hex3_result_sign <= operation_result(operation_result'high) & "000000";
	
	-- controlar pwm dos displays
	pwm_out_vector <= (others => pwm_out);
	hex3 <= not (hex3_result_sign and pwm_out_vector);
	hex2 <= not (hex2_result and pwm_out_vector);
	hex1 <= not (hex1_result and pwm_out_vector);
	hex0 <= not (hex0_result and pwm_out_vector);
	
	-- dividir a secao de leds verdes
	ledg(4) <= '0';
	
	-- os leds verdes [3..0] acendem quando houver overflow
	ledg(3 downto 0) <= (others => operation_overflow);
	
	display7seg2: display7seg
		port map(
			bcd => bcd_result(11 downto 8),
			seg => hex2_result);
	
	display7seg1: display7seg
		port map(
			bcd => bcd_result(7 downto 4),
			seg => hex1_result);
	
	display7seg0: display7seg
		port map(
			bcd => bcd_result(3 downto 0),
			seg => hex0_result);
			
	double_dabble0: double_dabble
		generic map(
			sizeof_bin  => sizeof_operand,
			sizeof_bcd => sizeof_display_array)
		port map(
			bin => std_logic_vector(unsigned(operation_result)),
			bcd => bcd_result);
	
	pwm0: pwm_controller
		generic map(
			sizeof_duty => sizeof_duty)
		port map(
			clk       => clock_50,
			enable    => '1',
			reset     => '0',
			set_duty  => sw(9),
			duty      => sw(8 downto 1),
			pwm_out   => pwm_out);
			
	operator_adapter0: operator_adapter
		port map(
			clk          => clock_50,
			in_operator  => not key,
			set_operator => set_operator,
			out_operator => operator);
	
	controller0: controller
		generic map(
			sizeof_operand   => sizeof_operand)
		port map(
			clk              => clock_50,
			reset            => '0',
			set_operand      => sw(0),
			set_operator     => set_operator,
			operand          => signed(sw(8 downto 1)),
			result           => operation_result,
			stack_push       => stack_push,
			stack_pop        => stack_pop,
			stack_push_value => stack_push_value);
		
	stack0: stack
		generic map(
			sizeof_stack => sizeof_stack,
			sizeof_value => sizeof_operand)
		port map(
			clk        => clock_50,
			reset      => '0',
			push       => stack_push,
			pop        => stack_pop,
			push_value => stack_push_value,
			pop_first  => first_operand,
			pop_second => second_operand,
			empty      => ledg(7),
			full       => ledg(5),
			error      => ledg(6),
			status     => ledr);
		
	arithmetic0: arithmetic
		generic map(
			sizeof_operand => sizeof_operand)
		port map(
			operator => operator,
			first    => first_operand,
			second   => second_operand,
			result   => operation_result,
			overflow => operation_overflow);
end behavior;
