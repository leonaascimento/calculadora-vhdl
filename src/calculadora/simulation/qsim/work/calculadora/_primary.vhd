library verilog;
use verilog.vl_types.all;
entity calculadora is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        set_operand     : in     vl_logic;
        set_operator    : in     vl_logic;
        operand         : in     vl_logic_vector(7 downto 0);
        operator        : in     vl_logic_vector(1 downto 0);
        result          : out    vl_logic_vector(7 downto 0);
        overflow        : out    vl_logic
    );
end calculadora;
