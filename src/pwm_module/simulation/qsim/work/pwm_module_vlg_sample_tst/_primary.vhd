library verilog;
use verilog.vl_types.all;
entity pwm_module_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        duty            : in     vl_logic_vector(7 downto 0);
        enable          : in     vl_logic;
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end pwm_module_vlg_sample_tst;
