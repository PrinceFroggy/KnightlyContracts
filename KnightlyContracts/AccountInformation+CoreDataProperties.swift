//
//  AccountInformation+CoreDataProperties.swift
//  KnightlyContracts
//
//  Created by Process Fusion on 2022-07-15.
//


import Foundation
import CoreData


extension AccountInformation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountInformation> {
        return NSFetchRequest<AccountInformation>(entityName: "AccountInformation")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?

}
