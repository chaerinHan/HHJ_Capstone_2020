//
//  ChapterMenuViewController.swift
//  HHJ_Capstone_2020
//
//  Created by Chaerin Han on 2020/12/03.
//

import UIKit

class ChapterMenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var chapterList = ["ch1", "ch2", "ch3","ch4", "ch5", "ch6", "ch7", "ch8", "ch9", "ch10",
                       "ch11", "ch12", "ch13", "ch14", "ch15", "ch16", "ch17", "ch18", "ch19", "ch20"]
    
    class ChapterCell: UICollectionViewCell {
        @IBOutlet weak var chapterLabel: UILabel!
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // UICollectionViewDataSource
    // 몇 개 보여줄까?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    // 셀 어떻게 표현할까?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChapterCell", for: indexPath)
        // cell.lbl.text = list[indexPath.row]
//        cell.chapterLabel.text = chapterList[indexPath.row]
        return cell
    }
    
    // UICollectionViewDelegate
    // 셀이 클릭되었을 때 어떡할꺼야?
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
//    }
    
    // UICollectionViewFlowLayout
    // cell size
    // CGSize: 너비와 높이 계산해야함
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // let flowLayout = UICollectionViewFlowLayout()
       // let itemSpacing: CGFloat = 5// item간 간격
        
       // flowLayout.minimumInterItemSpacing = 10
       // flowLayout.minimumLineSpacing = 10
        
        // 5개씩 4줄
       // let width: CGFloat = (collectionView.bounds.width - itemSpacing) / 5
       // let height: CGFloat = width
        let fullWidth: CGFloat = collectionView.bounds.height / 4
        let width: CGFloat = fullWidth
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1
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
