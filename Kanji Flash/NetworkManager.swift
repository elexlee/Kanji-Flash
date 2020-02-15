//
//  NetworkManager.swift
//  Kanji Flash
//
//  Created by Elex Lee on 2/13/20.
//  Copyright © 2020 Elex Lee. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private static var sharedNetworkManager: NetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
        
    private init() {
    }
    
    class func shared() -> NetworkManager {
        return sharedNetworkManager
    }
    
    
}
