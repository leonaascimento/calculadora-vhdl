library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arithmetic is
	generic (bit_size : natural := 8);
	port (op : in std_logic_vector(1 downto 0);
			first, second : in signed(bit_size - 1 downto 0);
			result : out signed(bit_size - 1 downto 0);
			overflow : out std_logic);
end entity;

architecture behavior of arithmetic is
	component multiplier is
		generic (bit_size : natural := 8);
		port (
			first, second : in signed(bit_size - 1 downto 0);
			result : out signed(bit_size - 1 downto 0);
			overflow : out std_logic);
	end component;
	
	component divider is
		generic (bit_size : natural := 8);
		port (
			first, second : in signed(bit_size - 1 downto 0);
			result : out signed(bit_size - 1 downto 0);
			overflow : out std_logic);
	end component;
	
	component adder is
		generic (bit_size : natural := 8);
		port (
			first, second : in signed(bit_size - 1 downto 0);
			result : out signed(bit_size - 1 downto 0);
			overflow : out std_logic);
	end component;
	
	component subtractor is
		generic (bit_size : natural := 8);
		port (
			first, second : in signed(bit_size - 1 downto 0);
			result : out signed(bit_size - 1 downto 0);
			overflow : out std_logic);
	end component;
	
	signal adder_result, subtractor_result, 
		multiplier_result, divider_result : signed(bit_size - 1 downto 0);
	signal adder_overflow, subtractor_overflow,
		multiplier_overflow, divider_overflow : std_logic;
begin
	m0: multiplier port map(first, second, multiplier_result, multiplier_overflow);
	d0: divider port map(first, second, divider_result, divider_overflow);
	a0: adder port map(first, second, adder_result, adder_overflow);
	s0: subtractor port map(first, second, subtractor_result, subtractor_overflow);
	
	with op select
		result <= multiplier_result	when "11",
					 divider_result		when "10",
					 adder_result			when "01",
					 subtractor_result	when "00";
					 
	with op select
		overflow <= multiplier_overflow	when "11",
						divider_overflow		when "10",
						adder_overflow			when "01",
						subtractor_overflow	when "00";
end behavior;