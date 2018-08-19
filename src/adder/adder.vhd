library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	generic (
		sizeof_operand : natural := 8);
	port (
		first, second : in signed(sizeof_operand - 1 downto 0);
		result        : out signed(sizeof_operand - 1 downto 0);
		overflow      : out std_logic);
end adder;

architecture behavior of adder is
	signal aux_result : signed(sizeof_operand - 1 downto 0);
begin
	aux_result <= first + second;
	result <= aux_result;
	
	overflow <= (first(first'high) xnor second(second'high)) and
					(first(first'high) xor aux_result(aux_result'high));
end behavior;
