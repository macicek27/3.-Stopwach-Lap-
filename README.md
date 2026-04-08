# Projekt 3: Digitální stopky (Lap)
**Autor:** Hrbáček, Chmela, Hofman

## Architektura (Blokové schéma)

## Plánované vstupy a výstupy
- `clk`: Hlavní hodiny
- `rst`: Reset stopek
- `ssb`: Start/Stop
- `Lap`: Uložení mezičasu
- `CA-CG, DP`: Segmenty displeje
- `AN`: Anody displeje

# Aktuální verze projektu 
- library IEEE;
- use IEEE.STD_LOGIC_1164.ALL;
-
- entity Stopwatch is
-
-   Port ( clk : in STD_LOGIC;
-           rst : in STD_LOGIC;
-           ssb : in STD_LOGIC;
           lap : in STD_LOGIC;
           
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0));
           
end Stopwatch;

architecture Behavioral of Stopwatch is

component debounce is
        Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           btn_in : in STD_LOGIC;
           btn_state : out STD_LOGIC;
           btn_press : out STD_LOGIC);

    end component debounce;
    
    component clk_en is
        Port (
            clk : in  std_logic;
            rst : in  std_logic;
            ce  : out std_logic
        );
    end component clk_en;

begin'


end Behavioral;
