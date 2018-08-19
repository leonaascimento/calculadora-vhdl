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
        result          : out    vl_logic_vector(7 downto 0);
        overflow        : out    vl_logic;
        pwm_duty        : out    vl_logic_vector(7 downto 0);
        operator        : out    vl_logic_vector(1 downto 0);
        set_operator    : out    vl_logic;
        aux_result      : out    vl_logic_vector(7 downto 0);
        aux_first       : out    vl_logic_vector(7 downto 0);
        aux_second      : out    vl_logic_vector(7 downto 0);
        stack_push_value: out    vl_logic_vector(7 downto 0);
        stack_push      : out    vl_logic;
        stack_pop       : out    vl_logic;
        aux_bcd         : out    vl_logic_vector(15 downto 0);
        aux_hex3        : out    vl_logic_vector(6 downto 0);
        aux_hex2        : out    vl_logic_vector(6 downto 0);
        aux_hex1        : out    vl_logic_vector(6 downto 0);
        aux_hex0        : out    vl_logic_vector(6 downto 0);
        pwm_out         : out    vl_logic;
        pwm_out_vector  : out    vl_logic_vector(6 downto 0)
    );
end calculadora;
