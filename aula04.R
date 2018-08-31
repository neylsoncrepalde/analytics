### Analytics
## Aula 4
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
dim(bd)

### Uma regressão problemática
## Vamos tentar uma regressão onde os anos de escolaridade explicam
## a renda
reg = lm(renda ~ anosesco, bd)
summary(reg)

# Esta regressão nos diz que o rendimento esperado de um indivíduo que possui
# 0 escolaridade é -472.41 reais. Meio estranho, não? Vamos verificar algun
# pressupostos desse modelo...

# 1) Linearidade
ggplot(bd, aes(y = renda, x = anosesco)) +
  geom_point()

# A relação não parece muito linear. Vamos ver a distribuição dos erros:
e = residuals(reg)
hist(e)
qqnorm(e)

# Está bastante problemático. A questão é que a variável renda possui uma
# distribuição essencialmente exponencial que não nos permite uma modelagem
# adequada. Vamos fazer uma transformação na variável resposta e usar uma
# versão log-lin desse modelo. Vamos tirar o logaritmo natural da renda.

summary(bd$renda)
bd$logrenda = log(bd$renda)

# Agora vamos rodar o modelo log-linear
reg1 = lm(logrenda ~ anosesco, bd)
summary(reg1)

# Para interpretarmos os coeficientes do segundo modelo, precisamos fazer uma
# transformação no coeficiente estimado, a saber, tirar o seu exponencial.

b0 = exp(reg1$coefficients[1])
b0
# Agora este estimador faz sentido. Uma pessoa que possui 0 anos de
# escolaridade completos tem uma renda esperada de 593 reais.
# Como vamos interpretar o coeficiente de anosesco? Em termos percentuais.
b1 = reg1$coefficients[2]
b1

# Cada 1 ano a mais de escolaridade do indivíduo aumenta, em média, a renda em
# 11,74%. Este coeficiente corresponde a uma taxa simples. Para sabermos
# qual é a renda esperada para um indivíduo em qualquer ponto da curva,
# precisamos utilizar uma taxa composta calculada com a seguinte formula
# exp(b1) - 1

tx_comp = exp(b1) - 1
tx_comp

# Para um indivíduo com 8 anos de escolaridade:
b0 * exp(b1) * 8

### Vamos verificar agora os pressupostos do modelo:
# 1) Linearidade
ggplot(bd, aes(y = logrenda, x = anosesco)) +
  geom_point() +
  geom_abline(intercept = b0,
              slope = b1,
              col = 'red', lwd = 2)

# 2) Normalidade do erro
e = residuals(reg1)
qqnorm(e)

# 3) Homoscedasticidade
# 4) Independência do erro
plot(reg1)
