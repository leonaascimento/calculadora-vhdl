library verilog;
use verilog.vl_types.all;
entity stack_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        push_value      : in     vl_logic_vector(7 downto 0);
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end stack_vlg_sample_tst;
