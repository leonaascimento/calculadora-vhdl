library verilog;
use verilog.vl_types.all;
entity adder_vlg_check_tst is
    port(
        overflow        : in     vl_logic;
        result          : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end adder_vlg_check_tst;
