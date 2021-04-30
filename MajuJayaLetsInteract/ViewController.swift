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
    @IBOutlet weak var bottomMessageCountLabel: UILabel!
    @IBOutlet weak var bottomMessageTextLabel: UILabel!
    
    
    /*
     * temp variable
     */
    
    @IBOutlet weak var imgBadges1: UIImageView!
    @IBOutlet weak var imgBadges2: UIImageView!
    @IBOutlet weak var imgBadges3: UIImageView!
    @IBOutlet weak var imgBadges4: UIImageView!
    @IBOutlet weak var imgBadges5: UIImageView!
    @IBOutlet weak var imgBadges6: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInteractionsData()
        prepareView()
        prepareBadges()
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
        let dateString: String = dateFormatter.string(from: today).uppercased()
        topDateLabel.text = "\(dateString)"
        
        // updating bottom message
        bottomMessageCountLabel.text = "\(todayInteractions.count)"
        bottomMessageTextLabel.text = " is more than \(todayInteractions.count - 1), but \(todayInteractions.count + 1) is better"
        
        // updating count and progress
        countLabel.text = "\(todayInteractions.count)"
        bottomCountLabel.text = "\(todayInteractions.count) of 6"
        
        let perProgress = countProgressView.frame.width / 6
        currentProgress = Float(todayInteractions.count) * Float(perProgress)
        
        
        if(CGFloat(currentProgress) <= countProgressView.frame.width){
            countProgressView.setProgress(0.0, animated: false)
            countProgressView.setProgress(currentProgress / Float(countProgressView.frame.width), animated: false)
        }
        else if(CGFloat(currentProgress) > countProgressView.frame.width && CGFloat(currentProgress) <= (countProgressView.frame.width * 5.0)){
            countProgressView.trackTintColor = .systemBlue
            countProgressView.progressTintColor = .systemOrange
            countProgressView.setProgress(0.0, animated: false)
            
            countProgressView.setProgress((currentProgress - Float(countProgressView.frame.width)) / (Float(countProgressView.frame.width * 5.0) - (Float(countProgressView.frame.width))), animated: false)

            countLabel.textColor = .systemOrange

        }else if (CGFloat(currentProgress) > countProgressView.frame.width * 5.0){
            countProgressView.trackTintColor = .systemOrange
            countProgressView.progressTintColor = .systemPink

            countProgressView.setProgress(0.0, animated: false)
            countProgressView.setProgress((currentProgress - Float(countProgressView.frame.width * 5.0)) / (Float(countProgressView.frame.width * 10.0) - (Float(countProgressView.frame.width) * 5.0)), animated: false)

            countLabel.textColor = .systemPink
        }
    }
    
    
    func increaseCount(alert: UIAlertAction!) {
        storeInteractionData()
        fetchInteractionsData()
        prepareView()
        prepareBadges()
        
    }
    
    func prepareBadges() {
        let todayCount = todayInteractions.count
        if(todayCount >= 1){
            imgBadges1.image = UIImage(named: "initiator")
        }
        if(todayCount >= 3){
            imgBadges1.image = UIImage(named: "initiator")
            imgBadges2.image = UIImage(named: "participator")
        }
        if(todayCount >= 6){
            imgBadges1.image = UIImage(named: "initiator")
            imgBadges2.image = UIImage(named: "participator")
            imgBadges3.image = UIImage(named: "actor")
        }
        if(todayCount >= 12){
            imgBadges1.image = UIImage(named: "initiator")
            imgBadges2.image = UIImage(named: "participator")
            imgBadges3.image = UIImage(named: "actor")
            imgBadges4.image = UIImage(named: "inspirator")
        }
        if(todayCount >= 18){
            imgBadges1.image = UIImage(named: "initiator")
            imgBadges2.image = UIImage(named: "participator")
            imgBadges3.image = UIImage(named: "actor")
            imgBadges4.image = UIImage(named: "inspirator")
            imgBadges5.image = UIImage(named: "simbo")
        }
        if(todayCount >= 24){
            imgBadges1.image = UIImage(named: "initiator")
            imgBadges2.image = UIImage(named: "participator")
            imgBadges3.image = UIImage(named: "actor")
            imgBadges4.image = UIImage(named: "inspirator")
            imgBadges5.image = UIImage(named: "simbo")
            imgBadges6.image = UIImage(named: "orator")
            print("breakkkkk!!!!")
        }
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
        }catch{
            print("Error when saving data")
        }
    }
}

