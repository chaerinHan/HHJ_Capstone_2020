//
//  ChapterMenuViewController.swift
//  HHJ_Capstone_2020
//
//  Created by Chaerin Han on 2020/12/03.
//

import UIKit

class ChapterMenuViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var list = ["ch1", "ch2", "ch3", "ch4" ,"ch5", "ch6", "ch7", "ch8", "ch9", "ch10",
                "ch11", "ch12", "ch13", "ch14" ,"ch15", "ch16", "ch17", "ch18", "ch19", "ch20",]
    
    
    override func viewDidLoad() {
        
            super.viewDidLoad()
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            
    }
    // MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            // Get the new view controller using segue.destination.
//            // Pass the selected object to the new view controller.
//            if segue.identifier == "sgDetail" {
//                let cell = sender as! UITableViewCell
//                let indexPath = self.tvListView.indexPath(for: cell)
//                let detailView = segue.destination as! DetailViewController
//                detailView.receiveItem(items[((indexPath as NSIndexPath?)?.row)!])
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToDayMenu" { // 챕터 셀 누르면 나올 화면
            let cell = sender as! UICollectionViewCell
            let indexPath = self.collectionView.indexPath(for: cell )
            let dayView = segue.destination as! DayMenuViewController
            dayView.receiveItem(list[((indexPath as NSIndexPath?)?.row)!])
        }
    }
}
    // cell data
extension ChapterMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CSCollectionViewCell
            
//        cell.backgroundColor = .lightGray
        cell.lbl.text = list[indexPath.row]
//        cell.lbl.backgroundColor = .yellow
            
        return cell
    }
}

    // cell layout
extension ChapterMenuViewController: UICollectionViewDelegateFlowLayout {

    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width / 5 - 1 //  5등분하여 배치, 옆 간격이 1이므로 1을 빼줌
        print("collectionView width=\(collectionView.frame.width)")
        print("cell하나당 width=\(width)")
        print("root view width = \(self.view.frame.width)")

        let size = CGSize(width: width, height: width)
        return size
    }
    
}

// custom cell
class CSCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet var lbl: UILabel!
}
