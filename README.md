# Projekt 3: Digitální stopky (Lap)
**Autor:** Hrbáček, Chmela, Hofman

## Architektura (Blokové schéma)
<img width="1821" height="816" alt="image" src="https://github.com/user-attachments/assets/37ab008f-a502-4574-ba08-01c8fbdd513d" />



## Plánované vstupy a výstupy
- `clk`: Hlavní hodiny
- `BTND`: Reset stopek
- `BTNU`: Start/Stop
- `BTNC`: Uložení mezičasu
- `BTNR`: Listování v mezičasech
- `BTNL`: Zobrazení mezičasu
- `CA-CG, DP`: Segmenty displeje
- `AN`: Anody displeje

## Rozdělení práce na projektu (Digital Stopwatch)

### Hrbáček
* Stopwatch_top
* Github
* Schéma
* Constraints file

### Hofman
* **`Start&Stop`** 
* **`lap`** 
* **`view`** 

### Chmela
* **`time_dec`** 
* **`display_driver`**
