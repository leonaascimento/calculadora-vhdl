library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier is
	generic (
		sizeof_operand : natural := 8);
	port (
		first, second : in  signed(sizeof_operand - 1 downto 0);
		result        : out signed(sizeof_operand - 1 downto 0);
		overflow      : out std_logic;
		
		aux_result : buffer signed(sizeof_operand * 2 - 1 downto 0);
		aux_A, aux_S, aux_P : buffer unsigned(first'length + second'length downto 0)
		);
end multiplier;

architecture behavior of multiplier is
	--signal aux_result : signed(sizeof_operand * 2 - 1 downto 0);
	signal actual, expected : signed(sizeof_operand * 2 - 1 downto 0);
	
	--signal aux_A, aux_S, aux_P : unsigned(first'length + second'length downto 0);
begin
	process(first, second)
		variable A, S, P : unsigned(first'length + second'length downto 0);
		variable i       : natural;
	begin
		A := (others => '0');
		S := (others => '0');
		P := (others => '0');
		
		A(A'high downto A'high - first'high) := unsigned(first);
		S(S'high downto S'high - first'high) := unsigned((not first) + 1);
		P(second'high + 1 downto 1) := unsigned(second);
		
		for i in second'reverse_range loop
			case P(1 downto 0) is
				when "01" => P := P + A;
				when "10" => P := P + S;
				when others => null;
			end case;
			
			P := P(P'high) & P(P'high downto 1);
		end loop;
		
		aux_A <= A;
		aux_S <= S;
		aux_P <= P;
		
		aux_result <= signed(P(P'high downto 1));
	end process;

	result <= aux_result(aux_result'high) & aux_result(result'high - 1 downto 0);
	
	actual <= aux_result;
	expected(aux_result'high downto result'high) <= (others => aux_result(aux_result'high));
	expected(result'high - 1 downto 0) <= aux_result(result'high - 1 downto 0);
	
	overflow <= '1' when actual /= expected else
					'0';
end behavior;
