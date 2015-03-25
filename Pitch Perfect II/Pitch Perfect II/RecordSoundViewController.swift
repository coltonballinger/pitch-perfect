//
//  RecordSoundViewController.swift
//  Pitch Perfect II
//
//  Created by Ballinger, Colton J. on 3/5/15.
//  Copyright (c) 2015 Ballinger, Colton J. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {

        recordButton.enabled = true
        recordingLabel.text = "Tap to Record"
    }

    @IBAction func recordAudio(sender: UIButton) {
        
        recordingLabel.text = "Recording"
        recordButton.enabled = false
        stopButton.hidden = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate() //this allows you to get the current date and time
        let formatter = NSDateFormatter() // this allows you to configure how you want the date to look
        formatter.dateFormat = "ddMMyyyy-HHmmss" // this is the actual format of the date and time
        
        let recordingName = formatter.stringFromDate(currentDateTime) + ".wav" //this returns the dates format in a string
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray) // this takes our file and converts into NSURL
        println(filePath)
        
        var audioSession: AVAudioSession = AVAudioSession.sharedInstance() // creates one session and returns it
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord!, error: nil) // defines how the app intends to use audio
        
        // url tells where the system should record the audio to
        // settings tells what settings the recording should use 
        // error allows you to tell the user if something doesnt work
        audioRecorder = AVAudioRecorder(URL: filePath!, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }

    @IBAction func stopAudio(sender: UIButton) {
        
        audioRecorder.stop()
        
        // the two lines below deactivate the audioSession
        var audioSession = AVAudioSession.sharedInstance()
        
        audioSession.setActive(false, error: nil)
    }
    
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag {
            
            recordedAudio = RecordedAudio(Title: recorder.url.lastPathComponent!, filePathUrl: recorder.url)
            
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else {
            println("error")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            
            var PlaySoundVC = segue.destinationViewController as PlaySoundsViewController
            
            let data = sender as RecordedAudio
            
            PlaySoundVC.receivedAudio = data
        }
    }
}

