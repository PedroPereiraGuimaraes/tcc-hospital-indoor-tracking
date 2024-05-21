#include <WiFi.h>
#include <PubSubClient.h>

// Nome do aparelho
String nome = "ESP1";

// Substitua pelos seus dados de rede
const char* ssid = "EspTest";
const char* password = "32323232";

// Substitua pelo endereço IP do seu broker MQTT
const char* mqtt_server = "192.168.180.86";

WiFiClient espClient;
PubSubClient client(espClient);

void setup_wifi() {
  delay(10);
  // Conecta ao Wi-Fi
  Serial.println();
  Serial.print("Conectando a ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  // Espera até que a conexão Wi-Fi seja estabelecida
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi conectado");
  Serial.println("Endereço IP: ");
  Serial.println(WiFi.localIP());

  // Inicializa o Wi-Fi
  WiFi.mode(WIFI_STA);

  Serial.println("Escaneando pontos de acesso...");
}

void reconnect() {
  // Loop até que estejamos reconectados ao servidor MQTT
  while (!client.connected()) {
    Serial.print("Tentando conexão MQTT...");
    // Tente se conectar ao servidor MQTT
    if (client.connect("ESP32Client")) {
      Serial.println("conectado");
      // ... e ressubscreva
      client.subscribe("routerinfo");
    } else {
      // Se a conexão falhar, exiba o código de retorno (rc) e tente novamente em 5 segundos
      Serial.print("falhou, rc=");
      Serial.print(client.state());
      Serial.println(" tentando novamente em 5 segundos");
      delay(5000);
    }
  }
}

void setup() {
  Serial.begin(115200);
  // Inicialização da conexão Wi-Fi
  setup_wifi();
  // Configuração do servidor MQTT
  client.setServer(mqtt_server, 1883);
}

void loop() {

  int numRedes = WiFi.scanNetworks();
  // Realiza o escaneamento das redes Wi-Fi disponíveis

  String retorno = "";
  Serial.println(retorno);

  // Verifica se o cliente MQTT está conectado, se não estiver, tenta reconectar
  if (!client.connected()) {
    reconnect();
  }
  // Mantém a conexão MQTT ativa
  client.loop();

  client.publish("routerinfo", "START", true);
  Serial.println("Start");
  delay(500);

  // Exibe informações de cada ponto de acesso encontrado
  for (int i = 0; i < numRedes; i++) {
    String sSSID = WiFi.SSID(i);
    String BSSID = WiFi.BSSIDstr(i);
    String RSSI = String(WiFi.RSSI(i));
    retorno = nome + "," + sSSID + "," + BSSID + "," + RSSI;
    String msg = retorno;

    Serial.print("Publicando mensagem: ");
    Serial.println(msg);
    // Publicação da mensagem no tópico MQTT
    client.publish("routerinfo", msg.c_str(), true);
    delay(500);
  }
  client.publish("routerinfo", "FIM", true);
  Serial.println("Fim");
  delay(500);
}

