//
//  DataModelManager.swift
//  KnightlyContracts
//
//  Created by Process Fusion on 2022-07-14.
//

import CoreData

class DataModelManager
{
    private var cdStack: CDStack!
    
    var ds_context: NSManagedObjectContext!
    var ds_model: NSManagedObjectModel!
    
    var account: Account?
    
    init()
    {
        cdStack = CDStack(model: self)
        ds_context = CDStack.context
        ds_model = CDStack.persistentContainer.managedObjectModel
    }
    
    func createAccount(name: String)
    {
        self.account = Account(name: name)
    }
    
    func createAccount(name: String, email: String, password: String)
    {
        self.account = Account(name: name, email: email, password: password)
    }
    
    func saveAccountCoreData()
    {
        let entity = NSEntityDescription.entity(forEntityName: "AccountInformation", in: CDStack.context)
        
        let aiEntity = NSManagedObject(entity: entity!, insertInto: CDStack.context)
                
        do
        {
            aiEntity.setValue(self.account!.email!, forKey: "email")
            aiEntity.setValue(self.account!.fullName!, forKey: "name")
            aiEntity.setValue(self.account!.password!, forKey: "password")
        
            CDStack.save()
        }
        catch
        {
            
        }
    }
    
    func ds_save()
    {
        CDStack.save()
    }
    
}
