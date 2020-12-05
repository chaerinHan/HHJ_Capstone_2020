//
//  Day1_2_1ViewController.swift
//  HHJ_Capstone_2020
//
//  Created by Chaerin Han on 2020/12/06.
//

import UIKit
import AVFoundation

class Day1_2_1ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var listenButton: UIButton!
    // 그냥 페이지들어가면 오디오 파일 1번 나오기
    
    @IBAction func recordButton(_ sender: Any) {
        if audioRecorder?.isRecording == false{ // recording 안하는중이라면
            listenButton.isEnabled = false
//            stopButton.isEnabled = true
            audioRecorder?.record()
        }
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        }
        else {
            audioPlayer?.stop()
        }
    }
    // 내 목소리 듣기
    @IBAction func listenButton(_ sender: Any) {
        if audioRecorder?.isRecording == false {
//            stopButton.isEnabled = true
            recordButton.isEnabled = false
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: audioRecorder!.url)
                audioPlayer?.delegate = self
                audioPlayer?.play()
            } catch {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
    
    // AVAudioPlayer 인스턴스, AVAudioRecorder 인스턴스의 참조체를 저장할 프로퍼티 추가
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    var bombSoundEffect: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 오디오 파일 재생
        let audioPath = URL(fileURLWithPath: "15.0.0.mp3")
        let audioFilePlayer = AVPlayer(url: audioPath)
        audioFilePlayer.play()
        
        // AVAudioRecorder 인스턴스 생성
        // 아무런 녹음이 되지 않았기 떼문에 버튼을 비활성화
//        playButton.isEnabled = false
//        stopButton.isEnabled = false
        
        // 도큐먼트 디렉터리 확인
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0] as String
        
        // sound.caf 이름의 파일을 위하 URL 구성
        let soundFilePath = docsDir.appending("/sound.caf")
        let soundFileURL = URL(fileURLWithPath: soundFilePath)
        // 녹음 품질 설정
        let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
                              AVEncoderBitRateKey: 16,
                              AVNumberOfChannelsKey: 2,
        AVSampleRateKey: 44100.0] as [String: Any]
        
        // 공유 오디오 세션 인스턴스를 반환 받는다
        let audioSession = AVAudioSession.sharedInstance()
        do{
            // 현재 오디오 세션의 카테고리를 정한다 (재생, 녹음)
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
        }
        catch {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        // audioRecorder 인스턴스 실행
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileURL, settings: recordSettings)
            audioRecorder?.prepareToRecord()
        } catch {
            print("audioSession Error: \(error.localizedDescription)")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK : - AVAudioPlayerDelegate
    
    // 재생 종료하면 호출
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
//        stopButton.isEnabled = false
    }
    
    // 디코더 에러 발생하면 호출
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Player Decode Error")
    }
    
    // MARK: -AvudioRecorderDelegate
    
    // 시간 제한으로 녹음 종료하면 호출
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Record Success")
    }
    
    // 녹음중 에러 발생하면 호출
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Audio Recorder Encode Error")
    }
}
