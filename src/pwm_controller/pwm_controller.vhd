library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_controller is
	generic (
		duty_size : natural := 8);
	port (
		clk, enable, reset : in std_logic;
		set_duty : in std_logic;
		duty : in std_logic_vector(duty_size - 1 downto 0);
		pwm_out : out std_logic);
end pwm_controller;

architecture behavior of pwm_controller is
	signal current_duty : std_logic_vector(duty_size - 1 downto 0) := (others => '1');
	signal counter : unsigned(duty_size - 1 downto 0);
begin
	update_duty: process(clk, set_duty)
	begin
		if (rising_edge(clk)) then
			if (set_duty = '1') then
				current_duty <= duty;
			end if;
		end if;
	end process;

	pwm: process (clk, reset)
	begin
		if (reset = '1') then
			counter <= (others => '0');
		elsif (rising_edge(clk)) then
			if (enable = '0') then
				pwm_out <= '0';
			elsif (counter <= unsigned(current_duty)) then
				pwm_out <= '1';
			else
				pwm_out <= '0';
			end if;
			counter <= counter + 1;
		end if;
	end process;
end behavior;
