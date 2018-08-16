library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
	generic (bit_size : natural := 8);
	port (clk, reset, enter, equals : in std_logic;
			operand : in signed(bit_size - 1 downto 0);
			operator : in std_logic_vector(1 downto 0);
			push_value : out signed(bit_size - 1 downto 0);
			result : in signed(bit_size - 1 downto 0);
			push, pop : out std_logic);
end controller;

architecture behavior of controller is
	type state_type is (START, R1, S1, S2);
	signal state, next_state : state_type;
begin
	process(clk, reset)
	begin
		if (reset = '1') then
			state <= START;
		elsif (rising_edge(clk)) then
			state <= next_state;
		end if;
	end process;
	
	process(state, enter, equals)
	begin
		case state is
			when START =>
				if (enter = '1') then
					next_state <= R1;
					push <= '1';
					pop <= '0';
					push_value <= operand;
				elsif (equals = '1') then
					next_state <=  S1;
					push <= '0';
					pop <= '1';
					push_value <= (others => '0');
				else
					next_state <= START;
					push <= '0';
					pop <= '0';
					push_value <= (others => '0');
				end if;
			when R1 =>
				if (enter = '1') then
					next_state <= R1;
					push <= '0';
					pop <= '0';
					push_value <= (others => '0');
				else
					next_state <= START;
					push <= '0';
					pop <= '0';
					push_value <= (others => '0');
				end if;
			when S1 =>
				next_state <= S2;
				push <= '1';
				pop <= '0';
				push_value <= result;
			when S2 =>
				if (equals = '1') then
					next_state <= S2;
					push <= '0';
					pop <= '0';
					push_value <= (others => '0');
				else
					next_state <= START;
					push <= '0';
					pop <= '0';
					push_value <= (others => '0');
				end if;
		end case;
	end process;
end behavior;