library verilog;
use verilog.vl_types.all;
entity divider_vlg_sample_tst is
    port(
        first           : in     vl_logic_vector(7 downto 0);
        second          : in     vl_logic_vector(7 downto 0);
        sampler_tx      : out    vl_logic
    );
end divider_vlg_sample_tst;
