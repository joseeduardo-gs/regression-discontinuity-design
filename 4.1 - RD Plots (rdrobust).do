*****************************************************************************************
*                ANÁLISE EMPÍRICA - GRÁFICOS RDPLOT
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

* Restringindo a amostra para somente eleições cuja margem de vitória é menor que 50%. Fazemos isso para melhorar a visualização dos gráficos:
drop if margem_vitoria_esquerda > 0.4 | margem_vitoria_esquerda < -0.4


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




* Gerando os gráficos RD plot:

* Por simplicidade, irei apena gerar os gráficos que serão adicionados ao trabalho final. Para ver todos os gráficos, consultar o script do R:

// * ESQUERDA, CENTRO E DIREITA (ECD):
// rdplot log_despesa_geral_pc margem_vitoria_esquerda, nbins(30 30) ci(95) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log total expenditures per capita) legend(off))
// graph export "stata_rdplot_ECD_1.png", width(1300) height(837) replace
//
// rdplot log_total_receitas_pc margem_vitoria_esquerda, nbins(30 30) ci(95) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log total revenues per capita) legend(off)) name(rdplot_2)
// graph export "stata_rdplot_ECD_2.png", width(1300) height(837) replace
//
// rdplot log_receita_tributaria_pc margem_vitoria_esquerda, nbins(30 30) ci(95) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log tax revenues per capita) legend(off)) name(rdplot_3)
// graph export "stata_rdplot_ECD_3.png", width(1300) height(837) replace
//
// rdplot log_servidores_comissionados_mil margem_vitoria_esquerda, nbins(30 30) ci(95) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log commission employees (per 1000 residents)) legend(off)) name(rdplot_4)
// graph export "stata_rdplot_ECD_4.png", width(1300) height(837) replace
//
// rdplot educacao_prop margem_vitoria_esquerda, nbins(30 30) ci(95) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with education (share of total)) legend(off)) name(rdplot_5)
// graph export "stata_rdplot_ECD_5.png", width(1300) height(837) replace
//
// rdplot saude_prop margem_vitoria_esquerda, nbins(30 30) ci(95) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with health (share of total)) legend(off)) name(rdplot_6)
// graph export "stata_rdplot_ECD_6.png", width(1300) height(837) replace
//
// rdplot assistencia_social_prop margem_vitoria_esquerda, nbins(30 30) ci(95) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with social assistance (share of total)) legend(off)) name(rdplot_7)
// graph export "stata_rdplot_ECD_7.png", width(1300) height(837) replace
//
// rdplot urbanismo_prop margem_vitoria_esquerda, nbins(30 30) p(3) ci(95) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with urbanism (share of total)) legend(off)) name(rdplot_8)
// graph export "stata_rdplot_ECD_8.png", width(1300) height(837) replace

* ----------------------------------------------------------------------------------------------------------------

* ESQUERDA E DIREITA (ED): (SEM INTERVALOS DE CONFIANÇA)
rdplot log_despesa_geral_pc margem_vitoria_esquerda, nbins(30 30) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log total expenditures per capita) legend(off))
graph export "stata_rdplot_ED_1.png", width(1300) height(837) replace

rdplot log_total_receitas_pc margem_vitoria_esquerda, nbins(30 30) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log total revenues per capita) legend(off)) name(rdplot_2)
graph export "stata_rdplot_ED_2.png", width(1300) height(837) replace

rdplot log_receita_tributaria_pc margem_vitoria_esquerda, nbins(30 30) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log tax revenues per capita) legend(off)) name(rdplot_3)
graph export "stata_rdplot_ED_3.png", width(1300) height(837) replace

rdplot log_servidores_comissionados_mil margem_vitoria_esquerda, nbins(30 30) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log commission employees (per 1000 residents)) legend(off)) name(rdplot_4)
graph export "stata_rdplot_ED_4.png", width(1300) height(837) replace

rdplot educacao_prop margem_vitoria_esquerda, nbins(30 30) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with education (share of total)) legend(off)) name(rdplot_5)
graph export "stata_rdplot_ED_5.png", width(1300) height(837) replace

rdplot saude_prop margem_vitoria_esquerda, nbins(30 30) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with health (share of total)) legend(off)) name(rdplot_6)
graph export "stata_rdplot_ED_6.png", width(1300) height(837) replace

rdplot assistencia_social_prop margem_vitoria_esquerda, nbins(30 30) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with social assistance (share of total)) legend(off)) name(rdplot_7)
graph export "stata_rdplot_ED_7.png", width(1300) height(837) replace

rdplot urbanismo_prop margem_vitoria_esquerda, nbins(30 30) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with urbanism (share of total)) legend(off)) name(rdplot_8)
graph export "stata_rdplot_ED_8.png", width(1300) height(837) replace


*------------------------------------------------------------------------------------------------------------


