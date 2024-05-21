# 1 - Escrever o código que vai ficar escutando o MQTT do projeto
# 2 - Pegar as informações recebidas do MQTT e passar pora uma IA para prever a sala
# 3 - Com a sala definida, a gente faz a conexão com o banco de dados
# 4 - Com a conexão, é necessário verificar se precisa atualizar a sala
# 5 - Caso atualize a sala, é necessário atualizar o histórico

import pandas as pd
from mqttClientPython import ClassConnect


# String de entrada informações do MQTT
data_str = "AB:CD:FG:EH:RG:FR,80; AB:CD:FG:EH:RG:FR,80;"

# Remover o último ponto e vírgula caso exista
data_str = data_str.strip(';')

# Dividir a string em pares de MAC e velocidade
entries = data_str.split('; ')

# Listas para armazenar MACs e velocidades
mac_addresses = []
speeds = []

# Processar cada entrada
for entry in entries:
    mac, speed = entry.split(',')
    mac_addresses.append(mac)
    speeds.append(int(speed))

# Criar o DataFrame
df = pd.DataFrame({
    'MAC Address': mac_addresses,
    'Speed': speeds
})

# Exibir o DataFrame
print(df)
