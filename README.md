# Ministros-STF - Projeto Data Warehousing

Repositório para os arquivos utilizados, na disciplina de Data Warehousing and Business Inteligence da Professora Ceça Moraes na Universidade Federal Rural de Pernambuco (UFRPE), para montar um Data Warehouse + Sistema OLAP para analisar a popularidade dos ministros do Supremo Tribunal Federal (STF) no Twitter entre março de 2018 e maio de 2018.

#### Os Ministros utilizados no projeto foram:

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
	 
##Ferramentas Utilizadas

    Python 3.x
    MySql 5.7
    Pentaho 5.4
    nltk
    pandas
    scikit-learn
     
###Primeiros Passos

Primeiramente é necessário termos os tweets para poder analisar. 



Primeiramente baixamos os Id's dos tweets para que possamos baixar o conteúdo. Utilizamos a biblioteca selenium para automatizar o download dos id's salvando a lista dos id’s em um arquivo .csv. O código dessa parte está no arquivo: 
    
    twitter_bot.py

Em seguida, a partir da lista de id's obtidas no passo anterior utilizamos a biblioteca tweepy para fazer o download dos tweets através da API disponibilizada pelo Twitter, Também exportando para um arquivo .csv . O código está no arquivo: 
    
    tweet_getter.py 

Assim que conseguimos o conteúdo dos tweets, passamos para a fase da limpeza de dados e análise de sentimento, utilizando a biblioteca de processamento de linguagem natural nltk aliada com a biblioteca de aprendizagem de máquina scikit-learn para a realização da análise de sentimento e assim descobrirmos a polaridade do tweet. O código está no arquivo:

	tweet_analisys_new.py

Logo após foi feita a inserção desses dados no banco de dados MySql servindo de base fonte para a montagem do Data Warehousing. O código está no arquivo:

	database_insertion.py





####Pentaho:


####Limitações:
Como o campo de localização no Twitter é uma caixa de texto livre, muitos usuários escreveram localizações inexistentes ou textos aleatórios em suas localizações, o que acabou acarretando um grande problema em nossas análises. Buscamos tentar tratar da melhor maneira possível esse problema, mas isso acabou virando uma limitação, pois muitos tweets não possuem localização definida.



## Equipe	 

    Carlos Santos
    José Matheus
    Lucas Silva
    Matheus Campos

