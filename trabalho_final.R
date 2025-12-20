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

# Unificação (Join) garantindo a manutenção da classe 'sf'
# Shapefile à esquerda (x) garante que o resultado herde a geometria automaticamente
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
    fill.legend = tm_legend(title = "Preço Mediano"),
    id = "rotulo", 
    popup.vars = c("Área" = "name", "Preço" = "preco"),
    lwd = 0.25
  )

mapa_interativo

# 5. QUESTÃO 3: MATRIZ DE VIZINHANÇA (CONTIGUIDADE QUEEN) -----------------
vizinhos <- poly2nb(glasgow_dados, queen = TRUE)
pesos_espaciais <- nb2listw(vizinhos, style = "W")

summary(vizinhos)

# 6. QUESTÃO 4: AUTOCORRELAÇÃO GLOBAL (I DE MORAN) ------------------------
# H0: Aleatoriedade Espacial | H1: Existência de Autocorrelação
moran_global <- moran.test(glasgow_dados$preco, pesos_espaciais)
print(moran_global)

# 7. QUESTÃO 5: AUTOCORRELAÇÃO LOCAL (LISA) -------------------------------
lisa_local <- localmoran(glasgow_dados$preco, pesos_espaciais)

# Adicionando p-valor ao mapa para destacar áreas significantes
glasgow_dados$p_valor_local <- lisa_local[, 5]

tmap_mode("plot")
tm_shape(glasgow_dados) +
  tm_polygons(
    fill = "p_valor_local", 
    fill.scale = tm_scale_intervals(breaks = c(0, 0.05, 1), values = c("red", "white")), 
    fill.legend = tm_legend(title = "P-valor < 0.05")
  ) +
  tm_layout(main.title = "Q5: Clusters Significativos (LISA)", frame = FALSE)

# Final do Script
