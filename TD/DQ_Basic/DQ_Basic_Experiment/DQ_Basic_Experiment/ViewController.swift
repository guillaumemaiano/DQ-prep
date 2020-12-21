//
//  ViewController.swift
//  DQ_Basic_Experiment
//
//  Created by guillaume MAIANO on 18/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    
    var beaconVM: BeaconVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        beaconVM = BeaconVM()
    }


}

