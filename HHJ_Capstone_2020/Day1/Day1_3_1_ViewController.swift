//
//  Day1_3_1_ViewController.swift
//  HHJ_Capstone_2020
//
//  Created by Chaerin Han on 2020/12/06.
//

import UIKit
import Speech

class Day1_3_1_ViewController: UIViewController, SFSpeechRecognizerDelegate {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var audioButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var firstImg: UIImageView!
    @IBOutlet weak var secondImg: UIImageView!
    @IBOutlet weak var thirdImg: UIImageView!
    @IBOutlet weak var fourthImg: UIImageView!
    @IBOutlet var fifthImg: UIView!
    @IBOutlet weak var progressbarImg: UIImageView!
    
    // 변수
    var user_recorded: String! // 사용자가 말한 문장 저장
    var record_count: Int! = 1
    
    // 말한 것을 인식
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    
    // 음성인식요청 처리, 말하면 recognitionRequest에서 음성인식 프로세스 진행
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    // 인식 요청 결과 제공
    private var recognitionTask: SFSpeechRecognitionTask?
    
    // 순수 소리만을 인식하는 오디오 엔진 객체
    private let audioEngine = AVAudioEngine()
    
    // 앱 실행 후 가장 먼저 실행
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        speechRecognizer?.delegate = self // speechRecognizer의 대리자는 현재 vc
    }
    
    // MARK: - Text Comparing
    func textCompare() {
        let answer = answerLabel.text?.trimmingCharacters(in: ["?"]) // 끝에 특수문자 제거
//        let answer: String! = "Do you have any seats in the back"
        
        // 정답 문장과 사용자 문장 공백 기준으로 나누기
        let answer_split = answer?.split(separator: " ")
        let user_recorded_split = user_recorded?.split(separator: " ")
        
        if answer_split == user_recorded_split {
            if record_count == 1{
                firstImg.backgroundColor = UIColor.blue
            }
            else if record_count == 2 {
                secondImg.backgroundColor = UIColor.blue
            }
            else if record_count == 3{
                thirdImg.backgroundColor = UIColor.blue
            }
            else if record_count == 4{
                fourthImg.backgroundColor = UIColor.blue
            }
            else if record_count == 5 {
                fifthImg.backgroundColor = UIColor.blue
            }
            else {
                // 혹시나 6번 할까봐
            }
            
        }
        else {
            if record_count == 1{
                firstImg.backgroundColor = UIColor.red
            }
            else if record_count == 2 {
                secondImg.backgroundColor = UIColor.red
            }
            else if record_count == 3{
                thirdImg.backgroundColor = UIColor.red
            }
            else if record_count == 4{
                fourthImg.backgroundColor = UIColor.red
            }
            else if record_count == 5 {
                fifthImg.backgroundColor = UIColor.red
            }
            else {
                // 혹시나 6번 할까봐
            }
        }
    }
    
    // MARK: - Speech To Text
    @IBAction func speechToText(_ sender: Any) {
        // 횟수 제한
        if record_count <= 5 {
            if audioEngine.isRunning { // 현재 음성인식 수행중이라면
                        audioEngine.stop() // 오디오 입력 중단
                        recognitionRequest?.endAudio() // 음성인식 역시 중단
                        recordButton.isEnabled = false
            //            button.setTitle("말하기!", for: .normal)
                        textCompare() // 텍스트 비교하기
                        record_count += 1 // STT 할 때마다 변수 +1
                    }
                    else {
                        startRecording()
            //            button.setTitle("말하기 멈추기", for: .normal)
                    }
        }
        else {
            recordButton.isEnabled = false
        }
    }
    
    func startRecording() {
        // 인식 작업이 실행 중인지 확인합니다. 이 경우 작업과 인식을 취소합니다.
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        // 오디오 녹음을준비 할 AVAudioSession 만들기
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playback, mode: .moviePlayback, options: [])
       //     try audioSession.setCategory(AVAudioSessionRecord)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        }
        catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        // 오디오 데이터를 apple 서버로 보내는데 사용
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        // 사용자가 말할 때의 인식적인 부분인 결과를 보고하도록 recognitionRequest에 지시
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                // 내가 말한 문장 받아오기
                self.user_recorded = result?.bestTranscription.formattedString
//                self.myTextView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
//        myTextView.text = "Say something, I'm listening!"
    }
    
    
}
