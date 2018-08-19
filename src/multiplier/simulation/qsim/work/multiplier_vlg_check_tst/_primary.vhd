library verilog;
use verilog.vl_types.all;
entity multiplier_vlg_check_tst is
    port(
        aux_A           : in     vl_logic_vector(16 downto 0);
        aux_P           : in     vl_logic_vector(16 downto 0);
        aux_result      : in     vl_logic_vector(15 downto 0);
        aux_S           : in     vl_logic_vector(16 downto 0);
        overflow        : in     vl_logic;
        result          : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end multiplier_vlg_check_tst;
