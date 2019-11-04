//
//  DetailViewController.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
//    @IBOutlet weak var imageGallery: UIStackView!
    @IBOutlet weak var imageGallery: TSGalleryView!
    
    var currentImageIndex = 0
    
    var imageSet: [String] = [] {
        didSet {
            guard let imageGallery = imageGallery else {
                return
            }
            imageGallery.datas = imageSet
        }
    }
    
    var sitesData: TouristSitesDetail?
    
    var detailContent: [DetailContent] {
        
        guard let sitesData = sitesData else { return [] }
        
        return [
            DetailContent(subtitle: "景點名稱", contentText: sitesData.stitle),
            DetailContent(subtitle: "景點介紹", contentText: sitesData.xbody),
            DetailContent(subtitle: "地址", contentText: sitesData.address),
            DetailContent(subtitle: "開放時間", contentText: sitesData.memoTime),
            DetailContent(subtitle: "交通資訊", contentText: sitesData.info)
//            DetailContent(subtitle: "鄰近捷運", contentText: sitesData.stitle),
//            DetailContent(subtitle: "地圖", contentText: sitesData.stitle)
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        imageGallery.datas = imageSet
    }
    
    func initDetailVC(sitesData: TouristSitesDetail,
                      imageSet: [String],
                      imageIndex: Int) {
        
        self.sitesData = sitesData
        self.imageSet = imageSet
        self.currentImageIndex = imageIndex
        
        self.navigationItem.title = sitesData.stitle
    }
    
    func setupTableView() {
        tableView.registerCellWithNib(identifier: DetailStringTableViewCell.identifier, bundle: nil)
    }
    
}

extension DetailViewController: UITableViewDelegate {
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: DetailStringTableViewCell.identifier,
                for: indexPath)
            as? DetailStringTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.layoutCell(title: detailContent[indexPath.row].subtitle,
                        text: detailContent[indexPath.row].contentText)
        
        return cell
    }
    
    
}
