import pandas as pd
from sklearn.model_selection import train_test_split
import os

def joinTables(directory):
    arquivos_csv = [arq for arq in os.listdir(directory) if arq.endswith('.csv')]

    dfs = []

    # Loop para ler cada arquivo CSV e adicionar ao DataFrame
    for arquivo in arquivos_csv:
        caminho_arquivo = os.path.join(directory, arquivo)
        df = pd.read_csv(caminho_arquivo, delimiter=',')
        # Adiciona uma coluna 'Arquivo' com o nome do arquivo de onde os dados vieram
        df['Sala'] = arquivo
        
        dfs.append(df)

    # Concatena todos os DataFrames em um único DataFrame
    df_final = pd.concat(dfs, ignore_index=True)
    df_final.fillna(0, inplace=True)       # Substitui NaN por 0

    df_final['Sala'] = df_final['Sala'].str.replace('.csv', '', regex=False)

    # Salvando novo dataFrame 
    df_final.to_csv(r'back\trainingData\joinData\joinTables.csv', index=False, sep=',')


# Divides data into training and testing data and save it in .csv files
def split_data():
    # Load full dataset
    df = pd.read_csv(r'back\trainingData\joinData\joinTables.csv')

    #  Divides data into training and testing dat
    train_df, test_df = train_test_split(df, test_size=0.2, random_state=42)

    # Save training and testing sets to CSV files
    train_df.to_csv(r'back\trainingData\joinData\train_dataset.csv', index=False)
    test_df.to_csv(r'back\trainingData\joinData\test_dataset.csv', index=False)




# Test
# split_data()
# directory = 'back/trainingData/roomData'
# joinTables(directory)
# print(df_final)
