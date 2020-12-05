//
//  ChapterMenuViewController.swift
//  HHJ_Capstone_2020
//
//  Created by Chaerin Han on 2020/12/03.
//

import UIKit

class ChapterMenuViewController: UIViewController, UICollectionViewDataSource{
    
    let viewModel = ChapterViewModel()
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChapterCell", for: indexPath) as? ChapterCell else {
            return UICollectionViewCell()
        }
        
        let info = viewModel.chapterInfo(at: indexPath.row)
        cell.updateUI(info)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        
        let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2
        let height: CGFloat = width * 10/7 + textAreaHeight
        return CGSize(width: width, height: height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

class ChapterViewModel {

    let chapterInfoList: [ChapterInfo] = [
        ChapterInfo(chapter:"ch 1"), ChapterInfo(chapter:"ch 2"), ChapterInfo(chapter:"ch 3"), ChapterInfo(chapter:"ch 4"), ChapterInfo(chapter:"ch 5"),
        ChapterInfo(chapter:"ch 6"), ChapterInfo(chapter:"ch 7"), ChapterInfo(chapter:"ch 8"), ChapterInfo(chapter:"ch 9"),ChapterInfo(chapter:"ch 10"),
        ChapterInfo(chapter:"ch 11"), ChapterInfo(chapter:"ch 12"), ChapterInfo(chapter:"ch 13"), ChapterInfo(chapter:"ch 14"), ChapterInfo(chapter:"ch 15"),
        ChapterInfo(chapter:"ch 16"), ChapterInfo(chapter:"ch 17"), ChapterInfo(chapter:"ch 18"), ChapterInfo(chapter:"ch 19"), ChapterInfo(chapter:"ch 20")
    ]
    var numOfBountyInfoList: Int {
        return chapterInfoList.count
    }
    
    func chapterInfo(at index: Int) -> ChapterInfo {
        return chapterInfoList[index]
    }
}

class ChapterCell: UICollectionViewCell {
    
    @IBOutlet weak var chapterLabel: UILabel!
    func updateUI(_ chapterInfo: ChapterInfo) {
//        imgView.image = bountyInfo.image
        chapterLabel.text = chapterInfo.chapter
//        bountyLabel.text = "\(bountyInfo.bounty)"
    }
}
