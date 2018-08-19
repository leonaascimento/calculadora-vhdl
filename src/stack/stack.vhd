library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stack is
	generic (
		sizeof_stack : natural := 16;
		sizeof_value : natural := 8);
	port (
		clk        : in  std_logic;
		reset      : in  std_logic;
		push       : in  std_logic;
		pop        : in  std_logic;
		push_value : in  signed(sizeof_value - 1 downto 0);
		pop_first  : out signed(sizeof_value - 1 downto 0);
		pop_second : out signed(sizeof_value - 1 downto 0));
end stack;

architecture behavior of stack is
	type stack_type is array(0 to sizeof_stack - 1) of signed(sizeof_value - 1 downto 0);
	signal stack : stack_type := (others => (others => '0'));
	signal top   : integer := -1;
begin
	process(clk, reset)
	begin
		if (reset = '1') then
			top <= -1;
			pop_second <= (others => '0');
			pop_first <= (others => '0');
		elsif (rising_edge(clk)) then
			if (push = '1') then
				if (top < stack'high) then
					stack(top + 1) <= push_value;
					top <= top + 1;
				end if;
			elsif (pop = '1') then
				if (top >= stack'low) then
					pop_second <= stack(top);
					pop_first <= stack(top - 1);
					top <= top - 2;
				end if;
			end if;
		end if;
	end process;
end behavior;
