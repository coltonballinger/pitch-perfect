//
//  PlaySoundsViewController.swift
//  Pitch Perfect II
//
//  Created by Ballinger, Colton J. on 3/5/15.
//  Copyright (c) 2015 Ballinger, Colton J. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var engine: AVAudioEngine!
    var audioFile: AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        engine = AVAudioEngine()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func slowSound(sender: UIButton) {
        
        changeSpeed(0.5)
    }
    @IBAction func fastSound(sender: UIButton) {
        
        changeSpeed(2.0)
    }
    @IBAction func stopSound(sender: UIButton) {
        
        audioPlayer.stop()
        audioPlayer.currentTime = 0
    }
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        changePitch(1000)
    }
    @IBAction func playDarthVadorAudio(sender: UIButton) {
        
        changePitch(-800)
    }
    
    func changePitch(pitch: Float) {
        
        audioPlayer.stop()
        engine.stop()
        engine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        engine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        engine.attachNode(changePitchEffect)
        
        engine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        engine.connect(changePitchEffect, to: engine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile!, atTime: nil, completionHandler: nil)
        
        engine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    func changeSpeed(rate: Float) {
        
        engine.stop()
        engine.reset()
        
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
}
