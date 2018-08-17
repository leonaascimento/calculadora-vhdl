library verilog;
use verilog.vl_types.all;
entity arithmetic is
    port(
        op              : in     vl_logic_vector(1 downto 0);
        first           : in     vl_logic_vector(7 downto 0);
        second          : in     vl_logic_vector(7 downto 0);
        result          : out    vl_logic_vector(7 downto 0);
        overflow        : out    vl_logic
    );
end arithmetic;
