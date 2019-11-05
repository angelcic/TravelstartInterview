//
//  ViewController.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/10/30.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit
import Network

class RootViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var noNetWorkAlertLayer: UIView!
    
    var touristSites: [TouristSitesDetail] = [] {
        didSet {
            if touristSites.count >= totalToristSitesNum {
                tableView.endWithNoMoreData()
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var totalToristSitesNum = 0 // server 上資料筆數
    
    var touristSitesProvider: APIManagerProtocol = APIManager.shared
    
    var status: RootViewControllerStatus = .normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "台北市熱門景點"
                
        setupTableView()
        
        fetchTouristSites()
        
//        fetchTouristSites(limit: 10, offset: 170)
    }

    func setupTableView() {
        tableView.registerCellWithNib(
            identifier: SitesListTitleTableViewCell.identifier,
            bundle: nil)
        
        tableView.registerCellWithNib(
            identifier: SitesListDescriptionTableViewCell.identifier,
            bundle: nil)
        
        tableView.registerCellWithNib(
            identifier: SitesListImageTableViewCell.identifier,
            bundle: nil)
        
        tableView.addRefreshFooter() { [weak self] in
            self?.fetchTouristSites()
        }
    }
    
    func fetchTouristSites(limit: Int, offset: Int) {
        APIManager.shared.fetchTouristSite(limit: limit, offset: offset) { result in
            switch result {
            case .success(let touristSite):
                self.touristSites += touristSite.results
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTouristSites() {
        if touristSitesProvider.isNetworkConnect && status != .loading {
            noNetWorkAlertLayer.isHidden = true
            
            status = .loading
            
            touristSitesProvider.fetchTouristSite(limit: 10, offset: self.touristSites.count) {[weak self] result in
                
                switch result {
                    
                case .success(let touristSite):
                    self?.tableView.endFooterRefreshing()
                    
                    
                    self?.totalToristSitesNum = touristSite.count
                    if touristSite.results.count == 0 {
                        self?.status = .empty
                    } else {
                        self?.status = .normal
                        self?.touristSites += touristSite.results
                    }
                    
                case .failure(let error):
                    self?.status = .error
                    DispatchQueue.main.async {
                        self?.view.acMakeToast("請求資料發生問題", duration: 3.0, position: .center)
                    }
                    print(error)
                }
            }
            
        } else {
            if touristSites.count > 0 {
                self.view.acMakeToast("沒有網路連線，請檢查網路", duration: 3.0, position: .center)
            } else {
                noNetWorkAlertLayer.isHidden = false
            }
            tableView.endFooterRefreshing()
        }
    }

    func navigationToDetailPage(tourist: TouristSitesDetail, images: [String], imageIndex: Int) {
        guard
            let detailVC = UIStoryboard.main.instantiateViewController(
                withIdentifier: DetailViewController.identifier
                )
                as? DetailViewController
        else {
            return
        }
        
        detailVC.initDetailVC(sitesData: tourist,
                              imageSet: images,
                              imageIndex: imageIndex)
        
        show(detailVC, sender: nil)
    }
    
    @IBAction func pressRetryFetchTouristSites() {
        fetchTouristSites()
    }
    
}

extension RootViewController: UITableViewDelegate {
    
}

extension RootViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return touristSites.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: SitesListTitleTableViewCell.identifier,
                    for: indexPath)
                    as? SitesListTitleTableViewCell
            else {
                return UITableViewCell()
            }
            
            cell.layoutCell(title: touristSites[indexPath.section].stitle)
            
            return cell

        case 1:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: SitesListDescriptionTableViewCell.identifier,
                    for: indexPath)
                    as? SitesListDescriptionTableViewCell
            else {
                return UITableViewCell()
            }
            
            cell.layoutCell(description: touristSites[indexPath.section].xbody)
            
            return cell

        case 2:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: SitesListImageTableViewCell.identifier,
                    for: indexPath)
                    as? SitesListImageTableViewCell
            else {
                return UITableViewCell()
            }
                        
            cell.delegate = self
            cell.layoutCell(images: touristSites[indexPath.section].images)
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
}

extension RootViewController: SitesListImageCellDelegate {
    
    func pressImageCell(_ cell: UITableViewCell, _ images: [String], _ imageIndex: Int) {
        guard
            let indexPath = tableView.indexPath(for: cell)
        else { return }
        
        let touristSitesDetail = touristSites[indexPath.section]
        
        navigationToDetailPage(tourist: touristSitesDetail,
                               images: images,
                               imageIndex: imageIndex)
    }
    
}

enum RootViewControllerStatus {
    case error
    case normal
    case loading
    case empty
}
