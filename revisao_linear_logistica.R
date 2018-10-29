### Exercício - Revisão
### Regressão linear - Regressão logística

library(dplyr)
library(ggplot2)
library(texreg)
library(descr)

bd = mtcars
names(bd)

# Parte A - regressão linear

# Monte 3 modelos de regressão. Todos eles devem explicar o consumo do carro (mpg) através de seus atributos.
# No primeiro, utilize o peso do carro (wt) para explicar o consumo. No segundo, use a potência em cavalos (hp)
# Na terceira use as duas variáveis juntas. Apresente uma tabela com os resultados das 3 regressões juntas.

# 1) Interprete os resultados das 3 regressões
# 2) Qual dos modelos melhor se ajusta aos dados? Por quê?
# 3) Os pressupostos do modelo de regressão estão sendo respeitados no melhor modelo? Mostre.

# 4) Agora, ao melhor modelo, adicione a variável "transmissão automática" (am). Interprete os resultados 
# deste modelo. Ele é melhor ou pior que o modelo estimado anteriormente? Explique.


# Parte B - Regressão logística

# Agora, vamos utilizar um modelo logístico para explicar as chances de um nenê recém-nascido ter 
# baixo peso ao nascer. Para isso, carregamos o banco de dados lowbt direto do repositório github
library(haven)
bd = read_dta("https://github.com/neylsoncrepalde/analytics/blob/master/lowbwt.dta?raw=true")
names(bd)

# A variável dependente é, portanto, lbw (baixo peso ao nascer). Utilize a variável idade (age) e a variável
# É fumante (smoke) para explicar a dependente. A seguir estime outro modelo utilizando as variáveis
# peso da mãe no último período menstrual (lwt) e É fumante (smoke). Apresente os resultados dos dois modelos
# numa única tabela

# 1) Qual dos dois modelos se ajusta melhor aos dados? Por quê? Explique quais foram os critérios que você adotou
# para se decidir.
# 2) Interprete os resultados de maneira substantiva com os coeficientes do jeito como eles vem na tabela.
# 3) Calcule as chances relativas a partir dos coeficientes estimados e interprete os resultados.
# 4) Calcule a probabilidade de uma criança ter baixo peso ao nascer dado que sua mãe tinha peso igual a 120 libras
# e seja não fumante.
# 5) Calcule a probabilidade de uma criança ter baixo peso ao nascer dado que mão tinha pesoa igual a 140 libras
# e seja fumante.
