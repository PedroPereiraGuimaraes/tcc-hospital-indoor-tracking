from autogluon.tabular import TabularDataset, TabularPredictor
import pandas as pd

#Importar tabela de dados
import pandas as pd

#Substitua 'caminho/do/seu/arquivo.csv' pelo caminho real do seu arquivo CSV
caminho_do_arquivo = 'C:\Users\mable\Documents\tcc-hospital-indoor-tracking\back\trainingData\roomData\joinTables.csv'
train_data = pd.read_csv(caminho_do_arquivo)

#Exibir as primeiras linhas do dataset
print(train_data.head())

#Escolher coluna de saída
label = 'sala'

#Observar coluna de saída
print(train_data[label].describe())