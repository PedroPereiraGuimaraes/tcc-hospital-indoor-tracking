import paho.mqtt.client as mqtt

def on_connect(client, userdata, flags, rc):
    print("Conectado com resultado code "+str(rc))
    client.subscribe("topico/teste")  # Subscreva ao tópico desejado

def on_message(client, userdata, msg):
    payload = msg.payload.decode('utf-8')  # Decodifica os bytes para uma string UTF-8
    print("Mensagem recebida no tópico " + msg.topic + ": " + payload)

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect("MQTT_SERVER_IP", 1883, 60)  # Conecte-se ao broker MQTT

client.loop_forever()  # Mantenha o cliente conectado e recebendo mensagens
