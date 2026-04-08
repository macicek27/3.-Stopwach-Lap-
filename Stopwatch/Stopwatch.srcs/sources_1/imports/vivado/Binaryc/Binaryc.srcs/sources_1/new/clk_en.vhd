library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_en is
    generic ( G_MAX : positive := 5 );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : out STD_LOGIC);
end clk_en;

architecture Behavioral of clk_en is

    signal sig_cnt : integer range 0 to G_MAX-1;

begin

    synchr_process : process (clk) is
    begin
        if rising_edge(clk) then 
                ce          <= '0';
            if rst = '1' then
                sig_cnt     <= 0;
            elsif sig_cnt = G_MAX-1 then
                ce          <= '1';
                sig_cnt     <= 0;
            else
                sig_cnt <= sig_cnt +1;
                           
            end if;
        end if;
     end process;

end Behavioral;