* ESQUERDA E DIREITA (ED): (COM INTERVALOS DE CONFIANÇA ERROR BAR)
* Salvando os gráficos COM intervalos de confiança:
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Dissertação\Imagens Geradas no Stata\Partidos de Esquerda e Direita\Rdplots CI"
rdplot log_despesa_geral_pc margem_vitoria_esquerda, nbins(30 30) ci(90) p(3) graph_options(yscale(range(7 8)) xtitle(Left Vote share margin of victory) ytitle(Log total expenditures per capita) legend(off))
graph export "stata_rdplot_ED_ci_1.png", width(1300) height(837) replace

rdplot log_total_receitas_pc margem_vitoria_esquerda, nbins(30 30) ci(90) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log total revenues per capita) legend(off)) name(rdplot_2)
graph export "stata_rdplot_ED_ci_2.png", width(1300) height(837) replace

rdplot log_receita_tributaria_pc margem_vitoria_esquerda, nbins(30 30) ci(90) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log tax revenues per capita) legend(off)) name(rdplot_3)
graph export "stata_rdplot_ED_ci_3.png", width(1300) height(837) replace

rdplot log_servidores_comissionados_mil margem_vitoria_esquerda, nbins(30 30) ci(90) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log commission employees (per 1000 residents)) legend(off)) name(rdplot_4)
graph export "stata_rdplot_ED_ci_4.png", width(1300) height(837) replace

rdplot educacao_prop margem_vitoria_esquerda, nbins(30 30) ci(90) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with education (share of total)) legend(off)) name(rdplot_5)
graph export "stata_rdplot_ED_ci_5.png", width(1300) height(837) replace

rdplot saude_prop margem_vitoria_esquerda, nbins(30 30) ci(90) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with health (share of total)) legend(off)) name(rdplot_6)
graph export "stata_rdplot_ED_ci_6.png", width(1300) height(837) replace

rdplot assistencia_social_prop margem_vitoria_esquerda, nbins(30 30) ci(90) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with social assistance (share of total)) legend(off)) name(rdplot_7)
graph export "stata_rdplot_ED_ci_7.png", width(1300) height(837) replace

rdplot urbanismo_prop margem_vitoria_esquerda, nbins(30 30) ci(90) p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with urbanism (share of total)) legend(off)) name(rdplot_8)
graph export "stata_rdplot_ED_ci_8.png", width(1300) height(837) replace


* ESQUERDA E DIREITA (ED): (COM INTERVALOS DE CONFIANÇA SHADE)
* Salvando os gráficos COM intervalos de confiança:
cd "C:\Users\joseg_000.PC-JE\Google Drive\FGV-EPGE\Dissertação\Imagens Geradas no Stata\Partidos de Esquerda e Direita\Rdplots CI"
rdplot log_despesa_geral_pc margem_vitoria_esquerda, nbins(30 30) ci(90) shade p(3) graph_options(yscale(range(7 8)) xtitle(Left Vote share margin of victory) ytitle(Log total expenditures per capita) legend(off))
graph export "stata_rdplot_ED_ci_shade_1.png", width(1300) height(837) replace

rdplot log_total_receitas_pc margem_vitoria_esquerda, nbins(30 30) ci(90) shade p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log total revenues per capita) legend(off)) name(rdplot_2)
graph export "stata_rdplot_ED_ci_shade_2.png", width(1300) height(837) replace

rdplot log_receita_tributaria_pc margem_vitoria_esquerda, nbins(30 30) ci(90) shade p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log tax revenues per capita) legend(off)) name(rdplot_3)
graph export "stata_rdplot_ED_ci_shade_3.png", width(1300) height(837) replace

rdplot log_servidores_comissionados_mil margem_vitoria_esquerda, nbins(30 30) ci(90) shade p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Log commission employees (per 1000 residents)) legend(off)) name(rdplot_4)
graph export "stata_rdplot_ED_ci_shade_4.png", width(1300) height(837) replace

rdplot educacao_prop margem_vitoria_esquerda, nbins(30 30) ci(90) shade p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with education (share of total)) legend(off)) name(rdplot_5)
graph export "stata_rdplot_ED_ci_shade_5.png", width(1300) height(837) replace

rdplot saude_prop margem_vitoria_esquerda, nbins(30 30) ci(90) shade p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with health (share of total)) legend(off)) name(rdplot_6)
graph export "stata_rdplot_ED_ci_shade_6.png", width(1300) height(837) replace

rdplot assistencia_social_prop margem_vitoria_esquerda, nbins(30 30) ci(90) shade p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with social assistance (share of total)) legend(off)) name(rdplot_7)
graph export "stata_rdplot_ED_ci_shade_7.png", width(1300) height(837) replace

rdplot urbanismo_prop margem_vitoria_esquerda, nbins(30 30) ci(90) shade p(3) graph_options(xtitle(Left Vote share margin of victory) ytitle(Expenditures with urbanism (share of total)) legend(off)) name(rdplot_8)
graph export "stata_rdplot_ED_ci_shade_8.png", width(1300) height(837) replace






