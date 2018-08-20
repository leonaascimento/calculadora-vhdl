library verilog;
use verilog.vl_types.all;
entity calculadora_vlg_check_tst is
    port(
        hex0            : in     vl_logic_vector(6 downto 0);
        hex1            : in     vl_logic_vector(6 downto 0);
        hex2            : in     vl_logic_vector(6 downto 0);
        hex3            : in     vl_logic_vector(6 downto 0);
        ledg            : in     vl_logic_vector(7 downto 0);
        ledr            : in     vl_logic_vector(9 downto 0);
        sampler_rx      : in     vl_logic
    );
end calculadora_vlg_check_tst;
