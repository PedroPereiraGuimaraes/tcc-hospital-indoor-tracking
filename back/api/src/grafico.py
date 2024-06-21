import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Ler o arquivo CSV
df = pd.read_csv(r'back\trainingData\roomData\graph_dataset.csv')

# Ordenar o DataFrame pelo número da sala
df = df.sort_values(by='Sala')

# Definir uma paleta de cores com tons de azul e verde escuro
cores_azuis_verdes = plt.cm.viridis(np.linspace(0.2, 0.7, len(df.columns[:-1])))

# Plotar o gráfico de barras
plt.figure(figsize=(12, 8))
for i, (coluna, cor) in enumerate(zip(df.columns[:-1], cores_azuis_verdes)):
    plt.bar(df['Sala'], df[coluna], color=cor, label=coluna)

plt.xlabel('Sala')
plt.ylabel('Intensidade de Sinal')
plt.title('Intensidade de Sinal dos Roteadores em Cada Sala')
plt.legend(loc='upper right', bbox_to_anchor=(1.25, 1))
plt.xticks(df['Sala'])
plt.yticks([])  # Remover os valores do eixo y
plt.tight_layout()
plt.show()
