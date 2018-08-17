library verilog;
use verilog.vl_types.all;
entity operator_adapter is
    port(
        clk             : in     vl_logic;
        in_operator     : in     vl_logic_vector(3 downto 0);
        set_operator    : out    vl_logic;
        out_operator    : out    vl_logic_vector(1 downto 0)
    );
end operator_adapter;
