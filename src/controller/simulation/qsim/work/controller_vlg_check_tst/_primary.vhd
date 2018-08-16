library verilog;
use verilog.vl_types.all;
entity controller_vlg_check_tst is
    port(
        pop             : in     vl_logic;
        push            : in     vl_logic;
        push_value      : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end controller_vlg_check_tst;
