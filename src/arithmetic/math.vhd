library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package math is
	component arithmetic is
		generic (
			sizeof_operand : natural := 8);
		port (
			op            : in  std_logic_vector(1 downto 0);
			first, second : in  signed(sizeof_operand - 1 downto 0);
			result        : out signed(sizeof_operand - 1 downto 0);
			overflow      : out std_logic);
	end component;
	
	component adder is
		generic (
			sizeof_operand : natural := 8);
		port (
			first, second : in signed(sizeof_operand - 1 downto 0);
			result        : out signed(sizeof_operand - 1 downto 0);
			overflow      : out std_logic);
	end component;
	
	component divider is
		generic (
			sizeof_operand : natural := 8);
		port (
			first, second : in signed(sizeof_operand - 1 downto 0);
			result        : out signed(sizeof_operand - 1 downto 0);
			overflow      : out std_logic);
	end component;
	
	component multiplier is
		generic (
			sizeof_operand : natural := 8);
		port (
			first, second : in  signed(sizeof_operand - 1 downto 0);
			result        : out signed(sizeof_operand - 1 downto 0);
			overflow      : out std_logic);
	end component;
	
	component subtractor is
		generic (
			sizeof_operand : natural := 8);
		port (
			first, second : in  signed(sizeof_operand - 1 downto 0);
			result        : out signed(sizeof_operand - 1 downto 0);
			overflow      : out std_logic);
	end component;
end math;
