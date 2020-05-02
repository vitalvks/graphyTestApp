//
//  HomeViewModel.swift
//  graphyApp
//
//  Created by Sudhakar on 02/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit

protocol HomeViewProtocol: class {
    func updateUI()
}

class HomeViewModel {
    
    var assetList = [AssetInfoModel]()
    weak var delegate: HomeViewProtocol?
    
    func makeWebServiceCallforGetAssetList() {
        helperUrlSession.makeGetCallfor(url: "https://jsonkeeper.com/b/CENN") { (response, error) in
            do {
                if error == nil {
                    let result = try JSONDecoder().decode(Assetmodel.self, from: response!)
                    self.assetList = result.videos ?? [AssetInfoModel]()
                    self.delegate?.updateUI()
                }
            } catch {
            }
        }
    }
    
    func getAssetListCount() -> Int {
        return assetList.count
    }
    
    func getAssetForIndex(index: Int) -> AssetInfoModel {
        return assetList[index]
    }
}
