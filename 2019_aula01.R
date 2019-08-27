#######################################
## Ciências de Dados - Izabela Hendrix
## Analytics
## Prof. Dr. Neylson Crepalde
## 2019/2
#######################################

install.packages("wooldridge")
install.packages("tidyverse")
install.packages("testthat")

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


################################################
# Verificando propriedades algébricas do modelo
################################################

# 1) A média dos resíduos é igual a 0
mean(resid(fit3))

# 2) a covariância dos regressores e do resíduo é igual a 0
cov(vote1$shareA, resid(fit3))


## Verifica a soma dos quadrados total
# Soma dos quadrados totais
# SQT = somatório de (y - y_barra)^2
SQT = sum((vote1$voteA - mean(vote1$voteA))^2)

# Soma dos quadrados explicada
# SQE = somatório de (yhat - y_barra)^2
yhat = predict(fit3)
SQE = sum((yhat - mean(vote1$voteA))^2)

# Soma dos quadrados dos resíduos
# SQR - somatório de u^2
SQR = sum(resid(fit3)^2)

## SQT = SQR + SQE
testthat::expect_equal(SQT, SQR + SQE)

####################################################
## Grau de ajuste / coeficiente de determinação R^2
####################################################

# R^2 = SQE/SQT = 1 - SQR/SQT
testthat::expect_equal(SQE/SQT, 1 - SQR/SQT)
cat(paste("R^2 =", round(SQE/SQT, 4)))


#Vejamos o coeficiente de determinação da primeira regressão ceosal1
summary(fit)$r.squared
