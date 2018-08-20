library verilog;
use verilog.vl_types.all;
entity calculadora is
    port(
        clock_50        : in     vl_logic;
        key             : in     vl_logic_vector(3 downto 0);
        sw              : in     vl_logic_vector(9 downto 0);
        ledg            : out    vl_logic_vector(7 downto 0);
        ledr            : out    vl_logic_vector(9 downto 0);
        hex3            : out    vl_logic_vector(6 downto 0);
        hex2            : out    vl_logic_vector(6 downto 0);
        hex1            : out    vl_logic_vector(6 downto 0);
        hex0            : out    vl_logic_vector(6 downto 0);
        stack_push_value: out    vl_logic_vector(7 downto 0);
        stack_push      : out    vl_logic;
        stack_pop       : out    vl_logic;
        set_operator    : out    vl_logic;
        operator        : out    vl_logic_vector(1 downto 0);
        first_operand   : out    vl_logic_vector(7 downto 0);
        second_operand  : out    vl_logic_vector(7 downto 0);
        operation_result: out    vl_logic_vector(7 downto 0);
        operation_overflow: out    vl_logic;
        bcd_result      : out    vl_logic_vector(11 downto 0);
        hex3_result_sign: out    vl_logic_vector(6 downto 0);
        hex2_result     : out    vl_logic_vector(6 downto 0);
        hex1_result     : out    vl_logic_vector(6 downto 0);
        hex0_result     : out    vl_logic_vector(6 downto 0);
        pwm_out         : out    vl_logic;
        pwm_out_vector  : out    vl_logic_vector(6 downto 0)
    );
end calculadora;
