
from autogluon.tabular import TabularDataset, TabularPredictor
from sklearn.model_selection import train_test_split
import pandas as pd

# # Carregar o dataset
# df = pd.read_csv(r'C:\Users\mable\Documents\tcc-hospital-indoor-tracking\back\trainingData\roomData\TabelaTratadaV2.csv')

# # Dividir os dados em conjuntos de treino e teste
# train_df, test_df = train_test_split(df, test_size=0.2, random_state=42)

# # Salvar os conjuntos de treino e teste em arquivos CSV
# train_df.to_csv('train_dataset.csv', index=False)
# test_df.to_csv('test_dataset.csv', index=False)


train_data = pd.read_csv(r'back\trainingData\roomData\train_dataset.csv')

#Exibir as primeiras linhas do dataset
print(train_data.head())

#Escolher coluna de saída
label = 'Sala'

#Observar coluna de saída
print(train_data[label].describe())

#Treinar modelos
predictor = TabularPredictor(label=label).fit(train_data)

#Testar modelos e obter avaliações
test_data = TabularDataset(r'back\trainingData\roomData\test_dataset.csv')

y_pred = predictor.predict(test_data.drop(columns=[label]))
y_pred.head()

predictor.evaluate(test_data, silent=True)

predictor.leaderboard(test_data)