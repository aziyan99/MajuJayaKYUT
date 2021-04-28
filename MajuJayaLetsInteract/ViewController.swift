//
//  ViewController.swift
//  MajuJayaLetsInteract
//
//  Created by Raja Azian on 28/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var initCount: Int = 0
    var currentProgress: Float = 0.0

    @IBOutlet weak var topDateLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countProgressView: UIProgressView!
    @IBOutlet weak var bottomCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateTopDate()
        countLabel.text = "\(initCount)"
        countProgressView.setProgress(0, animated: true)
        bottomCountLabel.text = "\(initCount) of 6"
    }


    @IBAction func didTapCountInteractButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: "Add interaction count", preferredStyle: .actionSheet)
        let countButton = UIAlertAction(title: "Wohoo!!!", style: .default, handler: increaseCount)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(countButton)
        actionSheet.addAction(cancelButton)
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func updateTopDate() {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        let dateString: String = dateFormatter.string(from: today)
        
        topDateLabel.text = dateString.uppercased()
    }
    
    func increaseCount(alert: UIAlertAction!) {
        initCount += 1
        countLabel.text = "\(initCount)"
        
        bottomCountLabel.text = "\(initCount) of 6"
        
        let perProgress = countProgressView.frame.width / 6
        currentProgress += Float(perProgress)
        
        print("length progress: \(countProgressView.frame.width)")
        print("increase: \(perProgress)")
        print("current progress: \(currentProgress)")
        
        countProgressView.setProgress(currentProgress / Float(countProgressView.frame.width), animated: false)
        
    }
}

