//
//  ViewController.swift
//  DQ_TD_Experiment
//
//  Created by guillaume MAIANO on 17/12/2020.
//

import UIKit
import DriveKitTripSimulatorModule

class ViewController: UIViewController {
/*
     The Trip Simulator component allows to validate the following features:
     the automatic start;
     the trip recording life cycle;
     graphical display after the end of the trip;
     the application's behaviour in the case of alternative trips.
     */
    @IBAction func runTrajectory(_ sender: Any) {
        DriveKitTripSimulator.shared.start(PresetTrip.shortTrip);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

