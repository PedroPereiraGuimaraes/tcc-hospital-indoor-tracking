import paho.mqtt.client as mqtt
import pandas as pd
from main_ai import check_room, get_data_for_training

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
        global df, RowsZeros, dispName  # Referenciar as variáveis globais
        if payload != 'START' and payload != 'FIM' and len(RowsZeros) > 0 and len(MacList) > 0:
            dispName, ssid, mac, speed = payload.split(',')
            if ssid == 'WLL-Inatel' and mac in MacList:
                RowsZeros[MacList.index(mac)] = int(speed)
        elif payload == 'FIM':
            
            # Check which room the esp is in through the macs and update the data if necessary
            # check_room(MacList, RowsZeros, dispName)

            # If you are collecting data for training, use this function and comment on the one above
            get_data_for_training(MacList, RowsZeros)
            

    def start(self):
        self.client.connect(mqtt_server, 1883, 60)  # Conecte-se ao broker MQTT
        self.client.loop_forever()  # Mantenha o cliente conectado e recebendo mensagens

# Criar uma instância da classe e iniciar a conexão
mqtt_client = ClassConnect()
mqtt_client.start()
