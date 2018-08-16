library verilog;
use verilog.vl_types.all;
entity stack_vlg_check_tst is
    port(
        pop             : in     vl_logic;
        pop_first       : in     vl_logic_vector(7 downto 0);
        pop_second      : in     vl_logic_vector(7 downto 0);
        push            : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end stack_vlg_check_tst;
