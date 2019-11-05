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
    
    var detailContent: [TouristSitesContentCategory] = [.description, .name, .address, .time, .traffic]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        imageGallery.setupGallery(imageURLs: imageSet, index: currentImageIndex)
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
    
    func navigationWithMapApp() {
        guard let latitudeString = sitesData?.latitude,
            let latitude = Double(latitudeString),
            let longitudeString = sitesData?.longitude,
            let longitude = Double(longitudeString)
        else {
            return
        }
        
        if let url =
            URL(string: MapNavigation.google(
                latitude: latitude,
                longitude: longitude).url),
            UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        // 跳轉至 apple map
        } else if let url =
            URL(string: MapNavigation.apple(
                latitude: latitude,
                longitude: longitude).url),
            UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }
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
            let sitesData = sitesData
        else {
            return UITableViewCell()
        }
        
        let cell = detailContent[indexPath.row].cellForIndexPath(indexPath,
                                                                 tableView: tableView,
                                                                 data: sitesData)
        
        return cell
    }
    
}

extension DetailViewController :DetailStringTVCDelegate {
    func pressRightButton(_ cell: DetailStringTableViewCell) {
        navigationWithMapApp()
    }
}

enum MapNavigation {
    case google(latitude: Double, longitude: Double)
    case apple(latitude: Double, longitude: Double)
    
    var url: String {
        switch self {
        case .google(let latitude, let longitude):
            return "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving"
            
        case .apple(let latitude, let longitude):
            return "http://maps.apple.com/?saddr=&daddr=\(latitude),\(longitude)"
        }
    }
}

