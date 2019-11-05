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
    
    lazy var sectionContent: [TouristSitesListContentCategory] =
        [.title, .description, .imageCollectionView(vc: self)]
    
    var totalToristSitesNum = 0 // server 上資料筆數
    
    var touristSitesProvider: APIManagerProtocol = APIManager.shared
    
//    lazy var changeUIByStatus: ((_:RootViewControllerStatus) -> Void) = changeUI
    
    var status: RootViewControllerStatus = .normal {
        didSet{
//            changeUIByStatus(status)
            changeUI(status)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "台北市熱門景點"
                
        setupTableView()
        
        fetchTouristSites()
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
    
    func fetchTouristSites() {
        if touristSitesProvider.isNetworkConnect && status != .loading {
            
            status = .loading
            
            touristSitesProvider.fetchTouristSite(limit: 10, offset: self.touristSites.count) {[weak self] result in

                switch result {
                    
                case .success(let touristSite):
                    
                    
                    self?.totalToristSitesNum = touristSite.count
                    
                    if touristSite.results.count == 0 {
                        self?.status = .empty
                        
                    } else {
                        self?.status = .normal
                        self?.touristSites += touristSite.results
                    }
                    
                case .failure(let error):
                    self?.status = .error
                    print(error)
                }
            }
            
        } else {
             status = .noNetWork
        }
    }
    
    func changeUI(_ status: RootViewControllerStatus) {
        
        switch status {
            
        case .noNetWork:
            
            if touristSites.count > 0 {
                view.acMakeToast("沒有網路連線，請檢查網路", duration: 3.0, position: .center)
            } else {
                noNetWorkAlertLayer.isHidden = false
            }
            tableView.endFooterRefreshing()
            
        case .loading:
            noNetWorkAlertLayer.isHidden = true
            
        case .getResult:
            tableView.endFooterRefreshing()
            
        case .error:
            view.acMakeToast("請求資料發生問題", duration: 3.0, position: .center)
                           
        default:
            return
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
        
        let tsContent = sectionContent[indexPath.row]
        
        let cell = tsContent.cellForIndexPath(
            indexPath,
            tableView: tableView,
            data: touristSites[indexPath.section]
        )
        
        return cell
    }
    
}

extension RootViewController: SitesListImageCellDelegate {
    
    func pressImageCell(_ cell: UITableViewCell, _ images: [String], _ imageIndex: Int) {
        
        guard
            let indexPath = tableView.indexPath(for: cell)
        else {
            return
        }
        
        let touristSitesDetail = touristSites[indexPath.section]
        
        navigationToDetailPage(
            tourist: touristSitesDetail,
            images: images,
            imageIndex: imageIndex
        )
    }
    
}

enum RootViewControllerStatus {
    case error
    case normal
    case getResult
    case loading
    case empty
    case noNetWork
}
