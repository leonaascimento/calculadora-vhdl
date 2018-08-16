library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculadora is
	generic (bit_size : natural := 8);
	port (clk, reset, enter, equals : in std_logic;
			operand : in signed(bit_size - 1 downto 0);
			operator : in std_logic_vector(1 downto 0);
			push_value : buffer signed(bit_size - 1 downto 0);
			overflow : out std_logic);
end calculadora;

architecture behavior of calculadora is
	signal result, pop_first, pop_second : signed(bit_size - 1 downto 0);
	signal push, pop : std_logic;
	
	component controller is
		generic (bit_size : natural := 8);
		port (clk, reset, enter, equals : in std_logic;
				operand : in signed(bit_size - 1 downto 0);
				operator : in std_logic_vector(1 downto 0);
				push_value : out signed(bit_size - 1 downto 0);
				result : in signed(bit_size - 1 downto 0);
				push, pop : out std_logic);
	end component;
	
	component stack is
		generic (stack_size : natural := 16; bit_size : natural := 8);
		port (clk, reset : in std_logic;
				push, pop : in std_logic;
				push_value : in signed(bit_size - 1 downto 0);
				pop_first, pop_second : out signed(bit_size - 1 downto 0));
	end component;
	
	component adder is
		generic (bit_size : natural := 8);
		port (first, second : in signed(bit_size - 1 downto 0);
				result : out signed(bit_size - 1 downto 0);
				overflow : out std_logic);
	end component;
begin
	c0: controller port map (clk, reset, enter, equals, operand, operator, push_value, result, push, pop);
	s0: stack port map (clk, reset, push, pop, push_value, pop_first, pop_second);
	a0: adder port map (pop_first, pop_second, result, overflow);
end behavior;
