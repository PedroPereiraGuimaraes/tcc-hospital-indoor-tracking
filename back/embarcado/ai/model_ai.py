
from autogluon.tabular import TabularDataset, TabularPredictor
import pandas as pd

def train_models():
    train_data = pd.read_csv(r'back\trainingData\joinData\train_dataset.csv')

    #Exibir as primeiras linhas do dataset
    print(train_data.head())

    #Escolher coluna de saída
    label = 'Sala'

    #Observar coluna de saída
    print(train_data[label].describe())

    #Treinar modelos
    predictor = TabularPredictor(label=label).fit(train_data)

    #Testar modelos e obter avaliações
    test_data = TabularDataset(r'back\trainingData\joinData\test_dataset.csv')

    y_pred = predictor.predict(test_data.drop(columns=[label]))
    y_pred.head()

    predictor.evaluate(test_data, silent=True)

    predictor.leaderboard(test_data)


# Based on the best model chosen from the training, the current room is found
def get_current_room_with_model(data):
    model_path = 'AutogluonModels/ag-20240615_135818'
    
    # Carregar o preditor salvo
    predictor = TabularPredictor.load(model_path)
    
    # Fazer predições nos novos dados usando o modelo `WeightedEnsemble_L2`
    predictions = predictor.predict(data, model='WeightedEnsemble_L2')

    # Exibir as predições
    print(f"resultado final: {predictions[0]}")
    return predictions[0]

# train_models()