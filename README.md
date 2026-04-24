# Projekt 3: Digitální stopky 
**Autor:** Hrbáček, Chmela, Hofman
## projektu
Tento projekt implementuje plně funkční digitální stopky. Stopky měří čas s přesností na setiny sekundy, umožňují pozastavení čítání, ukládání mezičasů (lap time) a jejich následné zobrazení na 7segmentovém displeji.

## Jak to funguje

Systém je rozdělen do několika logických bloků, které spolu komunikují uvnitř hlavního modulu

## Architektura (Blokové schéma)
![Schéma zapojení stopek](Schema2.png)

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




