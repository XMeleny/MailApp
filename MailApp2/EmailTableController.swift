//
//  EmailTableController.swift
//  MailApp2
//
//  Created by gtk on 2020/12/10.
//

import Foundation
import UIKit
import CoreData

class EmailTableController :UITableViewController,EmailReceiverCallback{
    let CELL_IDENTIFIER = "EmailCell"
    
    var emailReceivers = [NSManagedObject]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getEmailReceivers(callback: self)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailReceivers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath)
        
        let emailReceiver = emailReceivers[indexPath.row].value(forKey: "receiver") as? String
        let id = emailReceivers[indexPath.row].value(forKey: "id") as? Int
        cell.textLabel?.text = emailReceiver
        cell.detailTextLabel?.text = getEmailSubject(id: id!)
        
        return cell
    }
    
    func onEmailReceiverResult(_ result: [NSManagedObject]) {
        emailReceivers = result
        tableView.reloadData()
    }
    
}
