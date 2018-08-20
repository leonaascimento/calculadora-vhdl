library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- realizar divisao inteira
entity divider is
	generic (
		sizeof_operand : natural := 8);
	port (
		first, second : in signed(sizeof_operand - 1 downto 0);
		result        : out signed(sizeof_operand - 1 downto 0);
		overflow      : out std_logic);
end divider;

architecture behavior of divider is
	signal aux_result : signed(sizeof_operand - 1 downto 0);
	signal zero : signed(sizeof_operand - 1 downto 0) := (others => '0');
begin
	aux_result <= first / second;
	result <= aux_result;
	
	overflow <= '1' when second = zero else
					'0';
end behavior;
