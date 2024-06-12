import pandas as pd

def getRSSI(MacList, RowsZeros):
    # Leitura dos dados
    all_addresses = pd.read_csv(r'back\trainingData\roomData\train_dataset.csv')

    # Lista de todas as colunas de MAC que deveriam existir
    all_mac_columns = all_addresses.columns.tolist()

    # Encontrar as colunas de MAC que estão faltando na tabela de RSSI
    missing_columns = [col for col in all_mac_columns if col not in rssi_values.columns]

    # Adicionar as colunas faltantes com valores 0
    for col in missing_columns:
        rssi_values[col] = 0

    # Ordenar as colunas de RSSI para combinar com a ordem das colunas de MAC
    rssi_values = rssi_values[all_mac_columns]

    # Juntar as tabelas (se necessário, ajuste conforme a lógica de combinação desejada)
    result = mac_addresses.join(rssi_values.set_index(mac_addresses.columns.tolist()[0]), on=mac_addresses.columns.tolist()[0])

    # Salvando o resultado
    result.to_csv('/mnt/data/merged_result.csv', index=False)
    result.to_excel('/mnt/data/merged_result.xlsx', index=False)

    print(result)