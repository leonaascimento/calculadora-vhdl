library verilog;
use verilog.vl_types.all;
entity calculadora_vlg_check_tst is
    port(
        aux_first       : in     vl_logic_vector(7 downto 0);
        aux_result      : in     vl_logic_vector(7 downto 0);
        aux_second      : in     vl_logic_vector(7 downto 0);
        op              : in     vl_logic_vector(1 downto 0);
        overflow        : in     vl_logic;
        result          : in     vl_logic_vector(7 downto 0);
        set_operator    : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end calculadora_vlg_check_tst;
