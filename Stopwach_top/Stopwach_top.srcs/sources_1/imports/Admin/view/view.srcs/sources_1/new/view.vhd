library ieee;
use ieee.std_logic_1164.all;

entity view is
    port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        
        -- Datové vstupy (19 bitů)
        time_d   : in  std_logic_vector(18 downto 0); -- Běžící čas 
        lap_d    : in  std_logic_vector(18 downto 0); -- Uložený čas 
        
        -- Řídicí vstup
        view_in  : in  std_logic;                     
        
        -- Datový výstup (19 bitů)
        view_out : out std_logic_vector(18 downto 0)  -- Čas do dekodéru
    );
end entity view;

-------------------------------------------------

architecture Behavioral of view is

    -- '0' = zobrazujeme běžící čas (time_d)
    -- '1' = zobrazujeme uložený čas (lap_d)
    signal s_display_mode : std_logic := '0';

begin

    p_mode_toggle : process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                -- Při resetu se vždy vrátí na bežící čas
                s_display_mode <= '0';
            elsif view_in = '1' then
                -- Při zmáčknutí tlačítka prohodíme režim 
                s_display_mode <= not s_display_mode;
            end if;
        end if;
    end process p_mode_toggle;
    
    -- Pokud je s_display_mode '0', pošle se time_d, jinak se pošle lap_d
    view_out <= time_d when s_display_mode = '0' else lap_d;

end architecture Behavioral;