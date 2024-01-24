//
//  AppDelegate.swift
//  KnightlyContracts
//
//  Created by Process Fusion on 2022-07-03.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var m: DataModelManager?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        fetchAccountInformationBeforeView()
        return true
    }

    private func fetchAccountInformationBeforeView()
    {
        m = DataModelManager()
        
        let aiFetchRequest: NSFetchRequest<AccountInformation> = AccountInformation.fetchRequest()
                
        do
        {
            let aiEntity = try? CDStack.context.fetch(aiFetchRequest)
            
            if let aiValue = aiEntity?.last
            {
                
                print("Logging into: \(String(describing: aiValue.name!))")
                
                self.m!.createAccount(name: aiValue.name!, email: aiValue.email!, password: aiValue.password!)
                
                self.m!.account!.loginAccountAPI(email: self.m!.account!.email!, password: self.m!.account!.password!)
                { (result) in
                    
                    if (result)
                    {
                        print("Logged into: \(String(describing: self.m!.account!.fullName!))")
                        
                        self.initiateViewController(condition: true, m: self.m!)
                    }
                }
            }
            else
            {
                self.initiateViewController(condition: false, m: self.m!)
            }
        }
        catch
        {
            
        }
    }
    
    private func initiateViewController(condition: Bool, m: DataModelManager)
    {
        var initialViewController: UIViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        window = UIWindow()
        
        if (condition)
        {
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "BaseTabBarController") as! BaseTabBarController
            mainViewController.m = m
            initialViewController = mainViewController
        }
        else
        {
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            loginViewController.m = m
            initialViewController = loginViewController
        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "KnightlyContracts")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

