//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by William Hettinger on 3/2/18.
//  Copyright © 2018 William Hettinger. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
        
    }
    
    func setupRecorder() {
        // create an audio session
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            // create URL for the audio file
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            print("############################")
            print(audioURL)
            
            // create settings for audio recorder
            var settings : [String : AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject
            settings[AVSampleRateKey] = 44100.0 as AnyObject
            settings[AVNumberOfChannelsKey] = 2 as AnyObject
            
            // create audiorecorder object
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder?.prepareToRecord()
        
        } catch let error as NSError {
            print("error setting up session: (\(error)")
        }
    }
    
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording {
            //Stop the recording
            audioRecorder?.stop()
            //change the button to Record
            recordButton.setTitle("Record", for: .normal)
        } else {
            //start the recording
            audioRecorder?.record()
            //change button title to Stop
            recordButton.setTitle("Stop", for: .normal)
        }
        
    }
    
    @IBAction func playTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
    
    
}
