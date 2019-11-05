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

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    let minCollectionViewSpacing: CGFloat = 8
    
    var images: [String] = [] {
        didSet {
            collectionView.reloadData()
            if images.count > 0 {
                collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
            }
        }
    }
    
    weak var delegate: SitesListImageCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        guard
            let layout = collectionView.collectionViewLayout
            as? UICollectionViewFlowLayout
        else { return }
        
        let width = (collectionView.bounds.width - minCollectionViewSpacing) / 2
        let height = width / 3 * 2

        layout.itemSize = CGSize(width: width, height: height)
    }
    
    func setupCollectionView() {
        collectionView.registerCellWithNib(
            identifier: SitesListImageCollectionViewCell.identifier,
            bundle: nil)
    }
    
    func layoutCell(images: [String]) {
        self.images = images
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
}

extension SitesListImageTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.pressImageCell(self, images, indexPath.row)
        
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
