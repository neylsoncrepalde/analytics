# Graduação em Data Science
# Analytics
# Professor Neylson Crepalde
# Exercício avaliativo
################################

# 3 regressões
# 1) Vamos explicar o estatus sócio econômico de uma pessoa em
# 2014. Para isso, estime uma regressão tendo como variável
# dependente isei88, e como covariáveis anosesco, isei88pai,
# escpai e escmãe. Interprete os resultados e teste o modelo 
# de acordo com os pressupostos de 
# linearidade, normalidade do erro, independência do erro,
# homoscedasticidade e multicolinearidade.

# Para estimar a primeira regressão, vamos usar o banco 
# de dados da PNAD 2014
library(haven)
bd = read_sav("https://github.com/neylsoncrepalde/MODUS/
              blob/master/PNAD2014_30a50_novo4.sav
              ?raw=true")


# 2) Vamos explicar a renda do indivíduo a partir de sua 
# idade e de sua escolaridade. Lembre-se de que trabalhar 
# com idade requer um tratamento especial no modelo de renda.
# Lembre-se também que a variável renda exige uma 
# transformação matemática. Essa transformação nos dará um
# modelo log-lin que possui interpretação dos betas em termos
# %.

#Para ler os dados da PNAD 96, use
library(haven)
bd = read_sav("https://github.com/neylsoncrepalde/MODUS/
              blob/master/PNAD96_25a60_Modus.sav?raw=true")


