library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pwm_module is
	port (clk, enable, reset : in std_logic;
			duty : in std_logic_vector (7 downto 0);
			pwm_out : out std_logic);
end pwm_module;

architecture behavior of pwm_module is
	signal counter : std_logic_vector (7 downto 0);
begin
	process (clk, reset)
	begin
		if (reset = '1') then
			counter <= (others => '0');
		elsif (rising_edge(clk)) then
			if (enable = '0') then
				pwm_out <= '0';
			elsif (counter <= duty) then
				pwm_out <= '1';
			else
				pwm_out <= '0';
			end if;
			counter <= counter + 1;
		end if;
	end process;
end behavior;
