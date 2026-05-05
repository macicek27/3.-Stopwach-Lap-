-- Vytvořil Chmela pomocí AI
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity time_dec is
    port (
        time_in  : in  std_logic_vector(18 downto 0); 
        time_out : out std_logic_vector(23 downto 0) 
    );
end entity time_dec;

architecture Behavioral of time_dec is
begin

    -- Proces pro rozklad času na jednotlivé BCD cifry
    p_decode : process (time_in) is
        variable v_total_hth : integer;
        variable v_min_full  : integer;
        variable v_sec_full  : integer;
        variable v_hth_full  : integer;
        
        -- Jednotlivé cifry (0 až 9)
        variable v_m1, v_m0 : integer; -- Minuty
        variable v_s1, v_s0 : integer; -- Sekundy
        variable v_h1, v_h0 : integer; -- Setiny
    begin
        --  Převod vstupu na celé číslo
        v_total_hth := to_integer(unsigned(time_in));

        --  Výpočet celků 
        v_min_full := v_total_hth / 6000;              -- 1 minuta má 6000 setin
        v_sec_full := (v_total_hth rem 6000) / 100;    -- Zbytek minut vydělený na sekundy
        v_hth_full := v_total_hth rem 100;             -- Zbytek jsou setiny

        --  Rozklad na desítky a jednotky (pro displej)
        v_m1 := v_min_full / 10;
        v_m0 := v_min_full rem 10;
        
        v_s1 := v_sec_full / 10;
        v_s0 := v_sec_full rem 10;
        
        v_h1 := v_hth_full / 10;
        v_h0 := v_hth_full rem 10;

        --  Zabalení do 24bitového výstupu (BCD formát)
        
        -- Setiny (pozice 0 a 1)
        time_out(3 downto 0)   <= std_logic_vector(to_unsigned(v_h0, 4));
        time_out(7 downto 4)   <= std_logic_vector(to_unsigned(v_h1, 4));
        
        -- Sekundy (pozice 2 a 3)
        time_out(11 downto 8)  <= std_logic_vector(to_unsigned(v_s0, 4));
        time_out(15 downto 12) <= std_logic_vector(to_unsigned(v_s1, 4));
        
        -- Minuty (pozice 4 a 5)
        time_out(19 downto 16) <= std_logic_vector(to_unsigned(v_m0, 4));
        time_out(23 downto 20) <= std_logic_vector(to_unsigned(v_m1, 4));

    end process p_decode;

end Behavioral;