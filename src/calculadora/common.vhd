library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package common is
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
end common;