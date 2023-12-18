 - Este script usa técnicas básicas de text mining.

- É possível explorar outros métodos de pré-processamento, features e modelos de classificação para melhorar o desempenho do modelo.

- Você pode utilizar [textblob](https://textblob.readthedocs.io/en/dev/) para criar uma base de dados ficticia para treino do modelo.
  
-  Instala os pacotes necessários para o correto funcionamento do script ("SnowballC", "e1071" e "caret").
  

  ![Sem título](https://github.com/0x5FE/SpamClassification/assets/65371336/fc4f3f9a-891b-468e-b8de-7ed2953228a9)

  # Algumas funções

  
- Divisão de treino e teste: ***Divide o dataset em conjuntos de treino (80%***) e teste ***(20%) usando sample*** e atribui ***as features ("X") e rótulos ("y") a cada conjunto.***
  
- Escolha do modelo: Define uma lista de classificadores potenciais ***("naiveBayes", "svmLinear", "randomForest" e "xgbLinear").***
  
- Ajuste de parâmetros: Realiza o ajuste de parâmetros para cada classificador usando a função tune.default com validação cruzada de 5 dobras e a métrica de precisão ("Accuracy").
  
- Seleção do melhor classificador: Escolhe o classificador com o maior valor de precisão obtido no ajuste de parâmetros.
  
- Treinamento do classificador: Treina o classificador final no conjunto de treino usando o método escolhido e os parâmetros otimizados.
  
- Predição de rótulos: Prediz os rótulos para o conjunto de teste usando o classificador treinado.
Avaliação do classificador:

- Calcula as métricas de precisão, recall, F1-score e cria uma matriz de 

- Validação cruzada F1-Score: Realiza validação cruzada de 5 dobras para estimar o F1-score (macro) do modelo.


# Contribuições:
Sinta-se livre para contribuir com este projeto sugerindo melhorias no script, documentação ou código.
