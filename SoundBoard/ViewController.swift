//
//  ViewController.swift
//  SoundBoard
//
//  Created by William Hettinger on 3/2/18.
//  Copyright © 2018 William Hettinger. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var sounds : [Sound] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayer : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
        sounds = try context.fetch(Sound.fetchRequest())
        } catch {
            print("error fetching: \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let sound = sounds[indexPath.row]
        cell.textLabel?.text = sound.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let sound = sounds[indexPath.row]
        
        do {
        audioPlayer = try AVAudioPlayer(data: sound.audio!)
            audioPlayer?.play()
        } catch {
            print("error playing audio: \(error)")
        }
    }

}

