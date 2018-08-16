library verilog;
use verilog.vl_types.all;
entity controller is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enter           : in     vl_logic;
        equals          : in     vl_logic;
        operand         : in     vl_logic_vector(7 downto 0);
        operator        : in     vl_logic_vector(1 downto 0);
        push_value      : out    vl_logic_vector(7 downto 0);
        result          : in     vl_logic_vector(7 downto 0);
        push            : out    vl_logic;
        pop             : out    vl_logic
    );
end controller;
