library verilog;
use verilog.vl_types.all;
entity calculadora_vlg_check_tst is
    port(
        bcd_result      : in     vl_logic_vector(11 downto 0);
        first_operand   : in     vl_logic_vector(7 downto 0);
        hex0            : in     vl_logic_vector(6 downto 0);
        hex0_result     : in     vl_logic_vector(6 downto 0);
        hex1            : in     vl_logic_vector(6 downto 0);
        hex1_result     : in     vl_logic_vector(6 downto 0);
        hex2            : in     vl_logic_vector(6 downto 0);
        hex2_result     : in     vl_logic_vector(6 downto 0);
        hex3            : in     vl_logic_vector(6 downto 0);
        hex3_result_sign: in     vl_logic_vector(6 downto 0);
        ledg            : in     vl_logic_vector(7 downto 0);
        ledr            : in     vl_logic_vector(9 downto 0);
        operation_overflow: in     vl_logic;
        operation_result: in     vl_logic_vector(7 downto 0);
        operator        : in     vl_logic_vector(1 downto 0);
        pwm_out         : in     vl_logic;
        pwm_out_vector  : in     vl_logic_vector(6 downto 0);
        second_operand  : in     vl_logic_vector(7 downto 0);
        set_operator    : in     vl_logic;
        stack_pop       : in     vl_logic;
        stack_push      : in     vl_logic;
        stack_push_value: in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end calculadora_vlg_check_tst;
