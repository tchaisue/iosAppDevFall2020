//
//  ViewController.swift
//  Bullseye
//
//  Created by Tanarut Chaisuesomboon on 9/4/20.
//  Copyright © 2020 Tanarut Chaisuesomboon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bullseyeStyling()
        startNewGame()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showAlert(){
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        let title: String
        
        if(difference == 0){
            title = "Perfect!"
            points = 200
        } else if (difference < 5){
            title = "You almost had it!"
            points = 150
        } else if (difference < 10){
            title = "Pretty good!"
        } else{
            title = "Not even close..."
        }
        
        score += points
        
        let message = "The value of the slider is: \(currentValue)" +
                      "\nThe target value is: \(targetValue)"
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                                                                self.startNewRound()
                                                                            })
        
        alert.addAction(action)
        
        present(alert, animated:true, completion: nil)
        
        //startNewRound()
        
    }

    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
        print("The value of the slider is now: \(slider.value)")
    }
    
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        round+=1
        updateLabels()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)

    }
    
    @IBAction func startNewGame(){
        round = 0;
        score = 0;
        startNewRound()
        
    }
    
    func bullseyeStyling(){
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }



}

