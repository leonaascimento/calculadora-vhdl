library verilog;
use verilog.vl_types.all;
entity pwm_controller_vlg_check_tst is
    port(
        pulse           : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end pwm_controller_vlg_check_tst;
