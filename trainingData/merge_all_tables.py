import pandas as pd
import os

def joinTables(directory):
    arquivos_csv = [arq for arq in os.listdir(directory) if arq.endswith('.csv')]

    dfs = []

    # Loop para ler cada arquivo CSV e adicionar ao DataFrame
    for arquivo in arquivos_csv:
        caminho_arquivo = os.path.join(directory, arquivo)
        df = pd.read_csv(caminho_arquivo, delimiter=',')
        # Adiciona uma coluna 'Arquivo' com o nome do arquivo de onde os dados vieram
        df['Arquivo'] = arquivo
        dfs.append(df)

    # Concatena todos os DataFrames em um único DataFrame
    df_final = pd.concat(dfs, ignore_index=True)

    # Salvando novo dataFrame 
    df_final.to_csv('roomData/joinTables.csv', index=False, sep=',')

directory = 'roomData'
joinTables(directory)
# print(df_final)
