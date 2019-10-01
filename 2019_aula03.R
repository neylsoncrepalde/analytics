### Analytics
### Ciências De Dados
### Prof. Dr. Neylson Crepalde
###############################

######################
## Regressão Múltipla
library(wooldridge)
library(dplyr)

## Exemplo do GPA
data(gpa1)
gpa1 = as_tibble(gpa1)
gpa1
names(gpa1)
?gpa1
#
fit = lm(colGPA ~ hsGPA + ACT, gpa1)
summary(fit)

# Calculando o intervalo de confiança dos coeficientes com o erro padrão
confint(fit) 

## Exemplo da renda
data(wage1)
wage1 = as_tibble(wage1)
?wage1

fit2 = lm(log(wage) ~ educ + exper + tenure, wage1)
summary(fit2)

## Calcula o intervalo de confiança dos coeficientes
confint(fit2)

#####################################
## Exemplo real com a PNADC
library(PNADcIBGE)

# Pega a pnad 
pnad = get_pnadc(2019, 2,
                 vars = c("Ano", "Trimestre", "UF", "Capital", "UPA", "Estrato", "V1022", "V1028", "V2007",
                          "V2009", "V2010", "VD3005", "VD4016", "VD4019", "VD4031"))

# Verifica - cria um objeto survey design
pnad

# Isola o banco de dados para 
bd = pnad$variables %>% as_tibble()

# Coloca anos de escolaridade como numérica
bd$anosesco = as.integer(bd$VD3005) - 1

#######################
## Regressão Polinomial
# Verificando a média do log da renda para cada idade
medias = sapply(25:60, function(x) mean(log(bd$VD4019[bd$V2009 == x]), na.rm=T))

plot(25:60, medias, type="p")


# Vamos testar um modelo de renda com idade e idade^2 conforme o gráfico anterior
fit3 = lm(log(VD4019) ~ V2009 + I(V2009^2), bd %>% filter(V2009 > 24, V2009 < 61))
summary(fit3)

library(car)
vif(fit3) ## Problema de multicolinearidade terrível!

# Precisamos tratar a idade centralizando-a na média
bd$idadecen = bd$V2009 - mean(bd$V2009, na.rm = T)

fit4 = lm(log(VD4019) ~ idadecen + I(idadecen^2), bd %>% filter(V2009 > 24, V2009 < 61))
summary(fit4)

vif(fit4)  # Resolveu o problema de multicolinearidade!
