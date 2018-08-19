library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subtractor is
	generic (
		sizeof_operand : natural := 8);
	port (
		first, second : in  signed(sizeof_operand - 1 downto 0);
		result        : out signed(sizeof_operand - 1 downto 0);
		overflow      : out std_logic);
end subtractor;

architecture behavior of subtractor is
	signal diff   : signed(sizeof_operand - 1 downto 0);
	signal borrow : std_logic_vector(sizeof_operand + 1 downto 0) := (others => '0');
begin
	result <= diff;
	overflow <= (first(first'high) xor second(second'high))
		and (first(first'high) xor diff(diff'high));
					
	process(first, second, borrow)
	begin
		for i in diff'reverse_range loop
			diff(i) <= (first(i) xor second(i))
				xor borrow(i);
				
			borrow(i + 1) <= ((not first(i)) and second(i))
				or (borrow(i) and (not (first(i) xor second(i))));
		end loop;
	end process;
end behavior;
