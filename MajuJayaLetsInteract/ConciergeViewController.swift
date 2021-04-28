//
//  ConciergeViewController.swift
//  MajuJayaLetsInteract
//
//  Created by Rajabul Haris on 29/04/21.
//

import UIKit

class ConciergeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if LandscapeManager.shared.isFirstLaunch {
            performSegue(withIdentifier: "toOnboarding", sender: nil)
            LandscapeManager.shared.isFirstLaunch = true
        } else {
            performSegue(withIdentifier: "toMain", sender: nil)
        }
    }

}
extension UIStoryboard {
    static let onboarding = UIStoryboard(name: "Onboarding", bundle: nil)
    static let main = UIStoryboard(name: "Main", bundle: nil)
}
