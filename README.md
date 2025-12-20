# Análise Espacial de Preços de Imóveis em Glasgow

Este repositório contém um projeto de estatística espacial desenvolvido para a disciplina de Estatística Espacial. O objetivo é analisar a dependência espacial dos preços das propriedades em Glasgow utilizando o Índice de Moran.

## 📂 Estrutura do Repositório

- `dados/`: Contém os arquivos Shapefile (.shp, .shx, .dbf, .prj), planilha de preços (.xlsx) e Trabalho Final.pdf.
- `Trabalho Final.pdf`: Descritivo oficial da atividade.
- `relatorio_atividade.Rmd`: Arquivo R Markdown com a análise completa e interpretações.
- `trabalho_final.R`: Script R com a lógica de processamento e cálculos estatísticos.
  

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


# Análise de Autocorrelação Espacial: Preços Imobiliários em Glasgow

Este repositório contém o projeto final da disciplina de **Estatística III**, focado na aplicação de métodos de Estatística Espacial para analisar o mercado imobiliário da cidade de Glasgow (2008).

O objetivo principal é verificar se os preços das propriedades distribuem-se de forma aleatória ou se apresentam padrões de dependência espacial (clusters).

## 📂 Estrutura do Projeto

* **`dados/`**: Pasta contendo os arquivos geográficos (Shapefile) e a base de dados de preços (.xlsx).
* **`relatorio_atividade.Rmd`**: Documento principal em R Markdown que gera o relatório final com análises e mapas.
* **`trabalho_final.R`**: Script R auxiliar com a lógica de processamento.
* **`README.md`**: Instruções e documentação do projeto.

## 🛠️ Metodologia e Requisitos do Trabalho

A análise foi estruturada em 5 etapas principais:
1.  **Visualização Estática**: Mapa de preços com 5 faixas de amplitudes iguais.
2.  **Visualização Interativa**: Mapa de preços utilizando 8 faixas de quantis para maior detalhamento.
3.  **Matriz de Vizinhança**: Construção de pesos espaciais baseada no critério de contiguidade (Queen).
4.  **I de Moran Global**: Teste de hipótese para verificar a existência de autocorrelação espacial em toda a área de estudo.
5.  **I de Moran Local (LISA)**: Identificação de clusters significativos (High-High, Low-Low).



## 🚀 Como Executar

Para reproduzir esta análise localmente, siga os passos abaixo:

### 1. Pré-requisitos
Você precisará ter o **R** e o **RStudio** instalados, além dos seguintes pacotes:
```r
install.packages(c("sf", "readxl", "dplyr", "tmap", "spdep", "stringr"))
2. Configuração do Diretório
Certifique-se de que a estrutura de pastas foi mantida conforme o repositório original. O arquivo .Rmd busca os dados automaticamente dentro da subpasta /dados.

3. Gerando o Relatório
Abra o arquivo relatorio_atividade.Rmd no RStudio e clique no botão Knit (escolha o formato HTML ou PDF).

📊 Autores
Alexandre Novaes Dornelas

José Carlos Maria Júnior

Thiago Itamar Plum

Walter Alves Moreira Barbosa dos Santos

William Xavier dos Santos

Ygor Silva Nascimento Coelho
