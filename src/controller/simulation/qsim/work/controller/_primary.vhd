library verilog;
use verilog.vl_types.all;
entity controller is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        set_operand     : in     vl_logic;
        set_operator    : in     vl_logic;
        operand         : in     vl_logic_vector(7 downto 0);
        operator        : in     vl_logic_vector(1 downto 0);
        result          : in     vl_logic_vector(7 downto 0);
        stack_push      : out    vl_logic;
        stack_pop       : out    vl_logic;
        stack_push_value: out    vl_logic_vector(7 downto 0)
    );
end controller;
