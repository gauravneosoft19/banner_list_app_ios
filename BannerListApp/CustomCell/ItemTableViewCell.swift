//
//  ItemTableViewCell.swift
//  BannerListApp
//
//  Created by apple on 23/11/21.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    var delegate: TableViewProtocol?

    var listViewModel = ListViewModel()

    let pageControl: UIPageControl = {
           let pc = UIPageControl()
           pc.currentPage = 0
           pc.translatesAutoresizingMaskIntoConstraints = false
           
           return pc
       }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if collectionView != nil{
            collectionView.isPagingEnabled = true
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.delegate = self
            collectionView.dataSource = self
            pageControl.numberOfPages = listViewModel.bannerItemList.count
            addSubview(pageControl)
            pageControl.centerXAnchor.constraint(equalTo: self.collectionView.centerXAnchor).isActive = true
            pageControl.bottomAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: -8).isActive = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
//MARK: CollectionView Delegate & DaatSource, FloLayout Delegate
extension ItemTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listViewModel.bannerItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height))
        let image = UIImage(named:listViewModel.bannerItemList[indexPath.row].imageName)!
        imageview.image = image
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFill
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = 4
        cell.contentView.addSubview(imageview)    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.width, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / self.contentView.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        listViewModel.itemList.shuffle()
        delegate?.refreshData()
    }
}
