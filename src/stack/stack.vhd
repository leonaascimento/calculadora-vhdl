library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stack is
	generic (stack_size : natural := 16; bit_size : natural := 8);
	port (clk, push, pop : in std_logic;
			push_value : in signed(bit_size - 1 downto 0);
			pop_value : out signed(bit_size - 1 downto 0);
			empty : out std_logic := '1';
			full, error : out std_logic := '0');
end stack;

architecture behavior of stack is
	type stack_type is array(0 to stack_size - 1) of signed(bit_size - 1 downto 0);
	signal stack : stack_type := (others => (others => '0'));
	signal top : integer := -1;
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			if (push = '1') then
				if (top < stack'high) then
					if (top = stack'high - 1) then
						full <= '1';
					end if;
					stack(top + 1) <= push_value;
					top <= top + 1;
					empty <= '0';
					error <= '0';
				else
					error <= '1';
				end if;
			elsif (pop = '1') then
				if (top >= stack'low) then
					if (top = stack'low) then
						empty <= '1';
					end if;
					pop_value <= stack(top);
					top <= top - 1;
					full <= '0';
					error <= '0';
				else
					error <= '1';
				end if;
			end if;
		end if;
	end process;
end behavior;
