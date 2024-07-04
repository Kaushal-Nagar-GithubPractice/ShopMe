//
//  DatabaseManager.swift
//  ShopMe-Github-Collab
//
//  Created by Webcodegenie on 04/07/24.
//

import Foundation
import CoreData
var persistentContainer: NSPersistentContainer = {
 
   let container = NSPersistentContainer(name: "CoreData_API_InternetConnectivity")
   container.loadPersistentStores(completionHandler: { (storeDescription, error) in
       if let error = error as NSError? {
       
           fatalError("Unresolved error \(error), \(error.userInfo)")
       }
   })
   return container
}()
class DatabaseManager {
    let context = persistentContainer.viewContext
    static let shared : DatabaseManager = DatabaseManager()

    func fetchDetails () -> [UserData] {
       var arrUserDetails = [UserData]()
        let request = NSFetchRequest<NSManagedObject>(entityName: "UserData")
        do{
           
            arrUserDetails =   try context.fetch(request) as! [UserData]
        }
        catch{
            print("not able to fecth")
        }
         
        return arrUserDetails
    }
    func insertDetails (dict : [String: Any])  {
        
        let userStruct = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context) as! UserData
        userStruct.email = dict["email"] as? String
        userStruct.gender = dict["gender"] as? String
        userStruct.name = dict["name"] as? String
        userStruct.status = dict["status"] as? String
        userStruct.id = Int64((dict["id"]) as? Int ?? 0)
        
        do{
            try context.save()
        }
        catch{
            print("not inserted")
        }
    }
    func deleteAll(){
        var emp = fetchDetails()
        for i in 0 ..< emp.count  {
            context.delete(emp[i])
        }
        do{
            try context.save()
        }
        catch{
            print("error")
        }
        
    }
    func update (dict : [String: Any], Index : Int){
        var updateArr = fetchDetails()
        updateArr[Index].name = dict["name"] as? String
        updateArr[Index].status = dict["status"] as? String
        updateArr[Index].gender = dict["gender"] as? String
        updateArr[Index].email = dict["email"] as? String
        updateArr[Index].id = Int64(dict["id"] as? Int ?? 0)
        do {
            try context.save()
        }catch{
            print("Not updated")
        }
    }

}
