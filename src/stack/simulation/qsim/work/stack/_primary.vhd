library verilog;
use verilog.vl_types.all;
entity stack is
    port(
        clk             : in     vl_logic;
        push            : in     vl_logic;
        pop             : in     vl_logic;
        push_value      : in     vl_logic_vector(7 downto 0);
        pop_value       : out    vl_logic_vector(7 downto 0);
        error           : out    vl_logic
    );
end stack;
