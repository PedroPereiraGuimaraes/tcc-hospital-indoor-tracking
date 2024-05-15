#include <WiFi.h>
#include <PubSubClient.h>

// Substitua pelos seus dados de rede
const char* ssid = "SSID";
const char* password = "SENHA";

// Substitua pelo endereço IP do seu broker MQTT
const char* mqtt_server = "ServerIP";

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
      // Uma vez conectado, publique uma mensagem...
      client.publish("teste", "hello world");
      // ... e ressubscreva
      client.subscribe("teste");
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
  // Exibe informações de cada ponto de acesso encontrado
  for (int i = 0; i < numRedes; i++) {
    String bssid = WiFi.BSSIDstr(i);
    String RSSI = String(WiFi.RSSI(i));

    // Serial.print("BSSID: ");
    // Serial.println(bssid);
    // Serial.println("RSSI:");
    // Serial.println(RSSI);
    // Serial.println("-----------------------");
    retorno = retorno + bssid + "->" + RSSI + ";  ";
  }

  delay(1000);
  Serial.println(retorno);

  // Verifica se o cliente MQTT está conectado, se não estiver, tenta reconectar
  if (!client.connected()) {
    reconnect();
  }
  // Mantém a conexão MQTT ativa
  client.loop();

  // Publique mensagens a cada 2 segundos
  long now = millis();
  static long lastMsg = 0;
  if (now - lastMsg > 2000) {
    lastMsg = now;
    // Crie uma mensagem com um timestamp
    String msg = retorno;
    Serial.print("Publicando mensagem: ");
    Serial.println(msg);
    // Publique a mensagem no tópico MQTT
    client.publish("teste", msg.c_str());
  }
}
