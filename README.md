# Ministros STF - Projeto Data Warehousing

Repositório para os arquivos utilizados, na disciplina de Data Warehousing and Business Inteligence da Professora Ceça Moraes na Universidade Federal Rural de Pernambuco (UFRPE), para montar um Data Warehouse + Sistema OLAP para analisar a popularidade dos ministros do Supremo Tribunal Federal (STF) no Twitter entre o período de março de 2018 e maio de 2018.

#### Os ministros analisados no projeto foram:

	 José Celso de Melo Filho
	 Marco Aurélio Mendes de Farias Mello
	 Gilmar Ferreira Mendes
	 Enrique Ricardo Lewandowski
	 Cármen Lúcia Antunes Rocha
	 José Antonio Dias Toffoli
	 Luiz Fux
	 Rosa Maria Pires Weber
	 Luís Roberto Barroso
	 Luiz Edson Fachin
	 Alexandre de Moraes
	 
## Ferramentas utilizadas

    Python 3.5
	nltk
    pandas
    scikit-learn
    MySQL 5.7
    Pentaho Data Integration 5.4
	Pentaho BI Server 7.1
     
## Como fizemos e como replicar:

### 1. Coleta

Primeiramente coletamos os ids dos tweets para que pudessemos baixar os tweets e em seguida tratá-los, já que a API do Twitter só permite a coleta de tweets de até 7 dias atrás de forma gratuita. Utilizamos a biblioteca selenium para automatizar a coleta dos ids, salvando a lista dos ids em um arquivo .csv. O código dessa parte está no arquivo: 
    
    twitter_bot.py

Em seguida, a partir da lista de ids obtidas no passo anterior utilizamos a biblioteca tweepy para fazer o download dos tweets através da API disponibilizada pelo Twitter. Também exportando para um arquivo .csv. O código está no arquivo: 
    
    tweet_getter.py 

Assim que conseguimos o conteúdo dos tweets, passamos para a fase da limpeza de dados e análise de sentimento, utilizando a biblioteca de processamento de linguagem natural nltk aliada com a biblioteca de aprendizagem de máquina scikit-learn para a realização da análise de sentimento e assim descobrirmos a polaridade do tweet. O código está no arquivo:

	tweet_analisys.py

Logo após, criamos um modelo lógico no MySQL Workbench (base_fonte.mwb) e inserimos esses dados no banco de dados que serviu de base fonte para a montagem do Data Warehouse. O código está no arquivo:

	database_insertion.py

Por último, criamos um modelo lógico para o Data Warehouse (data_warehouse_stf.mwb), seguindo o escopo solicitado na disciplina.

### 2. ETL

Para a parte do ETL do Data Warehouse, utilizamos a ferramenta Pentaho Data Integration 5.4 (Spoon ou Keetle).

#### 2.1. Dimensões

Para a carga das dimensões seguimos um exemplo dado pela professora que consiste em 4 passos:

1. Table input: neste passo nós damos um select em toda a tabela que usamos para construir a dimensão.
2. Dimension Lookup/Update: este passo é responsável por atualizar a dimensão no Data Warehouse.
3. Insert chave zero (Script SQL): o script é responsável pela inserção de uma chave nula, que será usada em alguns registros onde faltarem informações.
4. Atualiza campos de controle (Script SQL): atualiza os campos de controle do Data Warehouse (date_from, date_to e version).

#### 2.2. Fato

Na carga da tabela fato, fizemos um esquema diferente com 9 passos que podemos ser resumidos em 6 itens:

1. Table input: funciona de forma semelhante à forma aplicada na carga das dimensões, mas na carga do fato, nós selecionamos apenas as chaves primárias das dimensões e as métricas na base fonte.
2. Database Lookup: usamos para pegar a chave primária do Data Warehouse dada a chave primária na base fonte.
3. Select values: neste passo excluímos os dados que não vamos utilizar na tabela fato (chaves primárias da base fonte).
4. Memory Group by: aqui escolhemos como agrupar as métricas.
5. Calculator: usamos para fazer os cálculos de percentual das métricas.
6. Table output: para jogar os dados limpos e transformados para o Data Warehouse.

### 3. OLAP

Utilizando o Pentaho BI Server, baixamos e instalamos o plugin Saiku Analytics, onde pudemos fazer gráficos estatísticos com facilidade, baseados no Data Warehouse obtido através das etapas anteriores. Alguns gráficos podem ser vistos na pasta Gráficos.

# Limitações do projeto:

1. Como o campo de localização no Twitter é uma caixa de texto livre, muitos usuários escreveram localizações inexistentes ou textos aleatórios em suas localizações, o que acabou acarretando um grande problema em nossas análises. Buscamos tentar tratar da melhor maneira possível esse problema, mas isso acabou virando uma limitação, pois muitos tweets não possuem localização definida.

2. Como o espaço de tempo dos tweets que nós coletamos foi de 3 meses, isso acabou dificultando a elaboração de gráficos mais complexos que levariam em conta um maior espaço de tempo. 



## Equipe	 

    Carlos Santos
    José Matheus
    Lucas Silva
    Matheus Campos da Silva

