//
//  ViewController.swift
//  EggTimer
//
//  Created by Jewell Huffman on 08/07/2019.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
     var player: AVAudioPlayer!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    let eggTimes = ["Soft": 5, "Medium": 420, "Hard": 720]
    
    var secondsRemaining = 60
    
    var timer = Timer()

    @IBAction func hardnesSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle
        
        secondsRemaining = eggTimes[hardness!]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            timerLabel.text = "\(timeFormatted(secondsRemaining))"
            secondsRemaining -= 1
        }
        else {
            timer.invalidate()
            timerLabel.text = "DONE!"
            playSound(soundName: "alarm_sound")
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }

    
}
