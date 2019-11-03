//
//  SitesListImageTableViewCell.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/1.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol SitesListImageCellDelegate: AnyObject {
    func pressImageCell(_ cell: UITableViewCell,_ images: [String], _ imageIndex: Int)
}

class SitesListImageTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionview: UICollectionView! {
        didSet {
            collectionview.delegate = self
            collectionview.dataSource = self
        }
    }
    
    let minCollectionViewSpacing: CGFloat = 8
    
    var images: [String] = [] {
        didSet {
            collectionview.reloadData()
            if images.count > 0 {
                collectionview.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
            }
        }
    }
    
    weak var delegate: SitesListImageCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionview.registerCellWithNib(
            identifier: SitesListImageCollectionViewCell.identifier,
            bundle: nil)
    }
    
    func layoutCell(images: [String]) {
        self.images = images
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }    
}

extension SitesListImageTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.pressImageCell(self, images, indexPath.row)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - minCollectionViewSpacing) / 2
        let height = width / 3 * 2
        return CGSize(width: width, height: height)
    }
}


extension SitesListImageTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SitesListImageCollectionViewCell.identifier,
                for: indexPath
                )
                as? SitesListImageCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.layoutCell(imageURL: images[indexPath.row])
        
        return cell
    }
    
}
