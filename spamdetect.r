install.packages("SnowballC")
install.packages("e1071")
install.packages("caret")

library(tm)
library(e1071)
library(caret)

# Pré-processar o texto
preprocess_text <- function(text) {
  text <- tolower(text)
  text <- removePunctuation(text)
  text <- removeNumbers(text)
  text <- removeWords(text, stopwords("en"))
  text <- stripWhitespace(text)
  # Stemming
  text <- wordStem(text, language = "english")
  # N-grams
  ngrams <- c(1, 2, 3)
  tfidf <- weightTfIdf(dtm, ngrams)
  X <- as.matrix(tfidf)
  return(text)
}

# Criar um conjunto de dados de amostra
data <- data.frame(
  email_text = c(
    "This is a legitimate email",
    "Buy our products now!",
    "Important information about your account",
    "Get rich quick scheme",
    "Claim your prize today"
  ),
  label = c("ham", "spam", "ham", "spam", "spam")
)

# Pré-processar o texto
corpus <- Corpus(VectorSource(data$email_text))
corpus <- tm_map(corpus, content_transformer(preprocess_text))
data$preprocessed_text <- sapply(corpus, function(x) as.character(x))

# Criar matriz documento-termo
dtm <- DocumentTermMatrix(corpus)

X <- as.matrix(dtm)

# Embaralhar o conjunto de dados
set.seed(42)
data <- data[sample(nrow(data)), ]

# Dividir dados
train_size <- round(0.8 * nrow(data))
X_train <- X[1:train_size, ]
X_test <- X[(train_size + 1):nrow(data), ]
y_train <- data$label[1:train_size]
y_test <- data$label[(train_size + 1):nrow(data)]

# Escolha do modelo
# Explore other classifiers
classifiers <- c("naiveBayes", "svmLinear", "randomForest", "xgbLinear")
                                 
# Ajuste de parâmetros
for (classifier in classifiers) {
  tuneResult <- tune.default(
    classifier,
    X_train,
    y_train,
    metric = "Accuracy",
    trControl = trainControl(method = "cv", number = 5)
  )
  best_parameters <- tuneResult$bestTune
  print(classifier)
  print(best_parameters)
}

# Escolha o melhor classificador
best_classifier <- classifiers[which.max(sapply(classifiers, function(x) tuneResult$bestTune$Accuracy))]

# Treinar o classificador
final_classifier <- train(X_train, y_train, method = best_classifier, tuneGrid = best_parameters)


y_pred <- predict(final_classifier, X_test)

accuracy <- mean(y_pred == y_test)
precision <- precision(y_pred, y_test)
recall <- recall(y_pred, y_test)
f1 <- f1_score(y_pred, y_test)

confusion <- table(y_test, y_pred)

print(confusion)
print(classification_report(y_test, y_pred))

# Validação cruzada F1-Score
cv_scores <- crossval(final_classifier, X, y, folds = 5)
print(paste("Cross-Validation F1-Score (macro):", mean(cv_scores), "\n"))
