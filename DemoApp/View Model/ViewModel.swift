//
//  ViewModel.swift
//  DemoApp
//
//  Created by Selma Dsouza (Digital) on 26/11/19.
//  Copyright © 2019 Santanu Koley(Digital). All rights reserved.
//

import Foundation
import UIKit
import  Alamofire
typealias dataDownLoadCompletionClosure = (_ listData:Json4Swift_Base) ->Void
public typealias ImageDownloadCompletionClosure = (_ imageData: NSData ) -> Void

typealias DownloadComplete = () -> ()

class ListViewModel {
     var title: String = ""
     var rows: [Rows] = []
    
    func getRequestAPICall(completionHanlder: @escaping dataDownLoadCompletionClosure) {
       /* let todosEndpoint: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        Alamofire.request(todosEndpoint).responseJSON { (response:DataResponse<Any>) in
            
            guard let responseData = response.data else {
                print(response.result.error!)
                return
            }
            let decoder = JSONDecoder()
            let responseStrInISOLatin = String(data: response.data!, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                print("could not convert data to UTF-8 format")
                return
            }
            do {
                let results = try decoder.decode(Json4Swift_Base.self, from: modifiedDataInUTF8Format)
                self.title = results.title!
                
//                for (index,name) in results.rows.enumerated() {
//                    print(name)
//                    if name.description == nil && name.imageHref == nil && name.title == nil {
//                        results.rows.remove(at: index)
//                    }
//                }
                self.rows = results.rows
                completionHanlder(results)
            } catch {
                print(error)
            }
        }
        */
        
         let url = URL(string:"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
         let task = URLSession.shared.dataTask(with: url!) { (data, response, err) in
         let decoder = JSONDecoder()
         let responseStrInISOLatin = String(data: data!, encoding: String.Encoding.isoLatin1)
         guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
         print("could not convert data to UTF-8 format")
         return
         }
         do {
         let results = try decoder.decode(Json4Swift_Base.self, from: modifiedDataInUTF8Format)
            self.title = results.title!
            self.rows = results.rows
            completionHanlder(results)
         } catch {
            print(error)
         }
         }
         task.resume()
    }
    
    func downloadForecastWeather(completion: @escaping (Json4Swift_Base?) -> Void) {
        /*
        let url = URL(string:"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, err) in
            let decoder = JSONDecoder()
                let responseStrInISOLatin = String(data: data!, encoding: String.Encoding.isoLatin1)
                guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                    print("could not convert data to UTF-8 format")
                    return
                }
                do {
                    let results = try decoder.decode(Json4Swift_Base.self, from: modifiedDataInUTF8Format)
                    completion(results)
                } catch {
                    print(error)
                    }
                }
            task.resume()
        } */
    }
    
    func download(imgurl: String, completionHanlder: @escaping ImageDownloadCompletionClosure)
    {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url: URL(string: imgurl)!)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    let rawImageData = NSData(contentsOf: tempLocalUrl)
                    completionHanlder(rawImageData!)
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
            } else {
                print("Error took place while downloading a file. Error description: \(String(describing: error?.localizedDescription))")
            }
        } // end let task
        
        task.resume()
        
    } // end func download
    
    func downloadImg(imgurl: String, completionHanlder: @escaping ImageDownloadCompletionClosure)
    {
        Alamofire.request(imgurl).responseData { response in
            completionHanlder(response.data! as NSData)
        }
        
    } // end func download

}
