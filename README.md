# TCC-hospital--indoor-tracking

**Coleta de Dados:**
Em diferentes ambientes (por exemplo, sala de manutenção, enfermaria, UTI), colete amostras dos sinais WiFi recebidos por um dispositivo móvel (como um ESP32) em várias localizações.
Rotule essas amostras com o ambiente correspondente (por exemplo, sala de manutenção = 1, enfermaria = 2, UTI = 3).

**Pré-processamento de Dados:**
Extraia características dos sinais WiFi recebidos, como intensidade do sinal (RSSI), identificadores de ponto de acesso (BSSID), entre outros.
Normalize ou padronize os dados, se necessário.

**Divisão dos Dados:**
Divida os dados em conjuntos de treinamento e teste. O conjunto de treinamento será usado para treinar o modelo, enquanto o conjunto de teste será usado para avaliar a precisão do modelo.

**Escolha do Modelo:**
Escolha um modelo de classificação adequado para o seu problema. Algoritmos comuns incluem K-Vizinhos Mais Próximos (K-NN), Árvores de Decisão, Máquinas de Vetores de Suporte (SVM), Redes Neurais, entre outros.

**Treinamento do Modelo:**
Treine o modelo de aprendizado de máquina usando o conjunto de treinamento. O modelo aprenderá a associar padrões nos dados de entrada (sinais WiFi) aos rótulos de saída (ambientes).

**Avaliação do Modelo:**
Avalie o desempenho do modelo usando o conjunto de teste. Meça métricas como precisão, recall, F1-score, entre outros, para entender o quão bem o modelo está performando.

**Uso do Modelo:**

Uma vez treinado e avaliado, o modelo estará pronto para uso. Você pode implantá-lo em seu dispositivo ESP32 para fazer previsões em tempo real com base nos sinais WiFi recebidos.
É importante notar que a qualidade dos dados de treinamento e a escolha do modelo terão um grande impacto na precisão do seu sistema de classificação. Experimente diferentes algoritmos e técnicas de pré-processamento para obter os melhores resultados. Além disso, atualizações periódicas do modelo podem ser necessárias para manter a precisão à medida que o ambiente muda.
