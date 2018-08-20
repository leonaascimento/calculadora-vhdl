library verilog;
use verilog.vl_types.all;
entity pwm_module is
    port(
        clk             : in     vl_logic;
        enable          : in     vl_logic;
        reset           : in     vl_logic;
        duty            : in     vl_logic_vector(7 downto 0);
        pwm_out         : out    vl_logic
    );
end pwm_module;
