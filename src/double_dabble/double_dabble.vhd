library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity double_dabble is
	generic	(bin_size_in_bits : integer := 13;
				 bcd_size_in_bytes : integer := 4);			
	port		(bin : in std_logic_vector(bin_size_in_bits - 1 downto 0);
				 bcd : out std_logic_vector(bcd_size_in_bytes * 4 - 1 downto 0));
end double_dabble;

architecture behavior of double_dabble is
begin
	process(bin)
		variable tmp_bin : std_logic_vector(bin'range);
		variable tmp_bcd : std_logic_vector(bcd'range);
		variable range_high, range_low : integer;
	begin
		tmp_bin := bin;
		tmp_bcd := (others => '0');
		shift : for i in tmp_bin'reverse_range loop
			add : for j in 0 to tmp_bcd'length / 4 - 1 loop
				range_high := (j + 1) * 4 - 1;
				range_low  := (j + 1) * 4 - 4;
				if tmp_bcd(range_high downto range_low) > 4 then 
					tmp_bcd(range_high downto range_low) := tmp_bcd(range_high downto range_low) + 3;
				end if;
			end loop add;
			tmp_bcd := tmp_bcd(tmp_bcd'high - 1 downto 0) & tmp_bin(tmp_bin'high);
			tmp_bin := tmp_bin(tmp_bin'high - 1 downto 0) & '0';
		end loop shift;
		bcd <= tmp_bcd;
	end process;
end behavior;