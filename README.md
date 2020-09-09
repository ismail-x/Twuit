# Twuit

hmm apa ya?

this is an app that got some machine learning
and the dataset is some tweet Bahasa Indonesia

base on your search about account or hastag in Twitter
in Bahasa 

and this is app got RealTime the Latest that you search in Twitter

Sentiment emotion Twitter it think?

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
        
        
