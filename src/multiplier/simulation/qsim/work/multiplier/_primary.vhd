library verilog;
use verilog.vl_types.all;
entity multiplier is
    port(
        first           : in     vl_logic_vector(7 downto 0);
        second          : in     vl_logic_vector(7 downto 0);
        result          : out    vl_logic_vector(7 downto 0);
        overflow        : out    vl_logic;
        aux_result      : out    vl_logic_vector(15 downto 0);
        aux_A           : out    vl_logic_vector(16 downto 0);
        aux_S           : out    vl_logic_vector(16 downto 0);
        aux_P           : out    vl_logic_vector(16 downto 0)
    );
end multiplier;
