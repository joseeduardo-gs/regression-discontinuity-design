*****************************************************************************************
*                ANÁLISE EMPÍRICA - TESTES DE ROBUSTEZ
****************************************************************************************

clear all 

* Definindo o diretório onde se encontram os dados:
cd "C:\Users\joseg_000.PC-JE\Documents\Dissertação - Dados\Bases de Dados Prontas"

* Abrindo a base de dados base_pronta_mandato que foi constrída no R: (ESCOLHER A QUE FOR USAR)
// use base_pronta_mandato_ECD.dta, clear
use base_pronta_mandato_ED.dta, clear

* Definindo o diretório para o Stata salvar os gráficos gerados:
// cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Dissertação\Imagens Geradas no Stata\Partidos de Esquerda, Centro e Direita\Rdplots Prontos"
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Dissertação\Imagens Geradas no Stata\Partidos de Esquerda e Direita\Rdplots Prontos"


* Verificando quais ideologias partidárias constam na base de dados:
tab ideologia_partido_eleito
sum margem_vitoria_esquerda

* Declarando o painel:
egen id_mandato = group(mandato)
destring cod_municipio_ibge, replace
xtset cod_municipio_ibge id_mandato, generic

* Gerando as variáveis em log que serão necessárias para as regressões:
gen log_despesa_geral_pc = log(despesa_geral_pc)
gen log_despesa_geral_pib = log(despesa_geral_pib)
gen log_total_receitas_pc = log(total_receitas_pc)
gen log_total_receitas_pib = log(total_receitas_pib)
gen log_receita_tributaria_pc = log(receita_tributaria_pc)
gen log_receita_tributaria_pib = log(receita_tributaria_pib)
gen log_servidores_comissionados_mil  = log(servidores_comissionados_mil)


* Adicionando labels às variáveis de interesse:
label var log_despesa_geral_pc "Total expenditures (per capita)"
label var log_despesa_geral_pib "Total Expeditures (share of income)"
label var log_total_receitas_pc "Total Revenues (per capita)"
label var log_total_receitas_pib "Total Revenues (share of income)"
label var log_receita_tributaria_pc "Tax Revenues (per capita)"
label var log_receita_tributaria_pib "Tax Revenues (share of income)"
label var log_servidores_comissionados_mil "Comission Employees (per 1000 residents)"
label var educacao_prop "Spending on Education (share of total)"
label var saude_prop "Spending on Health (share of total)"
label var assistencia_social_prop "Spending on Social Assistance (share of total)"
label var urbanismo_prop "Spending on Urbanism (Share of Total)"
label var transporte_prop "Spending on Transportation (Share of Total)"
label var desporto_e_lazer_prop "Spending on Sports and Leisure (Share of Total)"
label var seguranca_publica_prop "Spending on Public Safety (Share of Total)"
label var gestao_ambiental_prop "Spending on Environmental Management (Share of Total)"
label var partido_de_esquerda "Left-Wing Party"
label var margem_vitoria_esquerda "Left Vote Share Margin of Victory"



* Testando se existe manipulação na forcing variable ----------------------

* Teste de McCrary de descontinuidade na forcing variable:
* H0: Não há descontinuidade da forcing variable no cuttof
* H1: Existe descontinuidade da forcing variable no cutoff
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Dissertação\Imagens Geradas no Stata\Partidos de Esquerda, Centro e Direita\McCrary Test"

rddensity margem_vitoria_esquerda, c(0)

// rddensity margem_vitoria_esquerda, plot ///
//                   graph_options(graphregion(color(white)) ///
// 				  xtitle("Left vote share margin of victory") ytitle("Density") title ("Forcing Variable Density Test (P-value = 0.77)")) legend(off))
// graph export rddensity_ECD.png, replace




* -----------------------------------------------------------------------------------------------------------------------------------

* Testando se as covariates estão balanceadas em ambos os lados do cutoff:
* Para fazer isto, devemos fazer uma regressão RDD usando as covariates como variável dependente, ao invés dos outcomes tradicionais.
* Caso o coeficiente estimado RDD não seja estatísticamente diferente de zero, assumimos que as covariates estão balanceadas entre os grupos de controle e tratamento.

* Definindo o diretório para o Stata salvar os resultados gerados:
* Definindo o diretório para o Stata salvar as tabelas geradas:
// cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Dissertação\Tabelas Geradas no Stata\Análise com partidos de esquerda, centro e direita"
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Dissertação\Tabelas Geradas no Stata\Análise com partidos de esquerda e direita"


* Estimação RDD não paramétrica (SEM COVARIATES):
rdrobust pib_pc margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rdd_covariates_1

rdrobust proporcao_jovem margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rdd_covariates_2

rdrobust proporcao_idoso margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rdd_covariates_3

rdrobust fracao_pop_masculina margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rdd_covariates_4

rdrobust fracao_pop_urbana margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rdd_covariates_5

rdrobust proporcao_brancos margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rdd_covariates_6


esttab rdd_covariates* using rdrobust_conditional, html label replace wrap star(* 0.10 ** 0.05 *** 0.01)  b(3) se(3) title("Checking for balance of covariates around the cutoff")



















