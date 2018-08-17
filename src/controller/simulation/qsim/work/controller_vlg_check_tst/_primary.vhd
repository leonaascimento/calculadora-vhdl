library verilog;
use verilog.vl_types.all;
entity controller_vlg_check_tst is
    port(
        stack_pop       : in     vl_logic;
        stack_push      : in     vl_logic;
        stack_push_value: in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end controller_vlg_check_tst;
