-- Vytvořil Hrbáček pomocí AI
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Stopwach_top is
    Port ( 
        clk  : in  STD_LOGIC;
        btnd : in  STD_LOGIC; -- Globální Reset
        btnu : in  STD_LOGIC; -- Start/Stop
        btnc : in  STD_LOGIC; -- Lap Save
        btnr : in  STD_LOGIC; -- Lap Scroll
        btnl : in  STD_LOGIC; -- View Mode
           
        seg  : out STD_LOGIC_VECTOR (6 downto 0);
        dp   : out STD_LOGIC;
        an   : out STD_LOGIC_VECTOR (7 downto 0)
    );
end Stopwach_top;

architecture Behavioral of Stopwach_top is

    -- ==========================================
    -- 1. DEKLARACE KOMPONENT (Naše stavební bloky)
    -- ==========================================
    
    component debounce is
        Port ( 
            clk       : in  STD_LOGIC;
            rst       : in  STD_LOGIC;
            btn_in    : in  STD_LOGIC;
            btn_state : out STD_LOGIC;
            btn_press : out STD_LOGIC
        );
    end component;
    
    component clk_en is
        generic ( G_MAX : positive );
        Port (
            clk : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            ce  : out STD_LOGIC
        );
    end component;

    component Start_Stop is
        Port (
            clk    : in  STD_LOGIC;
            rst    : in  STD_LOGIC;
            btn_in : in  STD_LOGIC;
            ce     : in  STD_LOGIC;
            en     : out STD_LOGIC
        );
    end component;

    component counter is
        generic ( G_BITS : positive );
        Port (
            clk : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            en  : in  STD_LOGIC;
            cnt : out STD_LOGIC_VECTOR(G_BITS - 1 downto 0)
        );
    end component;

    component lap is
        Port ( 
            clk     : in  STD_LOGIC;
            rst     : in  STD_LOGIC;
            lap_in  : in  STD_LOGIC_VECTOR (18 downto 0);
            lap_sv  : in  STD_LOGIC;
            lap_sr  : in  STD_LOGIC;
            lap_out : out STD_LOGIC_VECTOR (18 downto 0)
        );
    end component;

    component view is
        Port (
            clk      : in  STD_LOGIC;
            rst      : in  STD_LOGIC;
            time_d   : in  STD_LOGIC_VECTOR(18 downto 0);
            lap_d    : in  STD_LOGIC_VECTOR(18 downto 0);
            view_in  : in  STD_LOGIC;
            view_out : out STD_LOGIC_VECTOR(18 downto 0)
        );
    end component;

    component time_dec is
        Port (
            time_in  : in  STD_LOGIC_VECTOR(18 downto 0);
            time_out : out STD_LOGIC_VECTOR(23 downto 0)
        );
    end component;

    component display_driver is
        Port (
            clk  : in  STD_LOGIC;
            rst  : in  STD_LOGIC;
            data : in  STD_LOGIC_VECTOR(23 downto 0);
            seg  : out STD_LOGIC_VECTOR(6 downto 0);
            an   : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

    -- ==========================================
    -- 2. DEKLARACE VNITŘNÍCH SIGNÁLŮ (Drátky ze schématu)
    -- ==========================================
    
    -- Řídicí signály (1-bit)
    signal sig_clk_en   : STD_LOGIC;
    signal sig_ss       : STD_LOGIC;
    signal sig_lap_save : STD_LOGIC;
    signal sig_lap_sr   : STD_LOGIC;
    signal sig_view     : STD_LOGIC;
    signal sig_coun_en  : STD_LOGIC;
    
    -- Datové sběrnice (více bitů)
    signal sig_lap_in   : STD_LOGIC_VECTOR(18 downto 0);
    signal sig_lap_out  : STD_LOGIC_VECTOR(18 downto 0);
    signal sig_view_out : STD_LOGIC_VECTOR(18 downto 0);
    signal sig_data     : STD_LOGIC_VECTOR(23 downto 0);
    
    -- Pomocný signál pro anody z displeje
    signal sig_an_5_0   : STD_LOGIC_VECTOR(5 downto 0);

begin

    -- ==========================================
    -- 3. PROPOJOVÁNÍ KOMPONENT (Port Mapping)
    -- ==========================================

    -- --- Tlačítka a časování ---
    
    -- Pulz pro běh stopek (100 Hz = každých 10 ms z 100MHz hodin)
    clk_en_inst : clk_en
        generic map ( G_MAX => 1000000 ) -- 100 MHz / 1 000 000 = 100 Hz
        port map (
            clk => clk,
            rst => btnd,
            ce  => sig_clk_en
        );

    deb_up : debounce
        port map (
            clk       => clk,
            rst       => btnd,
            btn_in    => btnu,
            btn_state => open,
            btn_press => sig_ss
        );

    deb_center : debounce
        port map (
            clk       => clk,
            rst       => btnd,
            btn_in    => btnc,
            btn_state => open,
            btn_press => sig_lap_save
        );

    deb_right : debounce
        port map (
            clk       => clk,
            rst       => btnd,
            btn_in    => btnr,
            btn_state => open,
            btn_press => sig_lap_sr
        );

    deb_left : debounce
        port map (
            clk       => clk,
            rst       => btnd,
            btn_in    => btnl,
            btn_state => open,
            btn_press => sig_view
        );

    -- --- Logika stopek ---

    start_stop_inst : Start_Stop
        port map (
            clk    => clk,
            rst    => btnd,
            btn_in => sig_ss,
            ce     => sig_clk_en,
            en     => sig_coun_en
        );

    counter_inst : counter
        generic map ( G_BITS => 19 )
        port map (
            clk => clk,
            rst => btnd,
            en  => sig_coun_en,
            cnt => sig_lap_in
        );

    -- --- Zpracování dat a zobrazení ---

    lap_inst : lap
        port map (
            clk     => clk,
            rst     => btnd,
            lap_in  => sig_lap_in,
            lap_sv  => sig_lap_save,
            lap_sr  => sig_lap_sr,
            lap_out => sig_lap_out
        );

    view_inst : view
        port map (
            clk      => clk,
            rst      => btnd,
            time_d   => sig_lap_in,
            lap_d    => sig_lap_out,
            view_in  => sig_view,
            view_out => sig_view_out
        );

    time_dec_inst : time_dec
        port map (
            time_in  => sig_view_out,
            time_out => sig_data
        );

    display_driver_inst : display_driver
        port map (
            clk  => clk,
            rst  => btnd,
            data => sig_data,
            seg  => seg,
            an   => sig_an_5_0
        );

    -- ==========================================
    -- 4. PŘÍMÉ VÝSTUPY NA DESKU
    -- ==========================================
    
    -- Připojení spodních 6 anod z display_driver
    an(5 downto 0) <= sig_an_5_0;
    
    -- Vrchní dvě cifry
    an(7 downto 6) <= "11";
    
    -- Desetinnou tečka
    dp <= '0' when sig_an_5_0(2) = '0' else '1'; 
    -- Desetinná tečka mezi minutami a sekundamy a sekundamy a setinamy dp <= '0' when (sig_an_5_0(4) = '0' or sig_an_5_0(2) = '0') else '1';
        

end Behavioral;
