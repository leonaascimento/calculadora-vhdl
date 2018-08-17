library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculadora is
	generic (bit_size : natural := 8);
	port (clk, reset, set_operand, set_operator : in std_logic;
			operand : in signed(bit_size - 1 downto 0);
			operator : in std_logic_vector(1 downto 0);
			result : out signed(bit_size - 1 downto 0);
			overflow : out std_logic);
end calculadora;

architecture behavior of calculadora is
	component adder is
		generic (bit_size : natural := 8);
		port (
			first, second : in signed(bit_size - 1 downto 0);
			result : out signed(bit_size - 1 downto 0);
			overflow : out std_logic);
	end component;
	
	component stack is
		generic (stack_size : natural := 16; bit_size : natural := 8);
		port (
			clk, reset : in std_logic;
			push, pop : in std_logic;
			push_value : in signed(bit_size - 1 downto 0);
			pop_first, pop_second : out signed(bit_size - 1 downto 0));
	end component;
	
	component controller is
		generic (bit_size : natural := 8);
		port (
			clk, reset, set_operand, set_operator : in std_logic;
			operand : in signed(bit_size - 1 downto 0);
			operator : in std_logic_vector(1 downto 0);
			result : in signed(bit_size - 1 downto 0);
			stack_push, stack_pop : out std_logic;
			stack_push_value : out signed(bit_size - 1 downto 0));
	end component;
	
	signal aux_result, aux_first, aux_second, stack_push_value : signed(bit_size - 1 downto 0);
	signal stack_push, stack_pop : std_logic;
begin
	result <= aux_result;
	
	c0: controller port map(
		clk, reset, set_operand, set_operator,
		operand, operator,
		aux_result,
		stack_push, stack_pop, stack_push_value);
		
	s0: stack port map(
		clk, reset, stack_push, stack_pop,
		stack_push_value,
		aux_first, aux_second);

	a0: adder port map(
		aux_first, aux_second,
		aux_result, overflow);
end behavior;
