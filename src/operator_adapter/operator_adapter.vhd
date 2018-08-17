library ieee;
use ieee.std_logic_1164.all;

entity operator_adapter is
	port (clk : in std_logic;
			in_operator : in std_logic_vector(3 downto 0);
			set_operator : out std_logic;
			out_operator : out std_logic_vector(1 downto 0));
end operator_adapter;

architecture behavior of operator_adapter is
	type state_type is (A, B, C);
	signal state, next_state : state_type;
	signal aux_out_operator : std_logic_vector(1 downto 0);
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			state <= next_state;
		end if;
	end process;

	process(state, in_operator, aux_out_operator)
	begin
		case state is
		when A =>
			if (in_operator(3) = '1') then
				next_state <= B;
				aux_out_operator <= "11"; out_operator <= "11";
				set_operator <= '1';
			elsif (in_operator(2) = '1') then
				next_state <= B;
				aux_out_operator <= "10"; out_operator <= "10";
				set_operator <= '1';
			elsif (in_operator(1) = '1') then
				next_state <= B;
				aux_out_operator <= "01"; out_operator <= "01";
				set_operator <= '1';
			elsif (in_operator(0) = '1') then
				next_state <= B;
				aux_out_operator <= "00"; out_operator <= "00";
				set_operator <= '1';
			else
				next_state <= A;
				aux_out_operator <= "00"; out_operator <= "00";
				set_operator <= '0';
			end if;
		when B =>
			if (in_operator(3) = '1') then
				next_state <= B;
				aux_out_operator <= "11"; out_operator <= "11";
				set_operator <= '0';
			elsif (in_operator(2) = '1') then
				next_state <= B;
				aux_out_operator <= "10"; out_operator <= "10";
				set_operator <= '0';
			elsif (in_operator(1) = '1') then
				next_state <= B;
				aux_out_operator <= "01"; out_operator <= "01";
				set_operator <= '0';
			elsif (in_operator(0) = '1') then
				next_state <= B;
				aux_out_operator <= "00"; out_operator <= "00";
				set_operator <= '0';
			else
				next_state <= C;
				aux_out_operator <= aux_out_operator; out_operator <= aux_out_operator;
				set_operator <= '0';
			end if;
		when C =>
			if (in_operator(3) = '1') then
				next_state <= B;
				aux_out_operator <= "11"; out_operator <= "11";
				set_operator <= '1';
			elsif (in_operator(2) = '1') then
				next_state <= B;
				aux_out_operator <= "10"; out_operator <= "10";
				set_operator <= '1';
			elsif (in_operator(1) = '1') then
				next_state <= B;
				aux_out_operator <= "01"; out_operator <= "01";
				set_operator <= '1';
			elsif (in_operator(0) = '1') then
				next_state <= B;
				aux_out_operator <= "00"; out_operator <= "00";
				set_operator <= '1';
			else
				next_state <= C;
				aux_out_operator <= aux_out_operator; out_operator <= aux_out_operator;
				set_operator <= '0';
			end if;
		end case;
	end process;
end behavior;
