library verilog;
use verilog.vl_types.all;
entity operator_adapter_vlg_check_tst is
    port(
        out_operator    : in     vl_logic_vector(1 downto 0);
        set_operator    : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end operator_adapter_vlg_check_tst;
