library verilog;
use verilog.vl_types.all;
entity controller_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        enter           : in     vl_logic;
        equals          : in     vl_logic;
        operand         : in     vl_logic_vector(7 downto 0);
        operator        : in     vl_logic_vector(1 downto 0);
        reset           : in     vl_logic;
        result          : in     vl_logic_vector(7 downto 0);
        sampler_tx      : out    vl_logic
    );
end controller_vlg_sample_tst;
