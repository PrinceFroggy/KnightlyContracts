//
//  ViewController.swift
//  KnightlyContracts
//
//  Created by Process Fusion on 2022-07-03.
//

import UIKit
import CoreData

class ViewController: UIViewController
{
    @IBOutlet weak var nameUITextField: UITextField!
    @IBOutlet weak var intializeUIButton: UIButton!
    
    var m: DataModelManager?
    
    override func viewDidLoad()
    {        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func Intialize(_ sender: UIButton)
    {
        if (nameUITextField.text != "")
        {
            self.m!.createAccount(name: nameUITextField.text!)
            
            print("Registering account: \(String(describing: self.m!.account!.fullName!))")
            
            self.m!.account!.registerAccountAPI()
            { (result) in
                
                if (result)
                {
                    print("Fetching OTP email")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute:
                    {
                        self.m!.account!.fetchAccountOTPAPI(email: self.m!.account!.email!)
                        { (result) in
                            
                            if (result)
                            {
                                print("Verifying account: \(String(describing: self.m!.account!.fullName!))")
                        
                                self.m!.account!.verifyAccountAPI(otp: self.m!.account!.login!.gmail!.otp!)
                                { (result) in
                                    
                                    if (result)
                                    {
                                        print("Logging into account: \(String(describing: self.m!.account!.fullName!))")
                                
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute:
                                        {
                                            self.m!.account!.loginAccountAPI(email: self.m!.account!.email!, password: self.m!.account!.password!)
                                            { (result) in
                                                
                                                if (result)
                                                {
                                                    print("Logged into: \(String(describing: self.m!.account!.fullName!))")
                                                    
                                                    self.m!.saveAccountCoreData()
                                                    
                                                    self.performSegue(withIdentifier: "login", sender: nil)
                                                }
                                            }
                                        })
                                    }
                                }
                            }
                        }
                    })
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if segue.identifier == "login"
            {
               let vc = segue.destination as! BaseTabBarController
               
               vc.m = self.m
            }
        }
}

