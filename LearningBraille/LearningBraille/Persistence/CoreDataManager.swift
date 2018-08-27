//
//  CoreDataManager.swift
//  LearningBraille
//
//  Created by George Gomes on 23/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import CoreData
import UIKit
import RxSwift
import RxCocoa

public typealias closure = ((Error) -> (Void))?

enum ManagedType: String {
    case user = "User"
}

enum RequestType: String{
    case name = "name"
}

private let cDInstance = CoreDataManager()

protocol CDManagerProtocol{
//    func saveThis<T: NSManagedObject>(_ obj: T, completionHandler: @escaping(Error?) -> Void)
}

class CoreDataManager: CDManagerProtocol{
    
    public class func managerInstance() -> CoreDataManager{
        return cDInstance
    }

    func saveThis<T: NSManagedObject>(_ obj: T, completionHandler: ((Error?) -> Void)? = nil){
        
        let context = getContext()
        
        do {
            try context.save()
            if let completion = completionHandler{ completion(nil) }
        } catch let err {
            print("Fatal ERROR")
            if let completion = completionHandler{ completion(err) }
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
    
    func isRegistered() -> Observable<([User], Error?)> {
        let context = getContext()
        
        return Observable<([User], Error?)>.create{ observer in
            
            let fetchedRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchedRequest.returnsObjectsAsFaults = false
            let sortDescriptor = NSSortDescriptor(key: "email", ascending: true)
            fetchedRequest.sortDescriptors = [sortDescriptor]
            
            let fetchedResult: NSFetchedResultsController<User> = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResult.delegate = UIViewController() as? NSFetchedResultsControllerDelegate
            
            do {
                try fetchedResult.performFetch()
                let toReturn = fetchedResult.fetchedObjects
                
                if toReturn?.count == 0{
                    let erro = CoreDataError(title: "nil user", description: "have no user in database", code: 666)
                    observer.onError(erro)
                }else{
                    observer.onNext((toReturn!, nil))
                    observer.onCompleted()
                }
    
            } catch let err{
                observer.onError(err)
            }
            return Disposables.create()
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

protocol CDError: LocalizedError {
    
    var title: String? { get }
    var code: Int { get }
}

struct CoreDataError: CDError {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}

