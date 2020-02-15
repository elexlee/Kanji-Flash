//
//  APIManager.swift
//  Kanji Flash
//
//  Created by Elex Lee on 2/13/20.
//  Copyright © 2020 Elex Lee. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIManager {
    
    static let shared = APIManager()
    static let token = "27e9ea55-ca3e-494d-acec-0a542348f33c"
    static let baseURL = "https://api.wanikani.com/v2"
    static let getSubjectsEndpoint = "/subjects"

    func getKanji(kanji: [String],
                  onSuccess: @escaping(JSON) -> Void,
                  onFailure: @escaping(Error) -> Void) {
        
        var kanjiStringList = ""
        for (i, k) in kanji.enumerated() {
            kanjiStringList += k
            if i != kanji.count - 1 {
                kanjiStringList += ","
            }
        }
        
        let urlString = APIManager.baseURL + APIManager.getSubjectsEndpoint + "?types=kanji&slugs=" + kanjiStringList
        guard let nsurl = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }
        let request: NSMutableURLRequest = NSMutableURLRequest(url: nsurl as URL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization":"Bearer " + APIManager.token]
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do {
                    let result = try JSON(data: data!)
                    onSuccess(result)
                }
                catch {
                    fatalError("unable to convert data to JSON")
                }
            }
        })
        task.resume()
    }
}
