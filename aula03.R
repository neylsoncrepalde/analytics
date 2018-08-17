### Analytics
## Aula 2
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

reg = lm(anosesco ~ escpai, bd)
summary(reg)

###
# Avaliando os pressupostos do modelo de regressão
###
# 1) Pressuposto de linearidade
ggplot(bd, aes(x = escpai, y = anosesco)) +
  geom_point()

# 2) Normalidade dos resíduos
e = reg$residuals

# Usando um histograma com curva de densidade
ggplot(NULL, aes(e)) + geom_histogram(aes(y = ..density..), color = 'white') +
  stat_function(fun = dnorm, args = list(mean = mean(e), sd = sd(e)),
                col = 'blue', lwd = 1)

# usando um qqplot (gráfico de probabilidade normal)
qqnorm(e)

##

# 3) Independência dos resíduos e 
# 4) Erro é homoscedástico
yhat = predict(reg)
ggplot(NULL, aes(x = yhat, y = e)) + geom_point() +
  stat_smooth(method = "lm")

# ou
# Podemos pedir os 4 gráficos de avaliação da regressão
par(mfrow = c(2,2))
plot(reg)
par(mfrow = c(1,1))


