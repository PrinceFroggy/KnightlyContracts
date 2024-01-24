//
//  WebRequestAPI.swift
//  KnightlyContracts
//
//  Created by Process Fusion on 2022-07-05.
//

import Foundation

class WebRequestAPI
{
    var urlBase = ""
    
    var httpMethod = ""
    var httpHeaders: [String: String]?
    var httpBody: Data?
    
    func sendRequest(toUrlPath urlPath: String, completion: @escaping (Int, String, [String : String])->Void)
    {
        let encodedUrlPath = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url = URL(string: "\(urlBase)\(encodedUrlPath!)") else
        {
            return
        }
        
        let config = URLSessionConfiguration.default
        
        /*
        config.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        config.connectionProxyDictionary = [AnyHashable: Any]()
        config.connectionProxyDictionary?[kCFNetworkProxiesHTTPEnable as String] = 1
        config.connectionProxyDictionary?[kCFNetworkProxiesHTTPProxy as String] = "176.116.230.151"
        config.connectionProxyDictionary?[kCFNetworkProxiesHTTPPort as String] = 7237
        config.connectionProxyDictionary?[kCFStreamPropertyHTTPSProxyHost as String] = "176.116.230.151"
        config.connectionProxyDictionary?[kCFStreamPropertyHTTPSProxyPort as String] = 7237
        */
        
        //var username = "rmvfnxcg"
        //var password = "orbbu6w4eam0"
        
        //config.connectionProxyDictionary?[kCFProxyUsernameKey as String] = username
        //config.connectionProxyDictionary?[kCFProxyPasswordKey as String] = password
        
        /*
        let authenticationString = "\(username):\(password)"
        let authenticationData = authenticationString.data(using: .utf8)
        var authenticationValue = authenticationData?.base64EncodedString()
        authenticationValue = "Basic " + (authenticationValue ?? "")
        */
        
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.httpBody = httpBody
        request.allHTTPHeaderFields = httpHeaders
        
        //request.setValue(authenticationValue, forHTTPHeaderField: "Proxy-Authorization")
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler:
        { (data, response, error) in
            
            if let error = error
            {
                return
            }
            
            let r = response as! HTTPURLResponse
            
            if (100...199).contains(r.statusCode)
            {
                let results = "Response was interim or informational"

                completion(r.statusCode, results, ["":""])
            }
            
            if let data = data, (200...299).contains(r.statusCode)
            {
                let sortableHeaders = r.allHeaderFields as! [String: String]
                
                var results = ""

                do
                {
                    results = String(data: data, encoding: .utf8)!
                }
                catch
                {
                    return
                }
                
                completion(r.statusCode, results, sortableHeaders)
            }
            
            if (300...399).contains(r.statusCode)
            {
                let results = "HTTP \(r.statusCode) - Request was redirected"

                completion(r.statusCode, results, ["":""])
            }
            
            if (400...499).contains(r.statusCode)
            {
                let results = "HTTP \(r.statusCode) - The request caused an error"

                completion(r.statusCode, results, ["":""])
            }
        
            if (500...599).contains(r.statusCode)
            {
                let results = "HTTP \(r.statusCode) - An error on the server happened"

                completion(r.statusCode, results, ["":""])
            }
        })
        
        task.resume()
        
    }
}
