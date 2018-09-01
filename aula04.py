"""
Python code to analyze PNAD 2014 data and build a simple regression model
Script: Prof. Neylson Crepalde
Class: Analytics
"""
import numpy as np
import pandas as pd
import statsmodels.formula.api as sm
import re

bd = pd.read_csv("https://github.com/neylsoncrepalde/introducao_ao_r/\
blob/master/dados/pes_2012.csv?raw=true")

bd.shape
bd.columns
bd.head()
bd.V0302 = bd.V0302.astype("category")
bd.V0404 = bd.V0404.astype("category")
bd.loc[bd["V4718"] == "Sem declaração", "V4718"] = np.nan
bd.loc[bd["V4720"] == "Sem declaração", "V4720"] = np.nan
bd.V4718 = pd.to_numeric(bd.V4718)
bd.V4720 = pd.to_numeric(bd.V4720)

# Corrigindo os anos de escolaridade
bd.V4803.value_counts()
bd.loc[bd.V4803 == "Sem instrução e menos de 1 ano", "V4803"] = 0
bd.loc[bd.V4803 == "Não determinados ", "V4803"] = np.nan


def keepNumbers(obj):
    res = []
    for i in range(len(obj)):
        x = re.sub("[A-Za-z]", "", str(obj[i]))
        x = re.sub(" ", "", x)
        res.append(x)
    return res

bd["anosesco"] = keepNumbers(bd.V4803)
bd.anosesco = pd.to_numeric(bd.anosesco)
bd.anosesco.describe()
# Cria a idade centralizada na media
bd["idadecen"] = bd.V8005 - bd.V8005.mean()
bd.idadecen.describe()
bd.V8005.describe()

# Cria o log da renda
bd["logrenda"] = np.log(bd.V4720 + 0.01)
bd.logrenda.describe()

# Roda o modelo de regressão
res = sm.ols('logrenda ~ anosesco', bd).fit()
print(res.summary())
b0 = np.exp(res.params[0])
b1 = res.params[1]
tx_comp = np.expm1(res.params[1])
