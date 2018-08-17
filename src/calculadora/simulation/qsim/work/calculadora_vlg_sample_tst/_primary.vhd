library verilog;
use verilog.vl_types.all;
entity calculadora_vlg_sample_tst is
    port(
        clock_50        : in     vl_logic;
        key             : in     vl_logic_vector(3 downto 0);
        sw              : in     vl_logic_vector(9 downto 0);
        sampler_tx      : out    vl_logic
    );
end calculadora_vlg_sample_tst;
