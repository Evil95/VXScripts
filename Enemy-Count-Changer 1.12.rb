#==============================================================================
# Enemy-Count-Changer
# ----------------------------------------------------------------------------
# Version 1.12  (16.7.08)
# Von Evil95
#==============================================================================
$auswahl = 1
class Game_Troop < Game_Unit
  if $auswahl == 1
  LETTER_TABLE = [ ' 1',' 2',' 3',' 4',' 5',' 6',' 7',' 8',' 9',' 10',
                   ' 11',' 12',' 13',' 14',' 15',' 16',' 17',' 18',
                   ' 19',' 20',' 21',' 22',' 23',' 24',' 25',' 26']
  end
  if $auswahl == 2
  LETTER_TABLE = [ ' A',' B',' C',' D',' E',' F',' G',' H',' I',' J',
                   ' K',' L',' M',' N',' O',' P',' Q',' R',' S',' T',
                   ' U',' V',' W',' X',' Y',' Z']
  end
  if $auswahl == 3
  LETTER_TABLE = [ '','','','','','','','','','',
                   '','','','','','','','',
                   '','','','','','','','']
  end
  if $auswahl == 4
  LETTER_TABLE = [ ' Α',' Β',' Γ',' Δ',' Ε',' Ζ',' Η',' Θ',' Ι',' Κ',
                  ' Λ',' M',' N',' Ξ',' O',' Π',' Ρ',' Σ',
                  ' Τ',' Υ',' Φ',' Χ',' Ψ',' Ω','','']
  end
  if $auswahl == 5
  LETTER_TABLE = [ ' α',' β',' γ',' δ',' ε',' ζ',' η',' θ',' ι',' κ',
                  ' λ',' μ',' ν',' ξ',' ο',' π',' ρ',' σ',
                  ' τ',' υ',' φ',' χ',' ψ',' ω','','']
  end
end