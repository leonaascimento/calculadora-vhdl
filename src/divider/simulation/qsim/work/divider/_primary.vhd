library verilog;
use verilog.vl_types.all;
entity divider is
    port(
        first           : in     vl_logic_vector(7 downto 0);
        second          : in     vl_logic_vector(7 downto 0);
        result          : out    vl_logic_vector(7 downto 0);
        overflow        : out    vl_logic
    );
end divider;
