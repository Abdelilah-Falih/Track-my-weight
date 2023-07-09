//
//  ViewController.swift
//  Suivre Mon Poids
//
//  Created by Abdelilah on 09/07/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var label_poids: UITextField!
    @IBOutlet weak var btn_save: UIButton!
    @IBOutlet weak var listView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    
    var listPoids : [Weight] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listPoids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! ItemController;
        //formatting the date text from Optional(yyyy-MM-dd hh-mm-ss) to yyyy-MM-dd
        var format_date01 = "\(String(describing: listPoids[indexPath.row].date))";
        var text_date = "\(format_date01.substring(from: format_date01.firstIndex(of: "2")!))";
        cell.text_date.text = "\(text_date.substring(to: text_date.firstIndex(of: " ")!))";
        cell.text_weight.text = "\(listPoids[indexPath.row].poids)";
        cell.btn_delete.tag = indexPath.row
        cell.btn_delete.addTarget(self, action: #selector(deleteItem(sender: )), for: .touchUpInside)

        return cell;
    }
    @objc
        func deleteItem(sender :UIButton){
            let context = appDelegate.persistentContainer.viewContext
            
            context.delete(listPoids[sender.tag])
            do
            {
                try context.save()
            }
            catch
            {
                print("Failed Deleting ")
            }
            
            listPoids.remove(at: sender.tag)
            listView.reloadData()
        }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listView.dataSource = self;
        listView.delegate = self;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Weight")
                    request.returnsObjectsAsFaults = false
        do {
            let weights = try context.fetch(request) as! [Weight]
            listPoids = weights
        } catch {
            print("Failed to fetch weights: \(error)")
        }
                               
        listView.reloadData()
    }
    @IBAction func btn_save_click(_ sender: Any) {
        var text_poids = Double(label_poids.text!);
        var date = Date.now
        let context = appDelegate.persistentContainer.viewContext
        
        let weigth = Weight(context: context)
        weigth.setValue(text_poids, forKey: "poids")
        weigth.setValue(date, forKey: "date")
        
        do {
            try context.save()
        }
        catch {
            print("Failed Saving")
        }
                    
        let _ = navigationController?.popViewController(animated: true)
                    
        print(" date = \(weigth.date)\n poids = \(weigth.poids)")
        listPoids.append(weigth)
        listView.reloadData()
        
        
    }
    


}

