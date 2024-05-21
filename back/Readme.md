# Indoor-Tracking-BACKEND

## Descrição
Este projeto é uma API de gerenciamento de equipamentos que permite criar, ler, atualizar e deletar usuários, salas e equipamentos. Cada equipamento adicionado pode ser associado à um rastreador que atualiza um banco de dados e gera um histórico de posicionamento. Uma inteligência artificial lê os dados de treinamento gerados para a calibração pelo usuário e cria um modelo de decisão baseado em Machine Learning capaz de decidir em que sala o equipamento está e gerar um log no BD. Os logs são então mostrados no front end em formato de histórico de localização.

## Instalação
?

### Pré-requisitos
- Python
-- Pandas
- MongoDB
- Mosquitto MQTT Broker
- Arduino IDE
-- WiFi
-- PubSubClient

### Passos para Instalação
1. Instale o Broker MQTT Mosquitto: https://mosquitto.org/download/

Mosquitto é um popular broker MQTT que facilita a comunicação entre dispositivos através do protocolo MQTT. Este guia irá ajudá-lo a configurar e utilizar o Mosquitto no seu projeto.

1.1. No local de instalação substitua o arquivo mosquitto.conf pelo arquivo com o mesmo nome neste projeto 
- back\mqtt_service\mosquitto.conf

1.2. Teste o funcionamento do broker:

    Window+R para abrir o executar
    digite cmd e pressione Ctrl+Shift+Enter para abrir o cmd como administrador
    utilize o comando "net start mosquitto" para verificar o funcionamento do serviço

    - abra dois terminais (CMD) e execute o comando abaixo nos dois
    ".cd [path de instalção do mosquitto]"

    - em um deles use mosquitto_pub -h localhost -t test/topic -m "Hello MQTT"
    mosquitto_sub -h localhost -t test/topic

    - no outro utilize o comando abaixo e verifique se as mensagens estão sendo enviadas e recebidas
    mosquitto_pub -h localhost -t test/topic -m "Hello MQTT"

2. Instale o Arduino IDE: https://www.arduino.cc/en/software

2.1. Na barra de ícones à esquerda do bloco de texto selecione o library manager, busque e instale as bibliotecas WiFi e PubSubClient
- As que não estiverem disponíveis pela busca instalar pelo seguinte método:

    Abra a Arduino IDE.
    Vá em File > Preferences.
    Na seção Additional Boards Manager URLs, adicione a URL: 
    https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
    Clique em "OK".

2.2. Instalar Suporte à Placa ESP32:

    Vá em Tools > Board > Boards Manager.
    Pesquise por "esp32" e instale o pacote "esp32 by Espressif Systems".
    Vá em Tools > Board e selecione a placa ESP32 que você está usando (por exemplo, ESP32 Dev Module).





