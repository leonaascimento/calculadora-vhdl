library verilog;
use verilog.vl_types.all;
entity operator_adapter_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        in_operator     : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end operator_adapter_vlg_sample_tst;
