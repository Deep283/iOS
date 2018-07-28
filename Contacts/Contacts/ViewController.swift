//
//  ViewController.swift
//  Contacts
//
//  Created by vinay shinde on 22/01/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let cellId = "cellId"
    
    var showIndexPaths = false
    
    var contacts = [
        ExpandableNames(isExpanded: true,contacts: [ "Srishti", "Deepak", "Archit", "Mahek", "Priyesh" ].map{Contact(name: $0, isFavourited: false)}),
        ExpandableNames(isExpanded: true,contacts: [ "David", "Divya", "Divyanshi", "Deepesh"].map{Contact(name: $0, isFavourited: false)}),
        ExpandableNames(isExpanded: true,contacts: [ "Pooja", "Priya", "Priyansh", "patil" ].map{Contact(name: $0, isFavourited: false)}),
        ExpandableNames(isExpanded: true, contacts: ["Rishika","Reet","RitulBhabhi","Ritika"].map{Contact(name: $0, isFavourited: false)}),
    ]
    
    func addToFavourite(cell: UITableViewCell)  {
        
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let contact = contacts[indexPath.section].contacts[indexPath.row]
        let isFavourited = contact.isFavourited
        contacts[indexPath.section].contacts[indexPath.row].isFavourited = !isFavourited
        cell.accessoryView?.tintColor = contact.isFavourited ? UIColor.cyan : .yellow
        print("updated : \(contacts[indexPath.section].contacts[indexPath.row])")
    }
    @objc func handleShowIndexPath()
    {
         var indexToReload = [IndexPath]()
         for section in contacts.indices{
            for row in contacts[section].contacts.indices
            {
            let index = IndexPath(row: row, section: section)
            indexToReload.append(index)
            }
        }
        
        showIndexPaths = !showIndexPaths
        let animationStyle = showIndexPaths ? UITableViewRowAnimation.right : .left
        let title = showIndexPaths ? "HideIndexPath" : "ShowIndexPath"
        navigationItem.rightBarButtonItem?.title = title
         tableView.reloadRows(at: indexToReload, with: animationStyle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ShowIndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = UIColor.cyan
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
        
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle(contacts[section].isExpanded ? "Close" : "Open", for: .normal)
        button.backgroundColor = UIColor.cyan
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        return button
    }

    @objc func handleExpandClose(button: UIButton)
    {
        let section = button.tag
        var indexPath = [IndexPath]()
        for row in contacts[section].contacts.indices
        {
            let indexPaths = IndexPath(row: row, section: section)
            indexPath.append(indexPaths)
        }
        if !contacts[section].isExpanded{
            contacts[section].isExpanded = true
            tableView.insertRows(at: indexPath, with: .fade)
        }
        else{
            contacts[section].isExpanded = false
            tableView.deleteRows(at: indexPath, with: .fade)
        }
        button.setTitle(contacts[section].isExpanded ? "Close" : "Open", for: .normal)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !contacts[section].isExpanded
        {
            return 0
        }
        return contacts[section].contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        cell.link = self
        let contact = contacts[indexPath.section].contacts[indexPath.row]
        
        if contacts[indexPath.section].isExpanded{
        cell.textLabel?.text = contact.name
        if showIndexPaths{
                    cell.textLabel?.text = contact.name + "  Section:\(indexPath.section) Row:\(indexPath.row)"
            }
        }
        return cell
    }

}

