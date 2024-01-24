//
//  Account.swift
//  KnightlyContracts
//
//  Created by Process Fusion on 2022-07-03.
//

import Foundation
import Fuzi
import CoreData

class Account
{
    var fullName: String?
    var email: String?
    var country: String?
    var state: String?
    var city: String?
    var phone: String?
    var companyName: String?
    var password: String?
    var confirm_password: String?
    
    var login: Login?
    
    var token: String?
    
    init(name: String)
    {
        self.fullName = name
        self.email = "globalplazatradebase+\(random(digits: 6))@gmail.com"
        self.country = "\(random(digits: 2))"
        self.state = "\(randomString(length: 2))"
        self.city = "\(randomString(length: 7))"
        self.phone = "\(random(digits: 3)) \(random(digits: 3)) \(random(digits: 4))"
        self.companyName = "\(randomString(length: 1))\(random(digits: 1))\(randomString(length: 1))"
        self.password = "\(randomString(length: 3))\(random(digits: 3))\(randomString(length: 3))"
        self.confirm_password = password
        
        self.login = Login()
    }
    
    init(name: String, email: String, password: String)
    {
        self.fullName = name
        self.email = email
        self.password = password
    }
    
    func registerAccountAPI(completion: @escaping (Bool) -> Void)
    {
        let request = WebRequestAPI()
        
        request.httpMethod = "POST"
        
        let boundaryRandomValue = Date().ticks
        
        var bodyData = Data()
        
        let threadVariables:[String:String] =
            [
                "is_seller":"1",
                "full_name":fullName!,
                "country_id":country!,
                "email":email!,
                "state":state!,
                "city":city!,
                "phone":phone!,
                "company_name":companyName!,
                "password":password!,
                "confirm_password":confirm_password!
            ]
        
        let boundary = "------WebKitFormBoundary\(boundaryRandomValue)"
        let header = "\(boundary)\r\n"
        let footer = "\(boundary)--\r\n"
        
        for (key, value) in threadVariables
        {
            bodyData.append(header.data(using: .utf8)!)
            bodyData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\n".data(using: .utf8)!)
            bodyData.append(value.data(using: .utf8)!)
            bodyData.append("\n".data(using: .utf8)!)
        }
        
        bodyData.append(footer.data(using: .utf8)!)
        
        request.httpBody = bodyData
        
        let headers =
        [
            "Accept-Encoding": "gzip, deflate, br",
            "Connection": "keep-alive",
            "Accept": "application/json, text/javascript, */*; q=0.01",
            "Accept-Language": "en-US,en;q=0.9",
            "Cache-Control": "max-age=0",
            "Origin": "https://globaltradeplaza.com",
            "Referer": "https://globaltradeplaza.com",
            "Host": "admin.globaltradeplaza.com",
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.2 Safari/605.1.15",
            "Content-Type": "multipart/form-data; boundary=----WebKitFormBoundary\(boundaryRandomValue)",
            "Content-Length": String(bodyData.count)
        ]
        
        request.httpHeaders = headers
        
        var requestStatus: Int?
        
        request.sendRequest(toUrlPath: "https://admin.globaltradeplaza.com/public/api/v1/auth/register", completion:
        { (status: Int, result: String, headers: [String : String]) in
            requestStatus = status
            
            if (200...299).contains(requestStatus!)
            {
                completion(true)
            }
            else
            {
                completion(false)
            }
        })
    }
    
    func verifyAccountAPI(otp: String, completion: @escaping (Bool) -> Void)
    {
        let request = WebRequestAPI()
        
        request.httpMethod = "POST"
        
        let boundaryRandomValue = Date().ticks
        
        var bodyData = Data()
        
        let threadVariables:[String:String] =
            [
                "otp":otp,
                "email":email!
            ]
        
        let boundary = "------WebKitFormBoundary\(boundaryRandomValue)"
        let header = "\(boundary)\r\n"
        let footer = "\(boundary)--\r\n"
        
        for (key, value) in threadVariables
        {
            bodyData.append(header.data(using: .utf8)!)
            bodyData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\n".data(using: .utf8)!)
            bodyData.append(value.data(using: .utf8)!)
            bodyData.append("\n".data(using: .utf8)!)
        }
        
        bodyData.append(footer.data(using: .utf8)!)
        
        request.httpBody = bodyData
        
        let headers =
        [
            "Accept-Encoding": "gzip, deflate, br",
            "Connection": "keep-alive",
            "Accept": "application/json, text/javascript, */*; q=0.01",
            "Accept-Language": "en-US,en;q=0.9",
            "Cache-Control": "max-age=0",
            "Origin": "https://globaltradeplaza.com",
            "Referer": "https://globaltradeplaza.com/",
            "Host": "admin.globaltradeplaza.com",
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.2 Safari/605.1.15",
            "Content-Type": "multipart/form-data; boundary=----WebKitFormBoundary\(boundaryRandomValue)",
            "Content-Length": String(bodyData.count)
        ]
        
        request.httpHeaders = headers
        
        var requestStatus: Int?
        
        request.sendRequest(toUrlPath: "https://admin.globaltradeplaza.com/public/api/v1/auth/verification", completion:
        { (status: Int, result: String, headers: [String : String]) in
            requestStatus = status
            
            if (200...299).contains(requestStatus!)
            {
                completion(true)
            }
            else
            {
                completion(false)
            }
        })
    }
    
