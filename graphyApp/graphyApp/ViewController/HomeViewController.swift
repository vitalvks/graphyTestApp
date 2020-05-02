//
//  HomeViewController.swift
//  graphyApp
//
//  Created by Sudhakar on 02/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    let homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        homeViewModel.delegate = self
        self.loadingView.isHidden = false
        homeViewModel.makeWebServiceCallforGetAssetList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeViewModel.getAssetListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssetCell", for: indexPath) as? AssetCell
        cell?.configureCellUsingModel(model: homeViewModel.getAssetForIndex(index: indexPath.section))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController
        let selectedMdl = homeViewModel.getAssetForIndex(index: indexPath.section)
        vc?.selectedVideoUrl = selectedMdl.assetVideoUrl
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let view = cell.contentView
        view.layer.transform = TipInCellAnimatorStartTransform
        view.layer.opacity = 0.8
        UIView.animate(withDuration: 0.5) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    let TipInCellAnimatorStartTransform: CATransform3D = {
        let rotationDegrees: CGFloat = -15.0
        let rotationRadians: CGFloat = rotationDegrees * (CGFloat(Double.pi)/180.0)
        let offset = CGPoint(x: -20, y: -20)
        var startTransform = CATransform3DIdentity
        startTransform = CATransform3DRotate(CATransform3DIdentity,
                                             rotationRadians, 0.0, 0.0, 1.0)
        startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0)
        
        return startTransform
    }()

}
