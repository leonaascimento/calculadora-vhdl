library verilog;
use verilog.vl_types.all;
entity calculadora_vlg_check_tst is
    port(
        overflow        : in     vl_logic;
        push_value      : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end calculadora_vlg_check_tst;
