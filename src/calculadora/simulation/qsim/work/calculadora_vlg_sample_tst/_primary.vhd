library verilog;
use verilog.vl_types.all;
entity calculadora_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        operand         : in     vl_logic_vector(7 downto 0);
        operator        : in     vl_logic_vector(1 downto 0);
        reset           : in     vl_logic;
        set_operand     : in     vl_logic;
        set_operator    : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end calculadora_vlg_sample_tst;
