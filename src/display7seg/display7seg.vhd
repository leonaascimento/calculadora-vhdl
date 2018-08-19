library ieee;
use ieee.std_logic_1164.all;

entity display7seg is
	port (bcd : in std_logic_vector (3 downto 0);
			seg : out std_logic_vector (6 downto 0));
end display7seg;

architecture behavior of display7seg is
begin
	seg(0) <= bcd(3)
				 or bcd(1)
				 or (bcd(2) and bcd(0))
				 or (not bcd(2) and not bcd(0));

	seg(1) <= not bcd(2)
				 or (not bcd(1) and not bcd(0))
				 or (bcd(1) and bcd(0));

	seg(2) <= bcd(2)
				 or not bcd(1)
				 or bcd(0);

	seg(3) <= (not bcd(2) and not bcd(0))
				 or (bcd(1) and not bcd(0))
				 or (bcd(2) and not bcd(1) and bcd(0))
				 or (not bcd(2) and bcd(1))
				 or bcd(3);
				 
	seg(4) <= (not bcd(2) and not bcd(0))
				 or (bcd(1) and not bcd(0));
				 
	seg(5) <= bcd(3)
				 or (not bcd(1) and not bcd(0))
				 or (bcd(2) and not bcd(1))
				 or (bcd(2) and not bcd(0));
	
	seg(6) <= bcd(3)
				 or (bcd(2) and not bcd(1))
				 or (not bcd(2) and bcd(1))
				 or (bcd(1) and not bcd(0));
end behavior;
