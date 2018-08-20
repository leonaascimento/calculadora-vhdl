library ieee;
use ieee.std_logic_1164.all;

entity latch_d is
	generic (bit_size : natural := 8);
	port (enable : in std_logic;
			d : in std_logic_vector(bit_size - 1 downto 0);
			q : out std_logic_vector(bit_size - 1 downto 0));
end latch_d;

architecture behavior of latch_d is
	signal aux_q : std_logic_vector(bit_size - 1 downto 0);
begin
	process(enable, d)
	begin
		if (enable = '1') then
			q <= d;
			aux_q <= d;
		else
			q <= aux_q;
		end if;
	end process;
end behavior;
