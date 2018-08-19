library verilog;
use verilog.vl_types.all;
entity calculadora_vlg_check_tst is
    port(
        aux_first       : in     vl_logic_vector(7 downto 0);
        aux_result      : in     vl_logic_vector(7 downto 0);
        aux_second      : in     vl_logic_vector(7 downto 0);
        hex0            : in     vl_logic_vector(6 downto 0);
        hex1            : in     vl_logic_vector(6 downto 0);
        hex2            : in     vl_logic_vector(6 downto 0);
        hex3            : in     vl_logic_vector(6 downto 0);
        ledg            : in     vl_logic_vector(7 downto 0);
        ledr            : in     vl_logic_vector(9 downto 0);
        operator        : in     vl_logic_vector(1 downto 0);
        overflow        : in     vl_logic;
        pwm_bar         : in     vl_logic_vector(6 downto 0);
        pwm_duty        : in     vl_logic_vector(7 downto 0);
        result          : in     vl_logic_vector(7 downto 0);
        set_operator    : in     vl_logic;
        stack_pop       : in     vl_logic;
        stack_push      : in     vl_logic;
        stack_push_value: in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end calculadora_vlg_check_tst;
