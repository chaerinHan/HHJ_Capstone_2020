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

    @IBOutlet weak var nextButton: UIButton!
    func playAudio() {
        let url = Bundle.main.url(forResource: "15.0.0", withExtension: "mp3")
            if let url = url {
                do{
                    soundEffect = try AVAudioPlayer(contentsOf: url)
                    guard let sound = soundEffect else {return}
//                    NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: url)
                    NotificationCenter.default.addObserver(self,selector:Selector(("playerDidFinishPlaying")), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: url)
                    sound.prepareToPlay()
                    sound.play()
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            }
    }

    @objc func playerDidFinishPlaying(sender: Notification) {
        // Your code here
        // isHidden = false 면 보여준다
        nextButton.isHidden = false

    }
    func playerDidFinishPlaying() {
    // Your code here
        nextButton.isHidden = false
    }
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
//        nextButton.isHidden = true // 화면 처음 실행할 때는 "다음페이지"버튼 숨기기
        playAudio()
//        playerDidFinishPlaying()
//        nextButton.isHidden = true
        
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
