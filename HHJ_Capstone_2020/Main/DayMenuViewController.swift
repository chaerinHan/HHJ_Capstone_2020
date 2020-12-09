//
//  DayMenuViewController.swift
//  HHJ_Capstone_2020
//
//  Created by Chaerin Han on 2020/12/07.
//

import UIKit

class DayMenuViewController: UIViewController {

    
    @IBOutlet weak var chapterLabel: UILabel!
    
    var receiveItem = ""
    override func viewDidLoad() {
        super.viewDidLoad()
     
        chapterLabel.text = receiveItem
        
        // Do any additional setup after loading the view.
    }
    
    // ChapterVC에서 chapter명 받아오기
    func receiveItem(_ chapter: String){
            receiveItem = chapter
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
