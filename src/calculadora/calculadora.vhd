library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculadora is
	generic (bit_size : natural := 8);
	port (clk, reset, set_operand : in std_logic;
			operand : in signed(bit_size - 1 downto 0);
			operator : in std_logic_vector(3 downto 0);
			result : out signed(bit_size - 1 downto 0);
			overflow : out std_logic;
			op : buffer std_logic_vector(1 downto 0);
			set_operator : buffer std_logic;
			aux_result, aux_first, aux_second : buffer signed(bit_size - 1 downto 0));
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
	
	signal stack_push_value : signed(bit_size - 1 downto 0);
	signal stack_push, stack_pop : std_logic;
begin
	result <= aux_result;
	
	c0: controller port map(
		clk, reset, set_operand, set_operator,
		operand, aux_result,
		stack_push, stack_pop, stack_push_value);
		
	s0: stack port map(
		clk, reset, stack_push, stack_pop,
		stack_push_value,
		aux_first, aux_second);

	a0: arithmetic port map(
		op, aux_first, aux_second,
		aux_result, overflow);
		
	o0: operator_adapter port map(
		clk, operator,
		set_operator, op);
end behavior;
