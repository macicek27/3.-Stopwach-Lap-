# Projekt 3: Digitální stopky 
**Autor:** Hrbáček, Chmela, Hofman
## projektu
Tento projekt implementuje plně funkční digitální stopky. Stopky měří čas s přesností na setiny sekundy, umožňují pozastavení čítání, ukládání mezičasů (lap time) a jejich následné zobrazení na 7segmentovém displeji.

## Jak to funguje

Systém je rozdělen do několika logických bloků, které spolu komunikují uvnitř hlavního modulu

## Architektura (Blokové schéma)
![Schéma zapojení stopek](Schema2.png)

### 1. Zpracování vstupů a časování
* **`Debounce` :** Mechanická tlačítka při stisku "kmitají". Tento blok tyto zákmity filtruje a propouští do systému pouze čisté logické signály.
* **`Clk_en` :** Bere hlavní hodiny z desky a generuje povolovací pulz přesně každých 10 ms (frekvence 100 Hz). 

### 2. Řízení a počítání času
* **`Start_Stop`:** Vnitřní paměť, která uchovává stav stopek (běží/stojí). 
* **`Counter` :** Pokaždé, když dostane povel ze `Start&Stop`, přičte hodnotu 1. Jeho maximální kapacita umožňuje stopkám běžet zhruba 87 minut do přetečení.

### 3. Zpracování mezičasů a zobrazení
* **`lap` :** Registr, který na povel tlačítka zkopíruje aktuální 19bitovou hodnotu z čítače a uloží si ji k pozdějšímu zobrazení.
* **`view`:** Na základě vstupu od uživatele propouští dál buď živý čas z čítače, nebo zmrazený čas z modulu `lap`.
* **`time_dec`:** Přijímá 19bitové binární číslo a matematicky ho převádí na minuty, sekundy a setiny .
* **`display_driver`** :**Rychle přepíná aktivní cifry na desce tak, že pro lidské oko svítí všech 6 číslic najednou.

**Vstupy (Inputs):**
* **`clk`** : Hlavní hodinový signál z desky .
* **`btnd`** : Globální reset pro vynulování celého systému .
* **`btnu`** : Tlačítko nahoru (spuštění a pozastavení stopek).
* **`btnc`** : Prostřední tlačítko (uložení aktuálního času do paměti).
* **`btnr`** : Pravé tlačítko (listování v paměti mezičasů).
* **`btnl`** : Levé tlačítko (přepínání zobrazení mezi běžícím časem a pamětí).

### Výstupy (Outputs)
* **`seg`** : Řízení jednotlivých segmentů (A-G)
* **`dp`** : Desetinná tečka
* **`an`**

## Rozdělení práce na projektu 

### Hrbáček
* Stopwatch_top
* Github
* Schéma
* view
### Hofman
* Start&Stop 
* lap 
* Constraints file
### Chmela
* time_dec 
* display_driver

## Použité nástroje
* Google Geminy
* Vivado 2025.2
* ChatGPT
* draw.io
* Microsoft Powerpoint




