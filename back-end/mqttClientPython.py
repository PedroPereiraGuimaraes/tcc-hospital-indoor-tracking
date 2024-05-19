import paho.mqtt.client as mqtt

# Função de callback quando o cliente recebe uma CONNACK do servidor
def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Conectado com sucesso ao broker MQTT")
    else:
        print(f"Falha ao conectar, código de erro {rc}")
    # Subscrição no tópico após conectar
    client.subscribe("teste", qos=1)

# Função de callback quando uma mensagem é recebida do servidor
def on_message(client, userdata, msg):
    print(f"Mensagem em {msg.topic}: {msg.payload.decode()}")

# Criação de um novo cliente MQTT
client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

# Conexão ao broker MQTT
client.connect("192.168.180.86", 1883, 60)

# Loop para processar as mensagens
try:
    client.loop_forever()
except KeyboardInterrupt:
    client.disconnect()
    print("Desconectado do broker MQTT")
