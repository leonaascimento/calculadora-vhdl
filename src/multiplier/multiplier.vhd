library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier is
	generic (
		sizeof_operand : natural := 8);
	port (
		first, second : in  signed(sizeof_operand - 1 downto 0);
		result        : out signed(sizeof_operand - 1 downto 0);
		overflow      : out std_logic);
end multiplier;

architecture behavior of multiplier is
	signal aux_result : signed(sizeof_operand * 2 - 1 downto 0);
	signal actual, expected : signed(sizeof_operand * 2 - 1 downto 0);
begin
	aux_result <= first * second;
	result <= aux_result(aux_result'high) & aux_result(result'high - 1 downto 0);
	
	actual <= aux_result;
	expected(aux_result'high downto result'high) <= (others => aux_result(aux_result'high));
	expected(result'high - 1 downto 0) <= aux_result(result'high - 1 downto 0);
	
	overflow <= '1' when actual /= expected else
					'0';
end behavior;
