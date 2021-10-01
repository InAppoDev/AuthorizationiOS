//
//  PhotoCollectionViewCell.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 31.01.2021.
//

import UIKit

protocol PhotoCollectionViewCellProtocol {
    func display(imageUrl: String?)
}

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
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
//        imageView.image = nil
    }
    
    private func setupView() {
        
    }
    
}

extension PhotoCollectionViewCell: PhotoCollectionViewCellProtocol {
    
    func display(imageUrl: String?) {
       
    }
}
