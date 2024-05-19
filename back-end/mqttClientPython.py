import paho.mqtt.client as mqtt
import pandas as pd

MacList = []
RowsZeros = []


class ClassConnect:
    def __init__(self):
        # Inicializar o cliente MQTT
        self.client = mqtt.Client()
        self.client.on_connect = self.on_connect
        self.client.on_message = self.on_message

    def on_connect(self, client, userdata, flags, rc):
        print("Conectado com resultado code " + str(rc))
        client.subscribe("teste")  # Subscreva ao tópico desejado

    def on_message(self, client, userdata, msg):
        payload = msg.payload.decode('utf-8')  # Decodifica os bytes para uma string UTF-8
        print("Mensagem recebida no tópico " + msg.topic + ": " + payload)
        flag = True
        while (flag):
            self.update_dataset(payload)
            self.Update_Rows(payload)

    def update_dataset(self, payload):
        if payload != 'START':
            print('Entrou no start')
            if payload != 'FIM':
                print('Entrou no fim')
                print('PAYLOAD1213', payload)
                dispName, ssid, mac, speed = payload.split(',')
                print('SSID', ssid)
                if ssid == 'WLL-Inatel' and mac not in MacList:
                    MacList.append(mac)

            df = pd.DataFrame(columns=MacList)
            print('DEF2222', df)
            contagem = pd.Series(MacList).value_counts()
            print('CONTAGEM', contagem)
            print(df.head())
            RowsZeros = list(len(MacList) * [0])
    def Update_Rows(self, payload):

        if payload != 'START':

            if payload != 'FIM':
                print('Entrou no fim')
                print('PAYLOAD1213', payload)
                dispName, ssid, mac, speed = payload.split(',')
                print('SSID', ssid)
                if ssid == 'WLL-Inatel' and mac not in MacList:
                    RowsZeros[MacList.index(mac)] = speed
        else:
            RowsZeros = list(len(MacList))
    df = pd.DataFrame(columns=MacList)
    print('DEF2222', df)
    contagem = pd.Series(MacList).value_counts()
    print('CONTAGEM', contagem)
    print(df.head())


def start(self):
    self.client.connect("192.168.180.86", 1883, 60)  # Conecte-se ao broker MQTT
    self.client.loop_forever()  # Mantenha o cliente conectado e recebendo mensagens


# Criar uma instância da classe e iniciar a conexão
mqtt_client = ClassConnect()
mqtt_client.start()
