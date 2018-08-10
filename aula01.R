### Analytics
## Aula 1
## Prof. Neylson Crepalde
##########################

# Se as bibliotecas necessárias não estiveram instaladas, instale
if (!"readr" %in% installed.packages()) install.packages("readr")
if (!"dplyr" %in% installed.packages()) install.packages("dplyr")
if (!"ggplot2" %in% installed.packages()) install.packages("ggplot2")
if (!"haven" %in% installed.packages()) install.packages("haven")

# Carregando as bibliotecas necessárias
library(readr)
library(dplyr)
library(ggplot2)
library(haven)

# Carrega uma amostra da PNAD 2014

bd = read_sav("https://github.com/neylsoncrepalde/MODUS/blob/master/PNAD2014_30a50_novo4.sav?raw=true")

# Investigando o banco de dados

dim(bd) #tamanho
names(bd) #nomes das variáveis
head(bd) #primeiros casos

# Vamos investigar as variáveis isei88 e anos de escolaridade
# Que tipo de variáveis são?
class(bd$isei88)
class(bd$anosesco)

# Verificando estatísticas descritivas
summary(bd$isei88)
summary(bd$anosesco)

# Agora, vamos investigar a relação entre essas variáveis
ggplot(bd, aes(x = anosesco, y = isei88)) +
  geom_point()


# Se formos estimar uma relação entre essas variáveis, o que obtemos?
ggplot(bd, aes(x = anosesco, y = isei88)) +
  geom_point() +
  stat_smooth(method = "lm")


# Vamos verificar o coeficiente de correlação?
cor(bd$anosesco, bd$isei88)
