import paho.mqtt.client as mqtt
import pandas as pd
from main_ai import check_room, validating_input

mqtt_server = "192.168.70.206"
MacList = []
RowsZeros = []
df = pd.DataFrame()
counter = 0
final_df = pd.DataFrame()

class ClassConnect:
    def __init__(self):
        # Inicializar o cliente MQTT
        self.client = mqtt.Client()
        self.client.on_connect = self.on_connect
        self.client.on_message = self.on_message

    def on_connect(self, client, userdata, flags, rc):
        print("Conectado com resultado code " + str(rc))
        client.subscribe("routerinfo")  # Subscreva ao tópico desejado

    def on_message(self, client, userdata, msg):
        global df, RowsZeros  # Referenciar as variáveis globais
        payload = msg.payload.decode('utf-8')  # Decodifica os bytes para uma string UTF-8
        print("Mensagem (" + msg.topic + "): " + payload)

        if self.update_dataset(payload):
            # Atualizar o DataFrame com as novas colunas (MACs)
            df = pd.DataFrame(columns=MacList)
            # Reinicializar RowsZeros com zeros para todas as colunas
            RowsZeros = [0] * len(MacList)
        
        self.update_rows(payload)

    def update_dataset(self, payload):
        if payload != 'START' and payload != 'FIM':
            dispName, ssid, mac, speed = payload.split(',')
            if ssid == 'WLL-Inatel' and mac not in MacList:
                MacList.append(mac)
                return True
        return False

    def update_rows(self, payload):
        global df, RowsZeros, dispName, final_df, test  # Referenciar as variáveis globais
        if payload != 'START' and payload != 'FIM' and len(RowsZeros) > 0 and len(MacList) > 0:
            dispName, ssid, mac, speed = payload.split(',')
            print(payload)
            print(dispName)
            if ssid == 'WLL-Inatel' and mac in MacList:
                RowsZeros[MacList.index(mac)] = int(speed)
        elif payload == 'FIM':
            # Adicionar RowsZeros como uma nova linha no DataFrame

            # df.loc[len(df)] = RowsZeros

            # Chamando a função para obter df_aux
            df_aux = validating_input(MacList, RowsZeros)
            linha = df_aux.iloc[0].tolist()
            print(linha)

            # # Convertendo a lista de volta para um DataFrame de uma única linha
            # linha_df = pd.DataFrame([linha], columns=df_aux.columns)

            # # # Adicionando a linha ao final_df
            # # final_df = pd.DataFrame()
            # test = final_df.join(linha_df)

            try: 
                final_df.loc[len(final_df) + 1] = linha
            except Exception as e:
                final_df.loc[0] = linha
                



            # # check_room(MacList, RowsZeros, dispName)
            # df_aux = validating_input(MacList, RowsZeros)
            # final_df = pd.DataFrame({})

            # print(df_aux.iloc[0].tolist())
            # final_df = final_df.append(df_aux.iloc[0].tolist(),  ignore_index=True)

            # # Reinicializar RowsZeros com zeros para todas as colunas
            # RowsZeros = [0] * len(MacList)
            # # Salvar o DataFrame em um arquivo CSV sempre com o mesmo nome
            test.to_csv("dataframe.csv", index=False)
            print("DataFrame salvo como dataframe.csv")
            print(final_df)

    def start(self):
        self.client.connect(mqtt_server, 1883, 60)  # Conecte-se ao broker MQTT
        self.client.loop_forever()  # Mantenha o cliente conectado e recebendo mensagens

# Criar uma instância da classe e iniciar a conexão
mqtt_client = ClassConnect()
mqtt_client.start()
