library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- realizar multiplicacao
entity multiplier is
	generic (
		sizeof_operand : natural := 8);
	port (
		first, second : in  signed(sizeof_operand - 1 downto 0);
		result        : out signed(sizeof_operand - 1 downto 0);
		overflow      : out std_logic);
end multiplier;

architecture behavior of multiplier is
	signal product  : signed(sizeof_operand * 2 - 1 downto 0);
	signal actual   : signed(sizeof_operand * 2 - 1 downto 0);
begin
	result <= product(product'high) & product(result'high - 1 downto 0);
	
	actual(product'high downto result'high) <= (others => product(product'high));
	actual(result'high - 1 downto 0) <= product(result'high - 1 downto 0);
	
	overflow <= '1' when actual /= product else
					'0';

	process(first, second)
		variable A, S, P : unsigned(first'length + second'length + 1 downto 0);
		variable i       : natural;
	begin
		A := (others => '0');
		S := (others => '0');
		P := (others => '0');
		
		A(A'high downto A'high - first'high - 1) := unsigned(first(first'high) & first);
		S(S'high downto S'high - first'high - 1) := unsigned((not (first(first'high) & first)) + 1);
		P(second'high + 1 downto 1) := unsigned(second);
		
		for i in second'reverse_range loop
			case P(1 downto 0) is
				when "01" => P := P + A;
				when "10" => P := P + S;
				when others => null;
			end case;
			
			P := P(P'high) & P(P'high downto 1);
		end loop;
		
		product <= signed(P(P'high - 1 downto 1));
	end process;
end behavior;
