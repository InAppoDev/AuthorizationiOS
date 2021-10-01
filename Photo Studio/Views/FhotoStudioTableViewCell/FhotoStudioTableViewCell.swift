//
//  FhotoStudioTableViewCell.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 31.01.2021.
//

import UIKit

protocol FhotoStudioTableViewCellProtocol {

}

class FhotoStudioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetContent()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetContent()
    }
     
    private func resetContent() {

    }
    
    private func setupView() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(PhotoCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension FhotoStudioTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.create(PhotoCollectionViewCell.self, indexPath)
        return cell
    }
    
}

extension FhotoStudioTableViewCell: UICollectionViewDelegate {
     
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}

extension FhotoStudioTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.bounds.height)
    }
    
}

extension FhotoStudioTableViewCell: FhotoStudioTableViewCellProtocol {
    
   
}
