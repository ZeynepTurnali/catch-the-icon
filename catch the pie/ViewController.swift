//
//  ViewController.swift
//  catch the icon
//
//  Created by testinium on 14.09.2020.
//  Copyright © 2020 testinium. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var score = 0
    var counter = 30
    var timer = Timer()
    var hideTimer = Timer()
    var iconArray = [UIImageView]()
    var highScore = 0
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var icon2: UIImageView!
    @IBOutlet weak var icon3: UIImageView!
    @IBOutlet weak var icon4: UIImageView!
    @IBOutlet weak var icon5: UIImageView!
    @IBOutlet weak var icon6: UIImageView!
    @IBOutlet weak var icon7: UIImageView!
    @IBOutlet weak var icon8: UIImageView!
    @IBOutlet weak var icon9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        icon1.isUserInteractionEnabled = true
        icon2.isUserInteractionEnabled = true
        icon3.isUserInteractionEnabled = true
        icon4.isUserInteractionEnabled = true
        icon5.isUserInteractionEnabled = true
        icon6.isUserInteractionEnabled = true
        icon7.isUserInteractionEnabled = true
        icon8.isUserInteractionEnabled = true
        icon9.isUserInteractionEnabled = true
        
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        icon1.addGestureRecognizer(gestureRecognizer1)
        icon2.addGestureRecognizer(gestureRecognizer2)
        icon3.addGestureRecognizer(gestureRecognizer3)
        icon4.addGestureRecognizer(gestureRecognizer4)
        icon5.addGestureRecognizer(gestureRecognizer5)
        icon6.addGestureRecognizer(gestureRecognizer6)
        icon7.addGestureRecognizer(gestureRecognizer7)
        icon8.addGestureRecognizer(gestureRecognizer8)
        icon9.addGestureRecognizer(gestureRecognizer9)
        
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5 , target: self, selector: #selector(hiddenIcon), userInfo: nil, repeats: true)
        
        iconArray = [icon1, icon2, icon3, icon4, icon5, icon6, icon7, icon8, icon9]
        
        hiddenIcon()
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore:\(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore:\(highScore)"
        }
        
    }

    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if self.score > self.highScore {
            self.highScore = self.score
            highScoreLabel.text = "Highscore:\(self.highScore)"
            UserDefaults.standard.set(self.highScore, forKey: "highScore")
        }
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for icon in iconArray {
                icon.isHidden = true
            }
            makeAlert(title: "Time is Over!", message: "Do you want to play again?")
        }
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        
        let playAgainButton = UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default){ (UIAlertAction) in
            
            self.score = 0
            self.scoreLabel.text = "Score: \(self.score)"
            self.counter = 30
            self.timeLabel.text = String(self.counter)
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
            
            self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5 , target: self, selector: #selector(self.hiddenIcon), userInfo: nil, repeats: true)
            
            
        }
        
        alert.addAction(okButton)
        alert.addAction(playAgainButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func hiddenIcon(){
        for icon in iconArray {
            icon.isHidden = true
        }
        
        let random = Int (arc4random_uniform(UInt32(iconArray.count - 1)))
        iconArray[random].isHidden = false
    }

}

