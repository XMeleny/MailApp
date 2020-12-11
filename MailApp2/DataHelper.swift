//
//  DataHelper.swift
//  MailApp2
//
//  Created by gtk on 2020/12/11.
//

import Foundation
import UIKit
import CoreData

let CORE_DATA_ENTITY_EMAIL_RECEIVER = "EmailReceiver"
let CORE_DATA_KEY_EMAIL_ID = "id"
let CORE_DATA_KEY_EMAIL_RECEIVER = "receiver"

let FILE_NAME_EMAIL_SUBJECT = "email_subject"

func getManagedObjectContext()->NSManagedObjectContext{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
}

func getEmails(){
    
}

func getEmailReceivers(callback:EmailReceiverCallback){
    let managedObjectContext = getManagedObjectContext()
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CORE_DATA_ENTITY_EMAIL_RECEIVER)
    do {
        let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let result = fetchedResults {
            callback.onEmailReceiverResult(result)
        }
    } catch  {
        fatalError("获取失败")
    }
}

func getEmailSubjects(emailSubjectCallback:EmailSubjectCallback){
    
}


func saveEmail(receiver:String, subject:String){
    let newId = getNewId()
    
    //save receiver in core data
    let managedObjectContext = getManagedObjectContext()
    
    let entity = NSEntityDescription.entity(forEntityName: CORE_DATA_ENTITY_EMAIL_RECEIVER, in: managedObjectContext)
    
    let emailReceiver = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
    
    emailReceiver.setValue(newId, forKey: CORE_DATA_KEY_EMAIL_ID)
    emailReceiver.setValue(receiver, forKey: CORE_DATA_KEY_EMAIL_RECEIVER)
    
    do{
        try managedObjectContext.save()
    }catch{
        fatalError("save error")
    }
    
    //save subject in file
    
}

func getNewId()-> Int{
    return Int(Date().timeIntervalSince1970)
}

protocol EmailReceiverCallback {
    func onEmailReceiverResult(_ result:[NSManagedObject])
}

protocol EmailSubjectCallback {
    func onEmailSubjectResult()
}
