//
//  Assetmodel.swift
//  graphyApp
//
//  Created by Sudhakar on 02/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit

struct Assetmodel: Codable {
    let videos: [AssetInfoModel]?
}

struct AssetInfoModel: Codable {
    let assetId: Int?
    let assetTitle: String?
    let assetDescription: String?
    let assetVideoUrl: String?
    let assetImageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case assetId = "id"
        case assetTitle = "title"
        case assetDescription = "description"
        case assetVideoUrl = "video"
        case assetImageUrl = "image"
    }
}
