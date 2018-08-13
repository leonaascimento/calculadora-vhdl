library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divider is
	generic (bit_size : natural := 8);
	port (first, second : in signed(bit_size - 1 downto 0);
			result : out signed(bit_size - 1 downto 0);
			overflow : out std_logic);
end divider;

architecture behavior of divider is
	signal aux_result : signed(bit_size - 1 downto 0);
	signal zero : signed(bit_size - 1 downto 0) := (others => '0');
begin
	aux_result <= first / second;
	result <= aux_result;
	
	overflow <= '1' when second = zero else
					'0';
end behavior;
