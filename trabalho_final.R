# =========================================================================
# PROJETO: Análise Espacial de Preços de Imóveis em Glasgow
# DISCIPLINA: Estatística Espacial
# =========================================================================

# 1. CARREGAMENTO DE BIBLIOTECAS ------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(sf, readxl, dplyr, tmap, spdep, stringr, ggplot2)

# 2. IMPORTAÇÃO E PREPARAÇÃO DOS DADOS ------------------------------------
prices_df  <- read_excel("dados/base preco propriedade.xlsx")
glasgow_sf <- st_read("dados/Glasgow.shp", quiet = TRUE)

# Join garantindo a manutenção da geometria (sf)
glasgow_dados <- left_join(x = glasgow_sf, y = prices_df, by = "IZ") %>% 
  mutate(rotulo = str_c(name, " - £", preco))

# 3. QUESTÃO 1: MAPA ESTÁTICO (AMPLITUDES IGUAIS) -------------------------
tmap_mode("plot")
tm_shape(glasgow_dados) +
  tm_polygons(
    fill = "preco", 
    fill.scale = tm_scale_intervals(style = "equal", n = 5, values = "brewer.greens"),
    fill.legend = tm_legend(title = "Preço Médio (£)")
  ) +
  tm_layout(main.title = "Q1: Amplitudes Iguais", frame = FALSE)

# 4. QUESTÃO 2: MAPA INTERATIVO (QUANTIS) ---------------------------------
tmap_mode("view")
tm_shape(glasgow_dados) + 
  tm_polygons(
    fill = "preco", 
    fill.scale = tm_scale_intervals(style = "quantile", n = 8, values = "matplotlib.blues"),
    id = "rotulo", 
    popup.vars = c("Área" = "name", "Preço" = "preco")
  )

# 5. QUESTÃO 3: MATRIZ DE VIZINHANÇA --------------------------------------
vizinhos <- poly2nb(glasgow_dados, queen = TRUE)
pesos_espaciais <- nb2listw(vizinhos, style = "W")
summary(vizinhos)

# 6. QUESTÃO 4: AUTOCORRELAÇÃO GLOBAL (I DE MORAN) ------------------------
moran_global <- moran.test(glasgow_dados$preco, pesos_espaciais)
print(moran_global)

# 7. QUESTÃO 5: AUTOCORRELAÇÃO LOCAL (LISA COLORIDO) ----------------------
lisa_local <- localmoran(glasgow_dados$preco, pesos_espaciais)
precos_cent <- glasgow_dados$preco - mean(glasgow_dados$preco)
lag_precos_cent <- lag.listw(pesos_espaciais, precos_cent)

# Criando as categorias de cluster (Igual ao Rmd)
glasgow_dados$cluster <- "Não Significante"
significantes <- lisa_local[, 5] < 0.05

glasgow_dados$cluster[significantes & precos_cent > 0 & lag_precos_cent > 0] <- "Alto-Alto"
glasgow_dados$cluster[significantes & precos_cent < 0 & lag_precos_cent < 0] <- "Baixo-Baixo"
glasgow_dados$cluster[significantes & precos_cent > 0 & lag_precos_cent < 0] <- "Alto-Baixo (Outlier)"
glasgow_dados$cluster[significantes & precos_cent < 0 & lag_precos_cent > 0] <- "Baixo-Alto (Outlier)"

tmap_mode("plot")
tm_shape(glasgow_dados) +
  tm_polygons(
    col = "cluster",
    palette = c("Alto-Alto" = "#d7191c", "Baixo-Baixo" = "#2c7bb6", 
                "Alto-Baixo (Outlier)" = "#fdae61", "Baixo-Alto (Outlier)" = "#abd9e9", 
                "Não Significante" = "white"),
    title = "Clusters LISA"
  ) +
  tm_layout(main.title = "Q5: Mapa de Clusters LISA", frame = FALSE)

# Final do Script
