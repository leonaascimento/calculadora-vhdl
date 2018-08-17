library verilog;
use verilog.vl_types.all;
entity calculadora is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        set_operand     : in     vl_logic;
        operand         : in     vl_logic_vector(7 downto 0);
        operator        : in     vl_logic_vector(3 downto 0);
        result          : out    vl_logic_vector(7 downto 0);
        overflow        : out    vl_logic;
        op              : out    vl_logic_vector(1 downto 0);
        set_operator    : out    vl_logic;
        aux_result      : out    vl_logic_vector(7 downto 0);
        aux_first       : out    vl_logic_vector(7 downto 0);
        aux_second      : out    vl_logic_vector(7 downto 0)
    );
end calculadora;
