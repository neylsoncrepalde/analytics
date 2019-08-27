#######################################
## Ciências de Dados - Izabela Hendrix
## Analytics
## Prof. Dr. Neylson Crepalde
## 2019/2
#######################################

install.packages("wooldridge")
install.packages("tidyverse")

library(wooldridge)
library(tidyverse)

#########################################
##Salário do CEO e Retorno de patrimonio
#########################################
data("ceosal1")
ceosal1 = ceosal1 %>% as_tibble
?ceosal1

plot(ceosal1$roe, ceosal1$salary) # Tem 3 outliers bagunçando o esquema
plot(ceosal1$roe, ceosal1$salary, ylim = c(0,4000))

#dados necessários para calcular beta1
cov(ceosal1$roe, ceosal1$salary)
var(ceosal1$roe)
mean(ceosal1$salary)
mean(ceosal1$roe)

# Calculando beta1 a partir das formulas abaixo
# beta1 = cov(x, y) / var(x)
# beta0 = y_barra - beta1 * x_barra

b1hat = cov(ceosal1$roe, ceosal1$salary) / var(ceosal1$roe)
b0hat = mean(ceosal1$salary) - b1hat * mean(ceosal1$roe)

cat(paste("Beta0 =", b0hat))
cat(paste("Beta1 =", b1hat))


# Fazendo a mesma coisa via comando lm
fit = lm(salary ~ roe, ceosal1)
coef(fit)

#############################
## Renda por hora e educação
#############################
data("wage1")
wage1 = wage1 %>% as_tibble
?wage1

plot(wage1$educ, wage1$wage)

fit2 = lm(wage ~ educ, wage1)
coef(fit2)

####################################################
## Percentual de voto e percentual de gastos totais
####################################################
data("vote1")
vote1 = vote1 %>% as_tibble
?vote1

fit3 = lm(voteA ~ shareA, vote1)
coef(fit3)

# Plota a curva de regressão
plot(vote1$shareA, vote1$voteA)
abline(fit3, col="red", lwd=3)
