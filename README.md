# Análise Espacial de Preços de Imóveis em Glasgow

Este repositório contém um projeto de estatística espacial desenvolvido para a disciplina de Estatística Espacial. O objetivo é analisar a dependência espacial dos preços das propriedades em Glasgow utilizando o Índice de Moran.

## Estrutura do Repositório

- `dados/`: Contém os arquivos Shapefile (.shp, .shx, .dbf, .prj), planilha de preços (.xlsx) e Trabalho Final.pdf.
- `Trabalho Final.pdf`: Descritivo oficial da atividade.
- `relatorio_atividade.Rmd`: Arquivo R Markdown com a análise completa e interpretações.
- `trabalho_final.R`: Script R com a lógica de processamento e cálculos estatísticos.
  

## Metodologia Aplicada

A análise segue o seguinte fluxo estatístico:
1. **Unificação de Dados:** Cruzamento entre dados censitários (Intermediate Zones) e preços de venda.
2. **Matriz de Vizinhança:** Criação de matriz de contiguidade (Critério Rook).
3. **Moran Global:** Teste de hipótese para verificar se existe autocorrelação espacial (clumping) nos preços.
4. **Moran Local (LISA):** Identificação de clusters espaciais (High-High, Low-Low).


## Como Executar

1. Clone o repositório.
2. o **R** e o **RStudio** deverão estar instalados.
3. Certifique-se de que os pacotes `sf`, `readxl`, `spdep`, `tidyverse` e `tmap` estão instalados.
4. Execute o script `trabalho_final.R` ou faça o "Knit" do `relatorio_atividade.Rmd`. O arquivo .Rmd busca os dados automaticamente dentro da subpasta /dados.

## Resultados

Este trabalho estabeleceu uma estrutura objetiva e clara para um trabalho de análise espacial, integrando dados geográficos (Shapefiles) e socioeconômicos de Glasgow através de uma pipeline robusta em R. Foi consolidado um relatório unificado em R Markdown que abrange desde a visualização coroplética estática e interativa até testes rigorosos de estatística espacial, como a matriz de vizinhança por contiguidade Queen, o índice de Moran Global para detecção de dependência espacial e o LISA (Moran Local) para identificação de clusters de preços significativos. A organização final garantiu a reprodutibilidade do projeto mediante o uso de caminhos relativos, documentação clara no README.md, sincronização entre scripts .R e .Rmd e execução facilitada através do passo a passo inserido neste repositório.




