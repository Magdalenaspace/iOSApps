//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    

    
    @IBOutlet weak var UiProgress: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var player: AVAudioPlayer!
    var timer = Timer()
    var seconsPassed = 0
    var totalTime = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        UiProgress.progress = 0.0
        seconsPassed = 0
        titleLabel.text = hardness
        
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconsPassed < totalTime {
           // print("\(seconsRemaining) seconds")
            seconsPassed += 1
            UiProgress.progress = Float(seconsPassed) / Float(totalTime)
            print(Float(seconsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            titleLabel.text = "Done"
            
                let url = Bundle.main.url(forResource:"alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url! )
            player.play()
        
            
        }
    }
        
}

