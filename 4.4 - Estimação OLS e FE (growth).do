*****************************************************************************************
*                ANÁLISE EMPÍRICA - REGRESSÕES OLS e FE (GROWTH)
****************************************************************************************

clear all 

* Definindo o diretório onde se encontram os dados:
cd "C:\Users\joseg_000.PC-JE\Documents\Dissertação - Dados\Bases de Dados Prontas"

* Abrindo a base de dados base_pronta_mandato que foi constrída no R: (ESCOLHER A QUE FOR USAR)
// use base_pronta_growth_ECD.dta, clear
use base_pronta_growth_ED.dta, clear

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



* Estimação OLS mais simples de todas:
reg log_despesa_geral_pc partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_1

reg log_despesa_geral_pib partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_2

reg log_total_receitas_pc partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_3

reg log_total_receitas_pib partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_4

reg log_receita_tributaria_pc partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_5

reg log_receita_tributaria_pib partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_6

reg log_servidores_comissionados_mil partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_7

reg educacao_prop partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_8

reg saude_prop partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_9

reg assistencia_social_prop partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_10

reg urbanismo_prop partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_11

reg transporte_prop partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_12

reg desporto_e_lazer_prop partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_13

reg seguranca_publica_prop partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_14

reg gestao_ambiental_prop partido_de_esquerda i.id_mandato, vce(cluster cod_municipio_ibge)
estimates store ols_15


outreg2 [ols_1 ols_2 ols_3 ols_4 ols_5 ols_6 ols_7 ols_8 ols_9 ols_10 ols_11 ols_12 ols_13 ols_14 ols_15] using ols_unconditional.xls, replace dec(3) nocons keep(partido_de_esquerda) label

outreg2 [ols_1 ols_2 ols_3 ols_4 ols_5 ols_6 ols_7 ols_8 ols_9 ols_10 ols_11 ols_12 ols_13 ols_14 ols_15] using ols_unconditional_sideway.xls, dec(3) sideway nocons keep(partido_de_esquerda)







* ----------------------------------------------------------------------------------------------------------


* Estimação OLS com efeitos fixos de municipio e mandato:
xtreg log_despesa_geral_pc partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_1

xtreg log_despesa_geral_pib partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_2

xtreg log_total_receitas_pc partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_3

xtreg log_total_receitas_pib partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_4

xtreg log_receita_tributaria_pc partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_5

xtreg log_receita_tributaria_pib partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_6

xtreg log_servidores_comissionados_mil partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_7

xtreg educacao_prop partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_8

xtreg saude_prop partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_9

xtreg assistencia_social_prop partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_10

xtreg urbanismo_prop partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_11

xtreg transporte_prop partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_12

xtreg desporto_e_lazer_prop partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_13

xtreg seguranca_publica_prop partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_14

xtreg gestao_ambiental_prop partido_de_esquerda i.id_mandato, fe vce(cluster cod_municipio_ibge)
estimates store fe_unconditional_15


outreg2 [fe_unconditional_1 fe_unconditional_2 fe_unconditional_3 fe_unconditional_4 fe_unconditional_5 fe_unconditional_6 fe_unconditional_7 fe_unconditional_8 fe_unconditional_9 fe_unconditional_10 fe_unconditional_11 fe_unconditional_12 fe_unconditional_13 fe_unconditional_14 fe_unconditional_15] using fe_unconditional.xls, replace dec(3) nocons keep(partido_de_esquerda) label

outreg2 [fe_unconditional_1 fe_unconditional_2 fe_unconditional_3 fe_unconditional_4 fe_unconditional_5 fe_unconditional_6 fe_unconditional_7 fe_unconditional_8 fe_unconditional_9 fe_unconditional_10 fe_unconditional_11 fe_unconditional_12 fe_unconditional_13 fe_unconditional_14 fe_unconditional_15] using fe_unconditional_sideway.xls, dec(3) sideway nocons keep(partido_de_esquerda)



 
