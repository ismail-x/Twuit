//
//  ViewController.swift
//  Twuit
//
//  Created by Ismail . on 06/09/20.
//  Copyright © 2020 Ismail . All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    
    
    let tweetCount = 100
    
    let sentimentClassifier = TwitSentimentClassifierIsmail()
    
    let swifter = Swifter(consumerKey: <#T##String#>, consumerSecret: <#T##String#>)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        
    }
    
    
    @IBAction func predictPressed(_ sender: UIButton) {
        
        fetchTweet()
        
    }
    
    func fetchTweet(){
        
        if let searchText = textField.text {
            
            swifter.searchTweet(using: searchText, lang: "in", count: tweetCount, tweetMode: .extended, success: { (results, metadata) in
                
                var tweets = [TwitSentimentClassifierIsmailInput]()
                
                for i in 0..<self.tweetCount {
                    
                    if let tweet = results[i]["full_text"].string{
                        let tweetForClassification = TwitSentimentClassifierIsmailInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }
                
                self.makePrediction(with: tweets)
                
            }) { (error) in
                print("There was an error with twitter API request\(error)")
            }
        }
    }
    
    func makePrediction(with tweets: [TwitSentimentClassifierIsmailInput]){
        do {
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            
            var sentimentScore = 0
            
            for pred in predictions{
                let sentiment = pred.label
                
                if sentiment == "happy"{
                    sentimentScore += 1
                } else if sentiment == "sadness"{
                    sentimentScore -= 1
                } else if sentiment == "anger"{
                    sentimentScore -= 1
                }else if sentiment == "love"{
                    sentimentScore += 2
                } else { //fear
                    sentimentScore -= 2
                }
            }
            
            updateUI(with: sentimentScore)
            
        }catch {
            print("there was an error with making prediction \(error)")
        }
        
    }
    
    func updateUI(with sentimentScore: Int){
        if sentimentScore > 20 {
            self.sentimentLabel.text = "🥰"
        } else if sentimentScore > 10 {
            self.sentimentLabel.text = "😆"
        } else if sentimentScore > 0 {
            self.sentimentLabel.text = "🤨"
        } else if  sentimentScore == 0 {
            self.sentimentLabel.text = "😐"
        } else if sentimentScore > -10 {
            self.sentimentLabel.text = "😔"
        } else if sentimentScore > -20 {
            self.sentimentLabel.text = "🤬"
        } else {
            self.sentimentLabel.text = "🤮"
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
         fetchTweet()
        return true
    }
}
