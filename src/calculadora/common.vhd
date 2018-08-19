library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package common is
	component pwm_controller is
		generic (
			sizeof_duty : natural := 8);
		port (
			clk      : in std_logic;
			enable   : in std_logic;
			reset    : in std_logic;
			set_duty : in std_logic;
			duty     : in std_logic_vector(sizeof_duty - 1 downto 0);
			pwm_out  : out std_logic);
	end component;
	
	component display7seg is
		port (
			bcd : in  std_logic_vector(3 downto 0);
			seg : out std_logic_vector(6 downto 0));
	end component;
	
	component double_dabble is
		generic (
			sizeof_bin : integer := 8;
			sizeof_bcd : integer := 4);			
		port (
			bin : in std_logic_vector(sizeof_bin - 1 downto 0);
			bcd : out std_logic_vector(sizeof_bcd * 4 - 1 downto 0));
	end component;
	
	component operator_adapter is
		port (
			clk          : in std_logic;
			in_operator  : in std_logic_vector(3 downto 0);
			set_operator : out std_logic;
			out_operator : buffer std_logic_vector(1 downto 0));
	end component;
	
	component stack is
		generic (
			sizeof_stack : natural := 16;
			sizeof_value : natural := 8);
		port (
			clk        : in  std_logic;
			reset      : in  std_logic;
			push       : in  std_logic;
			pop        : in  std_logic;
			push_value : in  signed(sizeof_value - 1 downto 0);
			pop_first  : out signed(sizeof_value - 1 downto 0);
			pop_second : out signed(sizeof_value - 1 downto 0));
	end component;

	component controller is
		generic (
			sizeof_operand : natural := 8);
		port (
			clk              : in std_logic;
			reset            : in std_logic;
			set_operand      : in std_logic;
			set_operator     : in std_logic;
			operand          : in signed(sizeof_operand - 1 downto 0);
			result           : in signed(sizeof_operand - 1 downto 0);
			stack_push       : out std_logic;
			stack_pop        : out std_logic;
			stack_push_value : out signed(sizeof_operand - 1 downto 0));
	end component;
end common;
