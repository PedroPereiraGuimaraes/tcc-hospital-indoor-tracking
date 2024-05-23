
from autogluon.tabular import TabularDataset, TabularPredictor
import pandas as pd

#Importar tabela de dados
import pandas as pd

#Substitua 'caminho/do/seu/arquivo.csv' pelo caminho real do seu arquivo CSV
caminho_do_arquivo = r'back\trainingData\roomData\TabelaTratada.csv'
train_data = pd.read_csv(caminho_do_arquivo)

#Exibir as primeiras linhas do dataset
print(train_data.head())

#Escolher coluna de saída
label = 'sala'

#Observar coluna de saída
print(train_data[label].describe())

#Treinar modelos
predictor = TabularPredictor(label=label).fit(train_data)

#Testar modelos e obter avaliações
test_data = TabularDataset(r'back\trainingData\roomData\TabelaTratada.csv')

y_pred = predictor.predict(test_data.drop(columns=[label]))
y_pred.head()

predictor.evaluate(test_data, silent=True)

predictor.leaderboard(test_data)