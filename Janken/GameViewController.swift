//
//  GameViewController.swift
//  Janken
//
//  Created by Ryan Kanno on 4/27/20.
//  Copyright © 2020 Ryan Kanno. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    @IBOutlet weak var cpuRockImage: UIImageView!
    @IBOutlet weak var cpuScissorsImage: UIImageView!
    @IBOutlet weak var cpuPaperImage: UIImageView!
        
    @IBOutlet weak var playerRockImage: UIButton!
    @IBOutlet weak var playerScissorsImage: UIButton!
    @IBOutlet weak var playerPaperImage: UIButton!
        
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var cpuScoreLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var roundsLeftLabel: UILabel!
    
    var playerScore:Int = 0
    var cpuScore:Int = 0
    
    var playerChoice:Int?
    var computerChoice:Int?
    
    var gameCount:Int = 0
    
    var gameWinCount:Int?
    var gameLoseCount:Int?
    
    var roundsLeft:Int = 5
    
    var soundEffect:AVAudioPlayer?
    let swordClash = "SwordSoundEffects"
    
    // Rock tag is 0, Paper tag is 1, Scissors tag is 2
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        winLabel.alpha = 0
        
    } // End of override func viewDidLoad()
 
    
    @IBAction func playerTapped(_ sender: UIButton) {
        playSoundEffect(filename: swordClash)
        
        if gameCount == 5 {
            reset()
        }
        
        sender.pulsate()
        
        let buttonTag:Int = ((sender as AnyObject).tag)
        playerChoice = buttonTag
        janken(playerChoice: buttonTag)
        
        switch playerChoice {
        case 0:
            playerRockImage.alpha = 1
            playerScissorsImage.alpha = 0.5
            playerPaperImage.alpha = 0.5
        case 1:
           playerRockImage.alpha = 0.5
            playerScissorsImage.alpha = 0.5
            playerPaperImage.alpha = 1
        case 2:
            playerRockImage.alpha = 0.5
            playerScissorsImage.alpha = 1
            playerPaperImage.alpha = 0.5
        default:
            break
        }
        
        gameCount += 1
        roundsLeft -= 1
        
        roundsLeftLabel.text = "\(roundsLeft) Rounds Left"
        showWinLabel(gameCount: gameCount)
    }
    
    
    func playSoundEffect(filename:String) {
        // Get the url
        let url = Bundle.main.url(forResource: filename, withExtension: "m4a")
        // forResources: "SwordSoundEffects"
        
        // Make sure that we've got the url, otherwise abort
        guard url != nil else {
            return
        }
        // Create the sound effect and play the sound
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url!)
            soundEffect?.play()
            print(url!)
        } catch {
            print("error playing sound effect")
        }
    } // End of func playSoundEffect
    
    
    @IBAction func resetTapped(_ sender: Any) {
        reset()
    }
    @IBAction func backTapped(_ sender: Any) {
        // Return to View Controller
        dismiss(animated: true, completion: nil)
        reset()
    }
    
    func playOtherMusic() {
        
        //;askdjf;ladjf;asjdf;oadi
    }
    
    func reset() {
        playerScore = 0
        cpuScore = 0
        roundsLeft = 5
        playerChoice = nil
        computerChoice = nil
        playerScoreLabel.text = String(playerScore)
        cpuScoreLabel.text = String(cpuScore)
        roundsLeftLabel.text = "\(roundsLeft) Rounds Left"
        
        playerRockImage.alpha = 1
        playerScissorsImage.alpha = 1
        playerPaperImage.alpha = 1
        
        cpuRockImage.alpha = 1
        cpuScissorsImage.alpha = 1
        cpuPaperImage.alpha = 1
        
        winLabel.alpha = 0
        
        gameCount = 0
    }
    
    
    func showWinLabel(gameCount:Int) {
        if gameCount == 5 {
            if playerScore > cpuScore {
                // Player wins
                winLabel.text = "Player Wins!"
                winLabel.alpha = 1
            } else if playerScore < cpuScore {
                // CPU wins
                winLabel.text = "CPU Wins!"
                winLabel.alpha = 1
            } else {
                // It's a tie
                winLabel.text = "It's A Tie!"
                winLabel.alpha = 1
            }
        } // End of if gameCount
    } // End of func showWinLabel
    
    
    fileprivate func highlightImageSelections() {
        switch computerChoice {
        case 0:
            cpuRockImage.alpha = 1
            cpuPaperImage.alpha = 0.5
            cpuScissorsImage.alpha = 0.5
            cpuRockImage.pulsate()
        case 1:
            cpuRockImage.alpha = 0.5
            cpuPaperImage.alpha = 1
            cpuScissorsImage.alpha = 0.5
            cpuPaperImage.pulsate()
        case 2:
            cpuRockImage.alpha = 0.5
            cpuPaperImage.alpha = 0.5
            cpuScissorsImage.alpha = 1
            cpuScissorsImage.pulsate()
        default:
            break
        }
    }
    
    func janken(playerChoice:Int) { // true = win, false = loose
        //computerChoice = Int.random(in: 0...2);  // Randomize computer choice
        // NOTE: arc4random is a more random way of calling random numbers than Int.random
        computerChoice = Int(arc4random_uniform(3))
        
        highlightImageSelections()
 
        // Performs Janken round and checks win, lose, tie conditions
        if playerChoice == computerChoice {
            // It's a tie.  Do nothing.
            winLabel.text = "Tie!"
            winLabel.alpha = 1
        } else if (playerChoice == 0 && computerChoice == 2) || (playerChoice == 1 && computerChoice == 0) || (playerChoice == 2 && computerChoice == 1) {
            // Player wins
            playerScore += 1
            playerScoreLabel.text = String(playerScore)
            winLabel.text = "Win!"
            winLabel.alpha = 1
        } else {
            // Player loses
            cpuScore += 1
            cpuScoreLabel.text = String(cpuScore)
            winLabel.text = "Lose!"
            winLabel.alpha = 1
        }
        
        
        
        /*
        Win conditions:
        Player:CPU
            0:2 (rock:scissors)
            1:0 (paper:rock)
            2:1 (scissors:paper)
         
        Loose conditions:
        Player:CPU
            0:1 (rock:paper)
            1:2 (paper:scissors)
            2:0 (scissors:rock)
        */
        
    } // End of func janken
    
   
 
} // End of GameViewController
