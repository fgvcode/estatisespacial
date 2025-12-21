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

# Calculando Local Moran (LISA)
local_moran <- localmoran(x = glasgow_dados$preco, pesos_espaciais)

# Adicionando resultados ao shapefile
glasgow_dados <- glasgow_dados |>
  mutate(
    Ii = local_moran[, "Ii"],             # Estatística local
    Pr.Ii = local_moran[, "Pr(z != E(Ii))"]  # p-valor
  )

# Criando clusters LISA
media_total <- mean(x = glasgow_dados$preco, na.rm = TRUE)
preco_std <- scale(x = glasgow_dados$preco)[,1]
lag_preco_std <- scale(x = lag.listw(recWQW, glasgow_dados$preco))[,1]

glasgow_dados$LISA_cluster <- "Não significativo"          # Valor padrão
glasgow_dados$LISA_cluster[preco_std > 0 & lag_preco_std > 0 & glasgow_dados$Pr.Ii <= 0.05] <- "Alto-Alto"
glasgow_dados$LISA_cluster[preco_std < 0 & lag_preco_std < 0 & glasgow_dados$Pr.Ii <= 0.05] <- "Baixo-Baixo"
glasgow_dados$LISA_cluster[preco_std > 0 & lag_preco_std < 0 & glasgow_dados$Pr.Ii <= 0.05] <- "Alto-Baixo"
glasgow_dados$LISA_cluster[preco_std < 0 & lag_preco_std > 0 & glasgow_dados$Pr.Ii <= 0.05] <- "Baixo-Alto"

# Mapa de clusters LISA
ggplot(data = glasgow_dados) +
  geom_sf(mapping = aes(fill = LISA_cluster), color = "gray50") +
  scale_fill_manual(values = c(
    "Alto-Alto" = "red",
    "Baixo-Baixo" = "blue",
    "Alto-Baixo" = "orange",
    "Baixo-Alto" = "lightblue",
    "Não significativo" = "gray80"
  )) +
  theme_minimal() +
  labs(title = "Mapa LISA Local - Preço mediano", fill = "Cluster")

# Final do Script
