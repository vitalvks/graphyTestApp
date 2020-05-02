//
//  helperUrlSession.swift
//  webServiceHelper
//
//  Created by Sudhakar on 02/05/20.
//  Copyright © 2018 Sudhakar. All rights reserved.
//
import UIKit

struct helperUrlSession {
        
    static func makeGetCallfor(url: String, completionHandler: @escaping (_ result: Data?, _ error: Error?) -> Void){
        let urlToHit = URL(string: url)
        let task = URLSession.shared.dataTask(with: urlToHit!, completionHandler: {data, response, error -> Void in
            completionHandler(data, error)
        })
        task.resume()
    }
}
