import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/ismail/Documents/ios dev/untitled folder/Twuit/twitter-sanders-apple3/TW.csv"))

let(trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "tweet", labelColumn: "label")

let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "tweet", labelColumn: "label")

let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: "Ismail", shortDescription: "mantap ini bisa menyelediki tweet rang orang", license: "1.0", version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/ismail/Documents/ios dev/untitled folder/Twuit/TwitSentimentClassifierIsmail.mlmodel"))

try sentimentClassifier.prediction(from: "saya bahagia sekali")
