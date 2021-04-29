//
//  ViewController.swift
//  MajuJayaLetsInteract
//
//  Created by Raja Azian on 28/04/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var currentProgress: Float = 0.0
    private var todayInteractions = [Interacts]()
    
    @IBOutlet weak var topDateLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countProgressView: UIProgressView!
    @IBOutlet weak var bottomCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInteractionsData()
        prepareView()
        
    }

    /*
     * Items related function
     */
    
    @IBAction func didTapCountInteractButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: "Add interaction count", preferredStyle: .actionSheet)
        let countButton = UIAlertAction(title: "Wohoo!!!", style: .default, handler: increaseCount)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(countButton)
        actionSheet.addAction(cancelButton)
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    /*
     * Define function
     */
    func prepareView(){
        // Updating date
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        let dateString: String = dateFormatter.string(from: today)
        topDateLabel.text = dateString.uppercased()
        
        // updating count and progress
        countLabel.text = "\(todayInteractions.count)"
        bottomCountLabel.text = "\(todayInteractions.count) of 6"
        
        let perProgress = countProgressView.frame.width / 6
        currentProgress = Float(todayInteractions.count) * Float(perProgress)
        
        countProgressView.setProgress(currentProgress / Float(countProgressView.frame.width), animated: false)
        
    }
    
    
    func increaseCount(alert: UIAlertAction!) {
        storeInteractionData()
    }
    
    /*
     * Core data function
     */
    
    func fetchInteractionsData(){
        let fetchRequest = NSFetchRequest<Interacts>(entityName: "Interacts")
        
        // Get the current calendar with local time zone
        let calendar = Calendar.current

        // Get today's beginning & end
        let dateFrom = calendar.startOfDay(for: Date()) // eg. 2016-10-10 00:00:00
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        // Note: Times are printed in UTC. Depending on where you live it won't print 00:00:00 but it will work with UTC times which can be converted to local time

        // Set predicate as date being today's date
        let fromPredicate = NSPredicate(format: "date >= %@", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", dateTo! as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        fetchRequest.predicate = datePredicate
        
        do{
            todayInteractions = try context.fetch(fetchRequest)
        }catch{
            print("Error when getting data")
        }
    }
    
    func storeInteractionData() {
        let newCount = Interacts(context: context)
        newCount.name = ""
        newCount.reflections = ""
        newCount.date = Date()
        
        do{
            try context.save()
            fetchInteractionsData()
            prepareView()
        }catch{
            print("Error when saving data")
        }
    }
}

