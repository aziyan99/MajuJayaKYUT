//
//  FirstStepViewController.swift
//  MajuJayaLetsInteract
//
//  Created by Rajabul Haris on 29/04/21.
//

import UIKit

class FirstStepViewController: UIViewController {
    
    @IBOutlet weak var buttonNext: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonNext.layer.cornerRadius = 10
    }
    
  
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        
        if let pageController = parent as? MainPageViewController {
                pageController.pushNext()
            }
    }
    
    
        
   

}
