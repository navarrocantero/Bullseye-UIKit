//
//  ViewController.swift
//  bullseye_uiKit
//
//  Created by navarrocantero on 3/12/20.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0;
    var targetValue: Int = 0;
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel:UILabel!
    @IBOutlet weak var roundLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(score)
        roundLabel.text = String(0)
        slider.value = 50
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        let thumbImageHigh = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        let trackImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackImageMaximum = #imageLiteral(resourceName: "SliderTrackRight")
        let insets = UIEdgeInsets(top:0,left:14,bottom:0,right:14)
        let trackResizable = trackImage.resizableImage(withCapInsets: insets)
        let trackResizableMaximum = trackImageMaximum.resizableImage(withCapInsets: insets)
        slider.setThumbImage(thumbImageNormal,for:.normal)
        slider.setThumbImage(thumbImageHigh,for:.highlighted)
        slider.setMinimumTrackImage(trackResizable, for:.normal)
        slider.setMaximumTrackImage(trackImageMaximum, for: .normal)
    }
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        score += points
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
    
    @IBAction  func newGame(){
        
        score = 0
        round = 1
        startNewRound()
    }
    func startNewRound(){
        targetValue = Int.random(in:1...100)
        currentValue = 50
        round += 1
        slider.value = Float(currentValue)
        updateLabels()
    }
    func updateLabels(){
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    
}

