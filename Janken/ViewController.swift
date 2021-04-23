//
//  ViewController.swift
//  Janken
//
//  Created by Ryan Kanno on 4/27/20.
//  Copyright © 2020 Ryan Kanno. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var speakerButton: UIButton!
    var soundOn:Bool = true
    var audioPlayer:AVAudioPlayer?
    let pokemonBattleSongs = "PokemonBattleSongs"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSong(filename: pokemonBattleSongs)
    }
    
    
    @IBAction func speakerButtonTapped(_ sender: UIButton) {
        if soundOn == true {
            soundOn = false
            let speakerIcon = UIImage(systemName: "speaker.slash")
            speakerButton.setImage(speakerIcon, for: .normal)
        } else {
            soundOn = true
            let speakerIcon = UIImage(systemName: "speaker.wave.2")
            speakerButton.setImage(speakerIcon, for: .normal)
        }
    }
    
    
    func playSong(filename:String) {
        // Get the url
        let url = Bundle.main.url(forResource: filename, withExtension: "mp3")
        
        // Make sure that we've got the url, otherwise abort
        guard url != nil else {
            return
        }
        // Create the audio player and play the sound
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer?.play()
        } catch {
            print("error playing audio")
        }
    } // End of func playSong
    

} // End of class ViewController

