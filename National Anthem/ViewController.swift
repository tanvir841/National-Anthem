//
//  ViewController.swift
//  National Anthem
//
//  Created by Tanvir Ahmed on 1/4/20.
//  Copyright © 2020 Tanvir Ahmed. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var playTime = ["Bangladesh": 91, "Saudi Arabia": 72, "Russia": 225, "Poland": 172, "Germany": 164 ,"UK": 180 ,"Australia": 130 ]
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var displayLabel: UILabel!
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPressed(_ sender: UIButton) {
        playSound(soundName: sender.currentTitle!)
                 
                 sender.alpha = 0.5
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                     sender.alpha = 1.0
                
                self.timer.invalidate()
                let countryName = sender.currentTitle!
                self.totalTime = self.playTime[countryName]!
                self.progressBar.progress = 0.0
                self.secondPassed = 0
                self.displayLabel.text = countryName
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
                
                                 }
    }
    @IBAction func stopBtn(_ sender: Any) {
        player.stop()
        timer.invalidate()
        displayLabel.text = "Press another Flag"
        progressBar.progress = 0.0
    }
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "m4a")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
    @objc func updateTimer(){
           if secondPassed < totalTime {
            displayLabel.text = "Playing.."
               secondPassed += 1
               progressBar.progress = Float(secondPassed) / Float(totalTime)
                             
           } else {
               timer.invalidate()
               displayLabel.text = "Press another Flag"
               
           }
       }
}

