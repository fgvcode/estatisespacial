# Trabalho Final: Estatística Espacial

Este repositório contém o desenvolvimento do Trabalho Final da disciplina de **Estatística Espacial**[cite: 2]. [cite_start]O objetivo é realizar uma análise de dados espaciais sobre os preços de imóveis em Glasgow, Escócia, utilizando o software R.

---

## 📊 Descrição dos Dados
A análise baseia-se em dados de preços medianos de imóveis em Glasgow por zonas intermediárias (total de 270 zonas) referentes ao ano de 2008.

### Arquivos de Base
* [cite_start]`preco_propriedade.xlsx`: Base de dados principal[cite: 8].
* [cite_start]`Glasgow.shp`: Arquivo de malha geográfica (shapefile)[cite: 18].

### Dicionário de Variáveis
As colunas do conjunto de dados incluem:
* [cite_start]**IZ**: Identificador único de cada zona intermediária[cite: 10].
* [cite_start]**preco**: Preço mediano dos imóveis[cite: 11].
* [cite_start]**crime**: Taxa de criminalidade por 10.000 pessoas[cite: 13].
* [cite_start]**comodos**: Número mediano de cômodos no imóvel[cite: 13].
* [cite_start]**vendas_propriedades**: Porcentagem de imóveis vendidos no ano[cite: 14].
* [cite_start]**temp_shopping**: Tempo médio de condução até um shopping center (minutos)[cite: 15].
* [cite_start]**tipo**: Tipo predominante de imóvel[cite: 17].

---

## 📝 Questões e Requisitos
[cite_start]Ao realizar as análises, para cada teste de hipótese, deve-se apresentar a hipótese nula ($H_0$), a alternativa ($H_1$) e o nível de significância adotado[cite: 19].

1. [cite_start]**Mapa Coroplético Estático**: Criar mapa para a variável `preco` com 5 faixas de amplitudes iguais[cite: 21].
2. [cite_start]**Mapa Coroplético Interativo**: Criar mapa para a variável `preco` com 8 faixas baseadas em quantis[cite: 22].
3. [cite_start]**Matriz de Vizinhança**: Definir a matriz com base no critério de contiguidade (bordas comuns)[cite: 23].
4. [cite_start]**Autocorrelação Global**: Avaliar a existência de autocorrelação global (significância de 5%)[cite: 24].
5. [cite_start]**Autocorrelação Local**: Avaliar a autocorrelação local e gerar mapa de clusters significativos[cite: 25].

---

## 🛠️ Instruções de Execução
1. Certifique-se de que os arquivos `.xlsx` e `.shp` estejam no mesmo diretório de trabalho.
2. Utilize o script `.R` para reproduzir as análises e gerar o relatório final.
