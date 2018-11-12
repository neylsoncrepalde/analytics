# Ciências de Dados - IMIH
# Analytics
# PCA
# Prof. Neylson Crepalde
###########################

# instala pacotes necessários
install.packages("devtools")
install.packages("FactoMineR")

# instala pacote com os bancos de dados que serão usados
devtools::install_git(url = "https://gitlab.c3sl.ufpr.br/pet-estatistica/labestData.git",
                      branch = "master", build_vignettes = TRUE)

library(labestData)
library(dplyr)
library(ggplot2)
library(FactoMineR)

# Dados do livro da profa. Sueli Mingoti (tabela 3.1)
bd = MingotiTb3.1

# Verificando estatísticas descritivas das variáveis
summary(bd)

# verificando a matriz de variância e covariância das variáveis
matriz_cov = cov(bd[2:4])

# Gera autovalores e percentual de explicação acumulada
autovalores <- eigen(matriz_cov)$values
perc.exp <- autovalores/sum(autovalores)
perc.exp.acum <- cumsum(perc.exp)

print(cbind(autovalores,perc.exp,perc.exp.acum))

#Calculando as CPs:
res.pca <- PCA(bd[2:4], scale.unit=FALSE, graph=FALSE, ncp=3)
res.pca$eig #Autovalores e % de explicação

# Verifica os loadings
loadings_pca1 <- sweep(res.pca$var$coord,2,
                       sqrt(res.pca$eig[1:ncol(res.pca$var$coord),1]),FUN="/")
print(loadings_pca1)

#Correlações entre as variáveis e CPs
cor_pca1 <- res.pca$var$cor; 
print(cor_pca1)

#Obtendo os escores de cada indivíduo em cada uma das PCs:
interesse = bd[,2:4]
scores_pca1 <- matrix( ,nrow(interesse),ncol(interesse))
for(i in 1:nrow(interesse)){
  for(j in 1:ncol(interesse)) scores_pca1[i,j] <- sum(interesse[i,]*loadings_pca1[,j])
}
print(scores_pca1)

# Exercício - estimar uma análise de componentes principais para os dados de avaliação de coxinhas
help("MingotiTb3.5")
bd = MingotiTb3.5
