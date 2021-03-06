library verilog;
use verilog.vl_types.all;
entity stack_vlg_check_tst is
    port(
        empty           : in     vl_logic;
        error           : in     vl_logic;
        full            : in     vl_logic;
        pop_first       : in     vl_logic_vector(7 downto 0);
        pop_second      : in     vl_logic_vector(7 downto 0);
        status          : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end stack_vlg_check_tst;
