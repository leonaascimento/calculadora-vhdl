library verilog;
use verilog.vl_types.all;
entity stack is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        push            : in     vl_logic;
        pop             : in     vl_logic;
        push_value      : in     vl_logic_vector(7 downto 0);
        pop_first       : out    vl_logic_vector(7 downto 0);
        pop_second      : out    vl_logic_vector(7 downto 0);
        empty           : out    vl_logic;
        full            : out    vl_logic;
        error           : out    vl_logic;
        stack_status    : out    vl_logic_vector(0 to 15)
    );
end stack;
