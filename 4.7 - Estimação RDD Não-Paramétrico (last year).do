*****************************************************************************************
*                ANÁLISE EMPÍRICA - RDD NÃO-PARAMÉTRICO (LAST YEAR)
****************************************************************************************

clear all

* Definindo o diretório onde se encontram os dados:
cd "C:\Users\joseg_000.PC-JE\Documents\Dissertação - Dados\Bases de Dados Prontas"

* Abrindo a base de dados base_pronta_mandato que foi constrída no R: (ESCOLHER A QUE FOR USAR)
// use base_pronta_last_year_ECD.dta, clear
use base_pronta_last_year_ED.dta, clear

* Definindo o diretório para o Stata salvar as tabelas geradas:
// cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Dissertação\Tabelas Geradas no Stata\Análise com partidos de esquerda, centro e direita"
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Dissertação\Tabelas Geradas no Stata\Análise com partidos de esquerda e direita"

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
label var gestao_ambiental_prop "Spending on Environmental management (Share of Total)"
label var partido_de_esquerda "Left-Wing Party"
label var margem_vitoria_esquerda "Left Vote Share Margin of Victory"


* ------------------------------------------------------------------------------------------------------------------------------


* Utilizamos o pacote rdrobust:

* Estimação RDD não paramétrica (SEM COVARIATES):
rdrobust log_despesa_geral_pc margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_1

rdrobust log_despesa_geral_pib margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_2

rdrobust log_total_receitas_pc margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_3

rdrobust log_total_receitas_pib margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_4

rdrobust log_receita_tributaria_pc margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_5

rdrobust log_receita_tributaria_pib margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_6

rdrobust log_servidores_comissionados_mil margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_7

rdrobust educacao_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_8

rdrobust saude_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_9

rdrobust assistencia_social_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_10

rdrobust urbanismo_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_11

rdrobust transporte_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_12

rdrobust desporto_e_lazer_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_13

rdrobust seguranca_publica_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_14

rdrobust gestao_ambiental_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all
estimates store rd_unconditional_15


* Exportando as tabelas:
esttab rd_unconditional* using rdrobust_unconditional_wide, html label replace wide wrap star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) title("Non-Parametric RD (local linear regression). No Covariates")

esttab rd_unconditional* using rdrobust_unconditional, html label replace wrap star(* 0.10 ** 0.05 *** 0.01)  b(3) se(3) title("Non-Parametric RD (local linear regression). No Covariates")




* -------------------------------------------------------------------------------------------------------------------------------------------------------------

* Estimação RDD não paramétrica (COM COVARIATES):
rdrobust log_despesa_geral_pc margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_1

rdrobust log_despesa_geral_pib margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_2

rdrobust log_total_receitas_pc margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_3

rdrobust log_total_receitas_pc margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_4

rdrobust log_receita_tributaria_pc margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_5

rdrobust log_receita_tributaria_pib margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_6

rdrobust log_servidores_comissionados_mil margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_7

rdrobust educacao_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_8

rdrobust saude_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_9

rdrobust assistencia_social_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_10

rdrobust urbanismo_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_11

rdrobust transporte_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_12

rdrobust desporto_e_lazer_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_13

rdrobust seguranca_publica_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_14

rdrobust gestao_ambiental_prop margem_vitoria_esquerda, c(0) vce(nncluster cod_municipio_ibge) all covs(pop pib_pc)
estimates store rd_conditional_15




* Exportando as tabelas:
esttab rd_conditional* using rdrobust_conditional_wide, html label replace wide wrap star(* 0.10 ** 0.05 *** 0.01) b(3) se(3) title("Non-Parametric RD (local linear regression). Controlling for Covariates")

esttab rd_conditional* using rdrobust_conditional, html label replace wrap star(* 0.10 ** 0.05 *** 0.01)  b(3) se(3) title("Non-Parametric RD (local linear regression). Controlling for Covariates")


