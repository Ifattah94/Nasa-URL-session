//
//  NetworkHelper.swift
//  URLSession Nasa
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    func performDataTask(with url: URL, completionHandler: (Data) -> Void, errorHandler: (Error) -> Void) {
        
    }
}