    func loginAccountAPI(email: String, password: String, completion: @escaping (Bool) -> Void)
    {
        let request = WebRequestAPI()
        
        request.httpMethod = "POST"
        
        let boundaryRandomValue = Date().ticks
        
        var bodyData = Data()
        
        let threadVariables:[String:String] =
            [
                "email":email,
                "password": password
            ]
        
        let boundary = "------WebKitFormBoundary\(boundaryRandomValue)"
        let header = "\(boundary)\r\n"
        let footer = "\(boundary)--\r\n"
        
        for (key, value) in threadVariables
        {
            bodyData.append(header.data(using: .utf8)!)
            bodyData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\n".data(using: .utf8)!)
            bodyData.append(value.data(using: .utf8)!)
            bodyData.append("\n".data(using: .utf8)!)
        }
        
        bodyData.append(footer.data(using: .utf8)!)
        
        request.httpBody = bodyData
        
        let headers =
        [
            "Accept-Encoding": "gzip, deflate, br",
            "Connection": "keep-alive",
            "Accept": "application/json, text/javascript, */*; q=0.01",
            "Accept-Language": "en-US,en;q=0.9",
            "Cache-Control": "max-age=0",
            "Origin": "https://globaltradeplaza.com",
            "Referer": "https://globaltradeplaza.com/login",
            "Host": "admin.globaltradeplaza.com",
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.2 Safari/605.1.15",
            "Content-Type": "multipart/form-data; boundary=----WebKitFormBoundary\(boundaryRandomValue)",
            "Content-Length": String(bodyData.count)
        ]
        
        request.httpHeaders = headers
        
        var requestStatus: Int?
        
        request.sendRequest(toUrlPath: "https://admin.globaltradeplaza.com/public/api/v1/auth/login", completion:
        { (status: Int, result: String, headers: [String : String]) in
            requestStatus = status
            
            if (200...299).contains(requestStatus!)
            {
                do
                {
                    let data = result.data(using: .utf8)!

                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                    
                    let jsonP = jsonResult?["response"] as! [String:Any]
                    
                    self.token = jsonP["token"] as! String
                }
                catch
                {
                    
                }
                
                completion(true)
            }
            else
            {
                completion(false)
            }
        })
    }
    
    func fetchAccountOTPAPI(email: String, completion: @escaping (Bool) -> Void)
    {
        self.login!.executeEmailFetch(email: email)
        { (result) in
            completion(result)
        }
    }
}

class Login
{
    var gmail: Email?
    
    init()
    {
        self.gmail = Email()
    }
    
    func executeEmailFetch(email: String, completion: @escaping (Bool) -> Void)
    {
        self.gmail!.executeFetchEmail(email: email)
        { (result) in
            completion(result)
        }
    }
}

class Email
{
    var otp: String?
    
    init()
    {
        
    }
    
    func executeFetchEmail(email: String, completion: @escaping (Bool) -> Void)
    {
        let session = MCOIMAPSession()
          
        session.hostname       = "imap.gmail.com"
        session.port           = 993
        session.username       = email
        session.password       = "plzbjqjxhqemwndm"
        session.connectionType = .TLS
          
        let folder = "INBOX"
          
        let search = MCOIMAPSearchExpression.search(to: email)
        
        if let fetchOperation = session.searchExpressionOperation(withFolder: folder, expression: search)
        {
            fetchOperation.start
            { error, messageIds in
                
                if let err = error
                {
                    print("Error searching IMAP: \(err)")
                    completion(false)
                }
                
                if let messageId = messageIds
                {
                    if let messageOp = session.fetchMessagesOperation(withFolder: folder, requestKind: .headers, uids: messageId)
                    {
                        messageOp.extraHeaders = [ "Delivered-To" ]

                        messageOp.start
                        { error, messages, _ in
                            if let error = error
                            {
                                print("Error fetching messages: \(error)")
                                completion(false)
                            }

                            if let message = messages
                            {
                                let operation: MCOIMAPFetchContentOperation = session.fetchMessageByUIDOperation(withFolder: folder, uid: ((message.first as Any) as! MCOIMAPMessage).uid)

                                operation.start
                                { (error, data) in
                                    
                                    let messageParser: MCOMessageParser = MCOMessageParser(data: data)
                                    let msgHTMLBody: NSString = messageParser.htmlBodyRendering() as NSString
                                    let htmlText = msgHTMLBody as! String
                                                
                                    if let doc = try? HTMLDocument(string: htmlText, encoding: String.Encoding.utf8)
                                    {
                                        let rawOTP = doc.css("h4")[1].stringValue
                                        
                                        self.otp = String(rawOTP.filter { !" \n".contains($0) })
                                        
                                        completion(true)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
