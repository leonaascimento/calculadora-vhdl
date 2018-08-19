library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	generic (
		sizeof_operand : natural := 8);
	port (
		first, second : in  signed(sizeof_operand - 1 downto 0);
		result        : out signed(sizeof_operand - 1 downto 0);
		overflow      : out std_logic);
end adder;

architecture behavior of adder is
	signal sum   : signed(sizeof_operand - 1 downto 0);
	signal carry : std_logic_vector(sizeof_operand + 1 downto 0) := (others => '0');
begin
	result <= sum;
	overflow <= (first(first'high) xnor second(second'high))
		and (first(first'high) xor sum(sum'high));
	
	process(first, second, carry)
	begin
		for i in sum'reverse_range loop
			sum(i) <= first(i)
				xor (second(i) xor carry(i));
				
			carry(i + 1) <= (second(i) and carry(i))
				or (second(i) and first(i))
				or (carry(i) and first(i));
		end loop;
	end process;
end behavior;
