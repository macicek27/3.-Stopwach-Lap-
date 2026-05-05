-- Vytvořil Hofman pomocí AI
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lap is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           lap_in : in STD_LOGIC_VECTOR (18 downto 0);
           lap_sv : in STD_LOGIC;
           lap_sr : in STD_LOGIC;
           lap_out : out STD_LOGIC_VECTOR (18 downto 0));
end lap;

architecture Behavioral of lap is

    type lap_array_t is array (0 to 3) of STD_LOGIC_VECTOR(18 downto 0);

    signal laps     : lap_array_t := (others => (others => '0'));
    signal wr_ptr   : integer range 0 to 3 := 0;
    signal rd_ptr   : integer range 0 to 3 := 0;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                laps   <= (others => (others => '0'));
                wr_ptr <= 0;
                rd_ptr <= 0;

            elsif lap_sv = '1' then
                -- uložit nový lap
                laps(wr_ptr) <= lap_in;

                -- posun write pointeru (kruhově)
                if wr_ptr = 3 then
                    wr_ptr <= 0;
                else
                    wr_ptr <= wr_ptr + 1;
                end if;

            elsif lap_sr = '1' then
                -- scroll mezi lapy
                if rd_ptr = 3 then
                    rd_ptr <= 0;
                else
                    rd_ptr <= rd_ptr + 1;
                end if;
            end if;
        end if;
    end process;

    -- výstup aktuálního lapu
    lap_out <= laps(rd_ptr);

end Behavioral;