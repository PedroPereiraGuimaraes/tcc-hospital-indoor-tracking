#include <WiFi.h>

#define NUM_MEDICOES 20
#define INTERVALO_MEDICAO_MS 500 // Intervalo entre cada medição em milissegundos

void setup() {
  Serial.begin(115200);
  delay(1000);

  // Inicializa o Wi-Fi
  WiFi.mode(WIFI_STA);

  Serial.println("Escaneando pontos de acesso...");

  // Realiza o escaneamento das redes Wi-Fi disponíveis
  int numRedes = WiFi.scanNetworks();

  if (numRedes == 0) {
    Serial.println("Nenhum ponto de acesso encontrado");
  } else {
    Serial.print("Número de pontos de acesso encontrados: ");
    Serial.println(numRedes);

    // Exibe informações de cada ponto de acesso encontrado
    for (int i = 0; i < numRedes; i++) {
      String ssid = WiFi.SSID(i);
      String bssid = WiFi.BSSIDstr(i);
      float mediaRSSI = calcularMediaRSSI(ssid, NUM_MEDICOES);
      
      Serial.print("SSID: ");
      Serial.println(ssid);
      Serial.print("BSSID: ");
      Serial.println(bssid);
      Serial.print("Média do RSSI das últimas ");
      Serial.print(NUM_MEDICOES);
      Serial.println(" medições:");
      Serial.println(mediaRSSI);
      // Construir o JSON manualmente  
      String json = "{SSID: " + ssid + ",BSSID: " + bssid + ",NumMedicoes: " + String(NUM_MEDICOES)  + ",Media:" + String(mediaRSSI) + "}";   
      // Enviar o JSON pela porta serial  
      Serial.println(json);
      Serial.println("-----------------------");
    }
  }
}

void loop() {
  // Nada a ser feito no loop neste exemplo
}

float calcularMediaRSSI(String ssid, int numMedicoes) {
  float somaRSSI = 0;
  int contMedicoes = 0;

  // Realiza as medições e calcula a média apenas para o SSID especificado
  for (int i = 0; i < numMedicoes; i++) {
    // Escaneia novamente para garantir que estamos medindo o sinal correto
    int numRedes = WiFi.scanNetworks();
    for (int j = 0; j < numRedes; j++) {
      if (WiFi.SSID(j) == ssid) {
        somaRSSI += WiFi.RSSI(j);
        contMedicoes++;
        break; // Sai do loop interno assim que encontrar o SSID desejado
      }
    }
    delay(INTERVALO_MEDICAO_MS);
  }

  // Verifica se pelo menos uma medição foi feita para o SSID especificado
  if (contMedicoes >= 15) {
    return somaRSSI / contMedicoes;
  } else {
    Serial.println("Erro no cálculo da média.");
    return 0;
  }
}
