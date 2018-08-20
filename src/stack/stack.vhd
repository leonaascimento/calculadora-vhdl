library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- empilhar um valor de cada vez e desempilhar dois
entity stack is
	generic (
		sizeof_stack : natural := 16;
		sizeof_value : natural := 8);
	port (
		clk         : in  std_logic;
		reset       : in  std_logic;
		push        : in  std_logic;
		pop         : in  std_logic;
		push_value  : in  signed(sizeof_value - 1 downto 0);
		pop_first   : out signed(sizeof_value - 1 downto 0);
		pop_second  : out signed(sizeof_value - 1 downto 0);
		empty, full : out std_logic;
		error       : out std_logic;
		status      : buffer std_logic_vector(sizeof_stack - 1 downto 0));
end stack;

architecture behavior of stack is
	type stack_type is array(0 to sizeof_stack - 1) of signed(sizeof_value - 1 downto 0);
	signal stack     : stack_type := (others => (others => '0'));
	signal top       : integer := -1;
	signal aux_empty : std_logic := '1';
begin
	empty <= aux_empty;

	process(clk, reset)
	begin
		if (reset = '1') then
			top <= -1;
			pop_first <= (others => '0');
			pop_second <= (others => '0');
			aux_empty <= '1';
			full <= '1';
			error <= '1';
			status <= (others => '0');
		elsif (rising_edge(clk)) then
			if (push = '1') then
				if (top < stack'high) then
					if (top = stack'high - 1) then
						full <= '1';
					end if;
					stack(top + 1) <= push_value;
					top <= top + 1;
					aux_empty <= '0';
					error <= '0';
					status <= '1' & status(status'high downto status'low + 1);
				else
					error <= '1';
				end if;
			elsif (pop = '1') then
				if (top >= stack'low) then
					if (top = stack'low + 1) then
						aux_empty <= '1';
					end if;
					pop_first <= stack(top - 1);
					pop_second <= stack(top);
					top <= top - 2;
					full <= '0';
					error <= '0';
					status <= status(status'high - 2 downto status'low) & "00";
				else
					error <= '1';
				end if;
			end if;
		end if;
	end process;
end behavior;
