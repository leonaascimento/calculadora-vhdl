library nightjar;
use nightjar.math.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arithmetic is
	generic (
		sizeof_operand : natural := 8);
	port (
		operator      : in  std_logic_vector(1 downto 0);
		first, second : in  signed(sizeof_operand - 1 downto 0);
		result        : out signed(sizeof_operand - 1 downto 0);
		overflow      : out std_logic);
end entity;

architecture behavior of arithmetic is
	signal adder_result      : signed(sizeof_operand - 1 downto 0);
	signal subtractor_result : signed(sizeof_operand - 1 downto 0);
	signal multiplier_result : signed(sizeof_operand - 1 downto 0);
	signal divider_result    : signed(sizeof_operand - 1 downto 0);
	
	signal adder_overflow      : std_logic;
	signal subtractor_overflow : std_logic;
	signal multiplier_overflow : std_logic;
	signal divider_overflow    : std_logic;
begin
	with operator select
		result <= multiplier_result	when "11",
					 divider_result		when "10",
					 adder_result			when "01",
					 subtractor_result	when "00";
					 
	with operator select
		overflow <= multiplier_overflow	when "11",
						divider_overflow		when "10",
						adder_overflow			when "01",
						subtractor_overflow	when "00";

	multiplier0: multiplier
		generic map(
			sizeof_operand => sizeof_operand)
		port map(
			first    => first,
			second   => second,
			result   => multiplier_result,
			overflow => multiplier_overflow);
			
	divider0: divider
		generic map(
			sizeof_operand => sizeof_operand)
		port map(
			first    => first,
			second   => second,
			result   => divider_result,
			overflow => divider_overflow);
			
	adder0: adder
		generic map(
			sizeof_operand => sizeof_operand)
		port map(
			first    => first,
			second   => second,
			result   => adder_result,
			overflow => adder_overflow);
			
	subtractor0: subtractor
		generic map(
			sizeof_operand => sizeof_operand)
		port map(
			first    => first,
			second   => second,
			result   => subtractor_result,
			overflow =>subtractor_overflow);
end behavior;
