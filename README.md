# 3.-Stopwach-Lap-

    entity clock_top is
      Port ( 
        mclk : in  STD_LOGIC; -- Main Clock (100 MHz)
        rst  : in  STD_LOGIC; -- Reset
        ssb  : in  STD_LOGIC; -- Start/Stop Button
        Lap  : in  STD_LOGIC; -- Lap Button
        
        -- Jednotlivé segmenty 
        CA   : out STD_LOGIC;
        CB   : out STD_LOGIC;
        CC   : out STD_LOGIC;
        CD   : out STD_LOGIC;
        CE   : out STD_LOGIC;
        CF   : out STD_LOGIC;
        CG   : out STD_LOGIC;
        DP   : out STD_LOGIC;
        
        AN   : out STD_LOGIC_VECTOR (7 downto 0)
      );
    end clock_top;
