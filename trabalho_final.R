# =========================================================================
# PROJETO: Análise Espacial de Preços de Imóveis em Glasgow
# DISCIPLINA: Estatística Espacial
# AUTORES: Alexandre Novaes, José Carlos, Thiago Plum, Walter Alves, 
#          William Xavier, Ygor Coelho
# =========================================================================

# 1. CARREGAMENTO DE BIBLIOTECAS ------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(sf, readxl, dplyr, tmap, spdep, stringr, ggplot2)

# 2. IMPORTAÇÃO E PREPARAÇÃO DOS DADOS ------------------------------------
# Nota: Os arquivos devem estar na pasta 'dados/' conforme estrutura do GitHub
prices_df  <- read_excel("dados/base preco propriedade.xlsx")
glasgow_sf <- st_read("dados/Glasgow.shp", quiet = TRUE)

# Join garantindo a manutenção da geometria (sf)
glasgow_dados <- left_join(x = glasgow_sf, y = prices_df, by = "IZ") %>% 
  mutate(rotulo = str_c(name, " - £", preco))

# 3. QUESTÃO 1: MAPA ESTÁTICO (AMPLITUDES IGUAIS) -------------------------
tmap_mode("plot")
mapa_estatico <- tm_shape(glasgow_dados) +
  tm_polygons(
    fill = "preco", 
    fill.scale = tm_scale_intervals(style = "equal", n = 5, values = "brewer.greens"),
    fill.legend = tm_legend(title = "Preço Médio (£)")
  ) +
  tm_layout(main.title = "Q1: Amplitudes Iguais", frame = FALSE)

print(mapa_estatico)

# 4. QUESTÃO 2: MAPA INTERATIVO (QUANTIS) ---------------------------------
tmap_mode("view")
mapa_interativo <- tm_shape(glasgow_dados) + 
  tm_polygons(
    fill = "preco", 
    fill.scale = tm_scale_intervals(style = "quantile", n = 8, values = "matplotlib.blues"),
    id = "rotulo", 
    popup.vars = c("Área" = "name", "Preço" = "preco")
  )

mapa_interativo

# 5. QUESTÃO 3: MATRIZ DE VIZINHANÇA --------------------------------------
# Criando lista de vizinhos (Queen) e matriz de pesos padronizada (W)
vizinhos <- poly2nb(glasgow_dados, queen = TRUE)
pesos_espaciais <- nb2listw(vizinhos, style = "W")

summary(vizinhos)

# 6. QUESTÃO 4: AUTOCORRELAÇÃO GLOBAL (I DE MORAN) ------------------------
# H0: Aleatoriedade Espacial | H1: Existência de Autocorrelação
moran_global <- moran.test(glasgow_dados$preco, pesos_espaciais)
print(moran_global)

# Execução do teste de Moran para a variável 'preco'
moran_global <- moran.test(glasgow_dados$preco, pesos_espaciais)

# Exibição dos resultados
print(moran_global)
##          RESPOSTA DA QUESTÃO 4
#Com base no Teste de Moran Global, o Índice I obtido foi de 0,4497, com um p-valor inferior a 0,05. 
#Portanto, rejeitamos a hipótese de aleatoriedade espacial. Conclui-se, com 95% de confiança, que os 
#preços dos imóveis em Glasgow apresentam autocorrelação espacial positiva, indicando uma forte tendência de 
#segregação espacial ou formação de clusters de preços semelhantes na cidade

# 7. QUESTÃO 5: AUTOCORRELAÇÃO LOCAL (LISA) -------------------------------
lisa_local <- localmoran(glasgow_dados$preco, pesos_espaciais)

# Lógica para categorização dos quadrantes do Moran Scatterplot
precos_cent <- glasgow_dados$preco - mean(glasgow_dados$preco)
lag_precos_cent <- lag.listw(pesos_espaciais, precos_cent)

glasgow_dados$cluster <- "Não Significante"
significantes <- lisa_local[, 5] < 0.05

glasgow_dados$cluster[significantes & precos_cent > 0 & lag_precos_cent > 0] <- "Alto-Alto"
glasgow_dados$cluster[significantes & precos_cent < 0 & lag_precos_cent < 0] <- "Baixo-Baixo"
glasgow_dados$cluster[significantes & precos_cent > 0 & lag_precos_cent < 0] <- "Alto-Baixo (Outlier)"
glasgow_dados$cluster[significantes & precos_cent < 0 & lag_precos_cent > 0] <- "Baixo-Alto (Outlier)"

tmap_mode("plot")
mapa_lisa <- tm_shape(glasgow_dados) +
  tm_polygons(
    col = "cluster",
    palette = c("Alto-Alto" = "#d7191c", "Baixo-Baixo" = "#2c7bb6", 
                "Alto-Baixo (Outlier)" = "#fdae61", "Baixo-Alto (Outlier)" = "#abd9e9", 
                "Não Significante" = "white"),
    title = "Clusters LISA"
  ) +
  tm_layout(main.title = "Q5: Mapa de Clusters LISA", frame = FALSE)

print(mapa_lisa)

# Final do Script
