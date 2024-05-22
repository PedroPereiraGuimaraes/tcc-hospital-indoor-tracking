
from autogluon.tabular import TabularDataset, TabularPredictor

#Importar tabela de dados
train_data = TabularDataset(f'{data_url}train.csv')

#Observar tabela
print(train_data.head())

#Escolher coluna de saída
label = 'signature'

#Observar coluna de saída
print(train_data[label].describe())

#Treinar modelos
predictor = TabularPredictor(label=label).fit(train_data)

#Testar modelos e obter avaliações
test_data = TabularDataset(f'{data_url}test.csv')

y_pred = predictor.predict(test_data.drop(columns=[label]))
y_pred.head()

predictor.evaluate(test_data, silent=True)

predictor.leaderboard(test_data)