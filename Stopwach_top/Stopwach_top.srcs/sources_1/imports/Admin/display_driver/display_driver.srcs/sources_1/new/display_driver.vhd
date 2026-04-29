library ieee;
use ieee.std_logic_1164.all;

entity display_driver is
    port (
        clk      : in  std_logic;                         
        rst      : in  std_logic;                         
        data     : in  std_logic_vector(23 downto 0);    
        seg      : out std_logic_vector(6 downto 0);      
        an       : out std_logic_vector(5 downto 0)       
    );
end entity display_driver;

architecture Behavioral of display_driver is

    component clk_en is
        generic ( G_MAX : positive );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            ce  : out std_logic
        );
    end component clk_en;

    -- Komponenta čítače pro přepínání anod (0 až 5)
    component counter is
        generic ( G_BITS : positive );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            en  : in  std_logic;
            cnt : out std_logic_vector(G_BITS - 1 downto 0)
        );
    end component counter;

    -- Komponenta dekodéru BCD na 7 segmentů
    component bin2seg is
        port (
            bin : in  std_logic_vector(3 downto 0);
            seg : out std_logic_vector(6 downto 0)
        );
    end component bin2seg;

    -- Vnitřní signály
    signal sig_en    : std_logic;
    signal sig_digit : std_logic_vector(2 downto 0); -- 3 bity pro rozsah 0-5
    signal sig_bin   : std_logic_vector(3 downto 0); -- 4 bity pro dekodér

begin
    clock_enable_0 : clk_en
        generic map ( G_MAX => 100000 ) 
        port map (
            clk => clk,
            rst => rst,
            ce  => sig_en
        );

    
    -- Čítač 
    counter_digit_0 : counter
       generic map ( G_BITS => 3 )
       port map (
           clk => clk,
           rst => rst,
           en  => sig_en,
           cnt => sig_digit
       );

    -- Sloučený proces pro multiplexing (Data + Anody)
    p_multiplexing : process (sig_digit, data) is
    begin
        case sig_digit is
            when "000" => 
                sig_bin <= data(3 downto 0);   -- Data pro 1. cifru
                an      <= "111110";           -- Zapni 1. anodu
            when "001" => 
                sig_bin <= data(7 downto 4);   -- Data pro 2. cifru
                an      <= "111101";           -- Zapni 2. anodu
            when "010" => 
                sig_bin <= data(11 downto 8);  -- Data pro 3. cifru
                an      <= "111011";           -- Zapni 3. anodu
            when "011" => 
                sig_bin <= data(15 downto 12); -- Data pro 4. cifru
                an      <= "110111";           -- Zapni 4. anodu
            when "100" => 
                sig_bin <= data(19 downto 16); -- Data pro 5. cifru
                an      <= "101111";           -- Zapni 5. anodu
            when "101" => 
                sig_bin <= data(23 downto 20); -- Data pro 6. cifru
                an      <= "011111";           -- Zapni 6. anodu
            when others => 
                sig_bin <= "0000";
                an      <= "111111";           -- Vše vypnuto
        end case;
    end process p_multiplexing;
    
    decoder_7seg_0 : bin2seg
        port map (
            bin => sig_bin, 
            seg => seg      
        );

end Behavioral;