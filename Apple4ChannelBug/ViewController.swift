//
//  ViewController.swift
//  Apple4ChannelBug
//
//  Created by Tim Hoogstrate on 20/03/2019.
//  Copyright © 2019 Tim Hoogstrate. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func playOneChannelAudio(_ sender: Any) {
        let audioDecoder = TSAudioDecoder()
        let soundData = NSData(contentsOfFile: Bundle.main.path(forResource: "sample-1-channel", ofType: "aac")!)! as Data
        let array = [UInt8](soundData)
        let audioSample = AudioSample.init(channels: 1, sampleRate: 44100, audioData: array)
        audioDecoder.startSession(audioSample: audioSample)
    }
    
    @IBAction func playTwoChannelAudio(_ sender: Any) {
        let audioDecoder = TSAudioDecoder()
        let soundData = NSData(contentsOfFile: Bundle.main.path(forResource: "sample-2-channels", ofType: "aac")!)! as Data
        let array = [UInt8](soundData)
        let audioSample = AudioSample.init(channels: 2, sampleRate: 44100, audioData: array)
        audioDecoder.startSession(audioSample: audioSample)
    }
    
    @IBAction func playThreeChannelAudio(_ sender: Any) {
        let audioDecoder = TSAudioDecoder()
        let soundData = NSData(contentsOfFile: Bundle.main.path(forResource: "sample-3-channels", ofType: "aac")!)! as Data
        let array = [UInt8](soundData)
        let audioSample = AudioSample.init(channels: 3, sampleRate: 44100, audioData: array)
        audioDecoder.startSession(audioSample: audioSample)
    }
    
    @IBAction func playFourChannelAudio(_ sender: Any) {
        let audioDecoder = TSAudioDecoder()
        let soundData = NSData(contentsOfFile: Bundle.main.path(forResource: "sample-4-channels", ofType: "aac")!)! as Data
        let array = [UInt8](soundData)
        let audioSample = AudioSample.init(channels: 4, sampleRate: 44100, audioData: array)
        audioDecoder.startSession(audioSample: audioSample)
    }
    
    @IBAction func playFiveChannelAudio(_ sender: Any) {
        let audioDecoder = TSAudioDecoder()
        let soundData = NSData(contentsOfFile: Bundle.main.path(forResource: "sample-5-channels", ofType: "aac")!)! as Data
        let array = [UInt8](soundData)
        let audioSample = AudioSample.init(channels: 5, sampleRate: 44100, audioData: array)
        audioDecoder.startSession(audioSample: audioSample)
    }
    
    @IBAction func playSixChannelAudio(_ sender: Any) {
        let audioDecoder = TSAudioDecoder()
        let soundData = NSData(contentsOfFile: Bundle.main.path(forResource: "sample-6-channels", ofType: "aac")!)! as Data
        let array = [UInt8](soundData)
        let audioSample = AudioSample.init(channels: 6, sampleRate: 44100, audioData: array)
        audioDecoder.startSession(audioSample: audioSample)
    }
    
    @IBAction func oneChannelAVAudioPlayer(_ sender: Any) {
        let soundData = NSData(contentsOfFile: Bundle.main.path(forResource: "sample-1-channel", ofType: "aac")!)! as Data

        do {
            let audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func twoChannelAVAudioPlayer(_ sender: Any) {
        let soundData = NSData(contentsOfFile: Bundle.main.path(forResource: "sample-2-channels", ofType: "aac")!)! as Data
        
        do {
            let audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func threeChannelAVAudioPlayer(_ sender: Any) {
        let soundData = NSData(contentsOfFile: Bundle.main.path(forResource: "sample-3-channels", ofType: "aac")!)! as Data
        
        do {
            let audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func fourChannelAVAudioPlayer(_ sender: Any) {
        let soundData = NSData(contentsOfFile: Bundle.main.path(forResource: "sample-4-channels", ofType: "aac")!)! as Data
        
        do {
            let audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func fiveChannelAVAudioPlayer(_ sender: Any) {
        let soundData = NSData(contentsOfFile: Bundle.main.path(forResource: "sample-5-channels", ofType: "aac")!)! as Data
        
        do {
            let audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func sixChannelAVAucioPlayer(_ sender: Any) {
        let soundData = NSData(contentsOfFile: Bundle.main.path(forResource: "sample-6-channels", ofType: "aac")!)! as Data
        
        do {
            let audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}

