library ieee;
use ieee.std_logic_1164.all;

entity operator_adapter is
	port (clk : in std_logic;
			in_operator : in std_logic_vector(3 downto 0);
			set_operator : out std_logic;
			out_operator : buffer std_logic_vector(1 downto 0));
end operator_adapter;

architecture behavior of operator_adapter is
	type state_type is (A, B, C);
	signal state, next_state : state_type;
	signal last_in_operator : std_logic_vector(3 downto 0);
	signal last_out_operator : std_logic_vector(1 downto 0);
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			state <= next_state;
			last_in_operator <= in_operator;
			last_out_operator <= out_operator;
		end if;
	end process;

	process(state, last_in_operator, last_out_operator)
	begin
		case state is
		when A =>
			if (last_in_operator(3) = '1') then
				next_state <= C;
				out_operator <= "11";
				set_operator <= '1';
			elsif (last_in_operator(2) = '1') then
				next_state <= C;
				out_operator <= "10";
				set_operator <= '1';
			elsif (last_in_operator(1) = '1') then
				next_state <= C;
				out_operator <= "01";
				set_operator <= '1';
			elsif (last_in_operator(0) = '1') then
				next_state <= C;
				out_operator <= "00";
				set_operator <= '1';
			else
				next_state <= A;
				out_operator <= "00";
				set_operator <= '0';
			end if;
		when B =>
			if (last_in_operator(3) = '1') then
				next_state <= C;
				out_operator <= "11";
				set_operator <= '1';
			elsif (last_in_operator(2) = '1') then
				next_state <= C;
				out_operator <= "10";
				set_operator <= '1';
			elsif (last_in_operator(1) = '1') then
				next_state <= C;
				out_operator <= "01";
				set_operator <= '1';
			elsif (last_in_operator(0) = '1') then
				next_state <= C;
				out_operator <= "00";
				set_operator <= '1';
			else
				next_state <= B;
				set_operator <= '0';
				out_operator <= last_out_operator;
			end if;
		when C =>
			if (last_in_operator = "0000") then
				next_state <= B;
			else
				next_state <= C;
			end if;
			set_operator <= '0';
			out_operator <= last_out_operator;
		end case;
	end process;
end behavior;
