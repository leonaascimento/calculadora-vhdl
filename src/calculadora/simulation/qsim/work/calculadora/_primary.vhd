library verilog;
use verilog.vl_types.all;
entity calculadora is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enter           : in     vl_logic;
        equals          : in     vl_logic;
        operand         : in     vl_logic_vector(7 downto 0);
        operator        : in     vl_logic_vector(1 downto 0);
        push_value      : out    vl_logic_vector(7 downto 0);
        overflow        : out    vl_logic
    );
end calculadora;
