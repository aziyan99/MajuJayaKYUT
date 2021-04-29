//
//  SecondStepViewController.swift
//  MajuJayaLetsInteract
//
//  Created by Rajabul Haris on 29/04/21.
//

import UIKit

class SecondStepViewController: UIViewController {

    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        
        if let pageController = parent as? MainPageViewController {
                pageController.pushNext()
            }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
