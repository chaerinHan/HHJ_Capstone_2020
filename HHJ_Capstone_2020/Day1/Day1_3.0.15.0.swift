//
//  Day1_3.0.15.0.swift
//  HHJ_Capstone_2020
//
//  Created by Chaerin Han on 2020/12/05.
//

import UIKit
import AVFoundation

var soundEffect: AVAudioPlayer?

class Day1_3_0_15_0: UIViewController {

    func playAudio() {
        let url = Bundle.main.url(forResource: "15.0.0", withExtension: "mp3")
            if let url = url {
                do{
                    soundEffect = try AVAudioPlayer(contentsOf: url)
                    guard let sound = soundEffect else {return}
                    sound.prepareToPlay()
                    sound.play()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        playAudio()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
