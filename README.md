# Projekt 3: Digitální stopky (Lap)
**Autor:** Hrbáček, Chmela, Hofman

## Architektura (Blokové schéma)
<img width="1846" height="800" alt="image" src="https://github.com/user-attachments/assets/729ea8ec-8f66-4840-8d00-ce8b22682415" />


## Plánované vstupy a výstupy
- `clk`: Hlavní hodiny
- `BTND`: Reset stopek
- `BTNU`: Start/Stop
- `BTNC`: Uložení mezičasu
- `BTNR`: Listování v mezičasech
- `BTNL`: Zobrazení mezičasu
- `CA-CG, DP`: Segmenty displeje
- `AN`: Anody displeje

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
