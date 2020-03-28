//
//  ableViewController.swift
//  CoreDataDemo
//
//  Created by Владислав Клепиков on 28.03.2020.
//  Copyright © 2020 Vladislav Klepikov. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var toDoItems: [Task] = []
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let AC = UIAlertController(title: "Add task", message: "add new task", preferredStyle: .alert)
        let OK = UIAlertAction(title: "Ok", style: .default) { (action) in
            let textField = AC.textFields?[0]
            self.saveTask(taskToDo: (textField?.text)!)
//            self.toDoItems.insert((textField.text)!, at: 0)
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//        let about = UIAlertAction(title: "About", style: .default) { (action) in
//            guard let text = AC.textFields?[0].text else { return }
//            print(text)
//        }
        
        AC.addTextField {
            textField in
        }
        
        AC.addAction(OK)
//        AC.addAction(about)
        AC.addAction(cancel)
        present(AC, animated: true, completion: nil)
    }
    
    private func saveTask(taskToDo: String) {
        //Обращаемся к AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //Создаем сущность для которой создаем объект
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        
        //Объекто который хотим сохранить и приводим его к типу Task
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Task
        
        taskObject.taskToDo = taskToDo
        print(taskObject)
        
        do {
            try context.save()
            toDoItems.append(taskObject)
            print("Save object")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    //Кол-во секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let task = toDoItems[indexPath.row]
        cell.textLabel?.text = task.taskToDo

        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
