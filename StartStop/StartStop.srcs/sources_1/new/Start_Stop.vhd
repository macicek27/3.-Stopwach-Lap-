library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Start_Stop is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           btn_in : in STD_LOGIC;
           ce : in STD_LOGIC;
           en : out STD_LOGIC);
end Start_Stop;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity StartStop is
    Port (
        clk    : in  STD_LOGIC;
        rst    : in  STD_LOGIC;
        btn_in : in  STD_LOGIC;
        ce     : in  STD_LOGIC;
        en     : out STD_LOGIC
    );
end StartStop;

architecture Behavioral of StartStop is
    signal run_reg : STD_LOGIC := '0';
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                run_reg <= '0';
            elsif btn_in = '1' then
                run_reg <= not run_reg;
            end if;
        end if;
    end process;

    en <= run_reg and ce;

end Behavioral;