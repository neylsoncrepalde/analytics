## Analytics
## 2019/2
## Prof. Neylson Crepalde
## Ciências de Dados - Izabela Hendrix
######################################

###############################
## Aula 2 - Não linearidades ##
###############################
library(wooldridge)
library(tidyverse)

# Vamos investigar a relação entre salário e escolaridade
data(wage1)
wage1 = as_tibble(wage1)
wage1

hist(wage1$wage)

fit1 = lm(wage ~ educ, wage1)
summary(fit1)

# Verificando os resíduos
hist(resid(fit1))
plot(predict(fit1), resid(fit1))

# Produz 4 gráficos de avaliação
plot(fit1)


## Há uma transformação comum nesse caso - usar o logaritmo natural da renda
## Veja o que acontece com a renda quando a transformamos no ln
hist(log(wage1$wage))

# Vejamos como fica o ajuste da regressão
fit2 = lm(log(wage) ~ educ, wage1)
summary(fit2)

# Analisando os resíduos
hist(resid(fit2))
plot(predict(fit2), resid(fit2))

plot(fit2)

# Como fica a interpretação dos resultados nesse caso?
coef(fit2)

# Para interpretar o intercepto, tiramos o exponencial
exp(coef(fit2)[1])
# Espera-se que uma pessoa sem nenhuma escolaridade tenha renda de 
# 1.79 dólares por hora

coef(fit2)[2]
# Para cada ano a mais de educação, espera-se que a pessoa tenha um aumento médio de
# 8,27% na renda

# Esta regressão é comumente chamada de log-lin.
# Possui o Regressando na escala logarítmica e o regressor na escala linear

#######################
## Regressão log-log ##
#######################

# Há casos em que também podemos ter a regressõa com os dois lados 
# da equação na escala log
# Vamos estudar o efeito das vendas sobre o salário anual dos CEO's
data("ceosal1")
fit3 = lm(salary ~ sales, ceosal1)
summary(fit3)

# Regressão não explica quase nada
hist(resid(fit3))
plot(predict(fit3), resid(fit3))

# Ajuste horroroso!
# Mas... se transformarmos ambos os lados em log
plot(log(ceosal1$sales), log(ceosal1$salary))

fit4 = lm(log(salary) ~ log(sales), ceosal1)
summary(fit4)
## Wow!!! Saímos de um R2 de 1% para 20%
hist(resid(fit4))
plot(predict(fit4), resid(fit4))

## Como fica a interpretação dos resultados?
# Para o intercepto, tiramos o exponencial para voltar à escala original
exp(coef(fit4)[1])
# Espera-se que um CEO sem vendas tenha uma renda anual de 124 mil dólares

coef(fit4)[2]
# Para cada aumento de 1% nas vendas, espera-se um aumento médio de 0.26% no salário do CEO
