library verilog;
use verilog.vl_types.all;
entity stack is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        push            : out    vl_logic;
        pop             : out    vl_logic;
        push_value      : in     vl_logic_vector(7 downto 0);
        pop_first       : out    vl_logic_vector(7 downto 0);
        pop_second      : out    vl_logic_vector(7 downto 0)
    );
end stack;
