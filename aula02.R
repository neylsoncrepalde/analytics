### Analytics
## Aula 2
## Prof. Neylson Crepalde
##########################

library(ggplot2)
library(dplyr)

# Plotando um gráfico para exemplo:
x = rnorm(1000, mean = 1)
y = 3*x + 2*rnorm(1000, mean = 1)

ggplot(NULL, aes(x, y)) + #geom_point() +
  geom_vline(xintercept = 0) + geom_hline(yintercept = 0) +
  stat_smooth(method = 'lm', se = F, col = 'red')


# Studying the DIAMONDS data
data("diamonds")

dim(diamonds)
str(diamonds)
diamonds
?diamonds

# Verificando o peso do diamante
summary(diamonds$carat)
# Verificando o preço do diamente
summary(diamonds$price)

# Vamos investigar se há relação entre o peso e o preço
diamonds %>% 
  ggplot(aes(x = carat, y = price))+
  geom_point()


# Agora, vamos estimar um modelo de regressão linear com a seguinte formula
# price = b0 + b1*carat + e
reg = lm(price ~ carat, data = diamonds)
summary(reg) # Verifica resultados
