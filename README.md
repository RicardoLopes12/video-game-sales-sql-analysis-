# 🎮 Análise de Vendas de Video Games com SQL

Este projeto é uma análise exploratória de dados de vendas de video games utilizando SQL. O conjunto de dados contém informações históricas de vendas por plataforma e por região, retirado do [Kaggle](https://www.kaggle.com/datasets/zahidmughal2343/video-games-sale).

## 📌 Objetivo

Analisar as vendas globais de video games para identificar:
- Jogos mais vendidos por ano
- Gêneros e plataformas preferidas por região
- Principais publishers e seu alcance
- Tendências regionais de consumo ao longo dos anos

## 🧹 Limpeza de Dados

Etapas realizadas:
- Criação de uma tabela `staging` para preservar os dados originais
- Remoção de duplicatas
- Padronização dos nomes das publishers (ex: variações de "Sony")
- Verificação de valores nulos ou vazios

Todas as queries estão documentadas em `Exploratory Data Analysis.sql`.

## 📊 Análise Exploratória (EDA)

Tópicos analisados:
- Vendas globais por plataforma e por gênero
- Gêneros preferidos em cada região
- Evolução das vendas regionais ao longo dos anos
- Publishers com maior volume de vendas

Todas as queries estão no arquivo `Exploratory Data Analysis.sql`.

## 📈 Exemplos de Insights

- **Ação** é o gênero mais popular na América do Norte e Europa.
- O **Japão** tem forte preferência por jogos de **RPG**.
- As plataformas **DS** e **PS2** lideram em vendas globais.
- **Nintendo** e **Electronic Arts** são os publishers com maior presença global.

## 📁 Arquivos

- `Data Cleaning.sql` – Queries de limpeza e preparação dos dados
- `Exploratory Data Analysis.sql` – Queries de análise exploratória
- `vg_sales_clean.csv` – Versão limpa da base de dados (opcional)

