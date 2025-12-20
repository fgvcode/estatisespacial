# Análise Espacial de Preços de Imóveis em Glasgow

Este repositório contém um projeto de estatística espacial desenvolvido para a disciplina de Estatística Espacial. O objetivo é analisar a dependência espacial dos preços das propriedades em Glasgow utilizando o Índice de Moran.

## 📂 Estrutura do Repositório

- `dados/`: Contém os arquivos Shapefile (.shp, .shx, .dbf, .prj) e a planilha de preços (.xlsx).
- `relatorio_atividade.Rmd`: Arquivo R Markdown com a análise completa e interpretações.
- `trabalho_final.R`: Script R com a lógica de processamento e cálculos estatísticos.
- `Trabalho Final.pdf`: Descritivo oficial da atividade que está na pasta dados.

## 🛠️ Metodologia Aplicada

A análise segue o seguinte fluxo estatístico:
1. **Unificação de Dados:** Cruzamento entre dados censitários (Intermediate Zones) e preços de venda.
2. **Matriz de Vizinhança:** Criação de matriz de contiguidade (Critério Queen).
3. **Moran Global:** Teste de hipótese para verificar se existe autocorrelação espacial (clumping) nos preços.
4. **Moran Local (LISA):** Identificação de clusters espaciais (High-High, Low-Low).



## 🚀 Como Executar

1. Clone o repositório.
2. Certifique-se de que os pacotes `sf`, `readxl`, `spdep`, `tidyverse` e `tmap` estão instalados.
3. Execute o script `trabalho_final.R` ou faça o "Knit" do `relatorio_atividade.Rmd`.
