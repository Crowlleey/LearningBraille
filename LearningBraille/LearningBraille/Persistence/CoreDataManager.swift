//
//  CoreDataManager.swift
//  LearningBraille
//
//  Created by George Gomes on 23/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import CoreData
import UIKit

enum ManagedType: String {
    case user = "User"
}

enum RequestType: String{
    case name = "name"
}

private let cDInstance = CoreDataManager()

protocol CDManagerProtocol{
    func saveThis<T: NSManagedObject>(_ obj: T,_ managedType: ManagedType, completionHandler: @escaping(Error?) -> Void)
}

class CoreDataManager: CDManagerProtocol{
    
    public class func managerInstance() -> CoreDataManager{
        return cDInstance
    }
    
    func saveThis<T: NSManagedObject>(_ obj: T,_ managedType: ManagedType, completionHandler: @escaping(Error?) -> Void){
        
        let context = getContext()
        
        
        do {
            try context.save()
            
            completionHandler(nil)
        } catch let err {
            print("Fatal ERROR")
            completionHandler(err)
        }
    }
    
    func deleteThis<T>(_ obj: T, completionHandler: @escaping(Error) -> Void){
        
    }
    
    func fetchAll<T>(_ objectType: T, completionHandler: @escaping([T], Error?) -> Void) where T:NSManagedObject {
        let context = getContext()
        
        var fetchedResult: NSFetchedResultsController<T>!
        let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T> //Person.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResult = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResult.delegate = UIViewController() as? NSFetchedResultsControllerDelegate
        
        do {
            try fetchedResult.performFetch()
            completionHandler(fetchedResult.fetchedObjects ?? [], nil)
        } catch let err {
            print(err)
            completionHandler([],err)
        }
    }
    
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func Object<T>() -> T where T: NSManagedObject{
        return T(context: getContext())
    }
}


