library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
	generic (
		sizeof_operand : natural := 8);
	port (
		clk              : in std_logic;
		reset            : in std_logic;
		set_operand      : in std_logic;
		set_operator     : in std_logic;
		operand          : in signed(sizeof_operand - 1 downto 0);
		result           : in signed(sizeof_operand - 1 downto 0);
		stack_push       : out std_logic;
		stack_pop        : out std_logic;
		stack_push_value : out signed(sizeof_operand - 1 downto 0));
end controller;

architecture behavior of controller is
	type state_type is (A, B, C);
	signal state, next_state : state_type;
begin
	process(clk, reset)
	begin
		if (reset = '1') then
			state <= A;
		elsif (rising_edge(clk)) then
			state <= next_state;
		end if;
	end process;
	
	process(state, set_operand, set_operator, operand, result)
	begin
		case state is
			when A =>
				if (set_operand = '1') then
					next_state <= B;
					stack_push <= '1'; stack_pop <= '0';
					stack_push_value <= operand;
				elsif (set_operator = '1') then
					next_state <=  C;
					stack_push <= '0'; stack_pop <= '1';
					stack_push_value <= (others => '0');
				else
					next_state <= A;
					stack_push <= '0'; stack_pop <= '0';
					stack_push_value <= (others => '0');
				end if;
			when B =>
				if (set_operand = '1') then
					next_state <= B;
					stack_push <= '0'; stack_pop <= '0';
					stack_push_value <= (others => '0');
				else
					next_state <= A;
					stack_push <= '0'; stack_pop <= '0';
					stack_push_value <= (others => '0');
				end if;
			when C =>
				if (set_operator = '1') then
					next_state <= C;
					stack_push <= '0'; stack_pop <= '0';
					stack_push_value <= (others => '0');
				else
					next_state <= A;
					stack_push <= '1'; stack_pop <= '0';
					stack_push_value <= result;
				end if;
		end case;
	end process;
end behavior;
