# Trabalho Final: Estatística Espacial

Este repositório contém o desenvolvimento do Trabalho Final da disciplina de **Estatística Espacial**. O objetivo é realizar uma análise de dados espaciais sobre os preços de imóveis em Glasgow, Escócia, utilizando o software R.

---

## 📊 Descrição dos Dados
A análise baseia-se em dados de preços medianos de imóveis em Glasgow por zonas intermediárias (total de 270 zonas) referentes ao ano de 2008.

### Arquivos de Base
* `preco_propriedade.xlsx`: Base de dados principal.
* `Glasgow.shp`: Arquivo de malha geográfica (shapefile).

### Dicionário de Variáveis
As colunas do conjunto de dados incluem:
* **IZ**: Identificador único de cada zona intermediária[cite: 10].
* **preco**: Preço mediano dos imóveis.
* **crime**: Taxa de criminalidade por 10.000 pessoas.
* **comodos**: Número mediano de cômodos no imóvel.
* **vendas_propriedades**: Porcentagem de imóveis vendidos no ano.
* **temp_shopping**: Tempo médio de condução até um shopping center (minutos).
* **tipo**: Tipo predominante de imóvel.

---

## 📝 Questões e Requisitos
Ao realizar as análises, para cada teste de hipótese, deve-se apresentar a hipótese nula ($H_0$), a alternativa ($H_1$) e o nível de significância adotado.

1. **Mapa Coroplético Estático**: Criar mapa para a variável `preco` com 5 faixas de amplitudes iguais.
2. **Mapa Coroplético Interativo**: Criar mapa para a variável `preco` com 8 faixas baseadas em quantis.
3. **Matriz de Vizinhança**: Definir a matriz com base no critério de contiguidade (bordas comuns.
4. **Autocorrelação Global**: Avaliar a existência de autocorrelação global (significância de 5%).
5. **Autocorrelação Local**: Avaliar a autocorrelação local e gerar mapa de clusters significativos.

---

## 🛠️ Instruções de Execução
1. Certifique-se de que os arquivos `.xlsx` e `.shp` estejam no mesmo diretório de trabalho.
2. Utilize o script `.R` para reproduzir as análises e gerar o relatório final.
