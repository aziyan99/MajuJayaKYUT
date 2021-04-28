//
//  ViewController.swift
//  MajuJayaLetsInteract
//
//  Created by Raja Azian on 28/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateTopDate()
    }


    @IBAction func didTapCountInteractButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: "Add interaction count", preferredStyle: .actionSheet)
        let countButton = UIAlertAction(title: "Wohoo!!!", style: .default)
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
}

