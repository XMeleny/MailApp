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

let FILE_NAME_EMAIL_SUBJECT = NSHomeDirectory() + "/Documents/email_subject.plist"

var dic = [String:String]()

var didUpdateSubjectFromFile=false

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

func getEmailSubject(id:Int)->String?{
    if(!didUpdateSubjectFromFile){
        updateEmailSubjectFromFile()
    }
    return dic[String(id)]
}

func updateEmailSubjectFromFile(){
    didUpdateSubjectFromFile = true
    dic = NSDictionary(contentsOfFile: FILE_NAME_EMAIL_SUBJECT) as? Dictionary<String, String> ?? dic
}

func saveEmailReceiver(id:Int, receiver:String){
    let managedObjectContext = getManagedObjectContext()
    
    let entity = NSEntityDescription.entity(forEntityName: CORE_DATA_ENTITY_EMAIL_RECEIVER, in: managedObjectContext)
    
    let emailReceiver = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
    
    emailReceiver.setValue(id, forKey: CORE_DATA_KEY_EMAIL_ID)
    emailReceiver.setValue(receiver, forKey: CORE_DATA_KEY_EMAIL_RECEIVER)
    
    do{
        try managedObjectContext.save()
    }catch{
        fatalError("save error")
    }
}

func saveEmailSubject(id:Int, subject:String){
    if(!didUpdateSubjectFromFile){
        updateEmailSubjectFromFile()
    }
    
    dic[String(id)] = subject
    NSDictionary.init(dictionary: dic).write(toFile: FILE_NAME_EMAIL_SUBJECT, atomically: true)
    
    print(dic)//test
}


func saveEmail(receiver:String, subject:String){
    let newId = getNewId()
    saveEmailReceiver(id: newId, receiver: receiver)
    saveEmailSubject(id: newId, subject: subject)
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
