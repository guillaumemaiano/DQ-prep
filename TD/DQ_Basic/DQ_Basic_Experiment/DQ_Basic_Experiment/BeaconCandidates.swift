//
//  BeaconCandidates.swift
//  DQ_Basic_Experiment
//
//  Created by guillaume MAIANO on 20/12/2020.
//

import Foundation
import CoreLocation

struct BeaconCandidate {
    let major: CLBeaconMajorValue
    let minor: CLBeaconMinorValue
    let name: String
    let uuid: UUID
    
    func beaconRegion() -> CLBeaconRegion {
        return CLBeaconRegion(uuid: uuid, major: major, minor: minor, identifier: name)
    }
    
    func proximityDescription(_ proximity: CLProximity) -> String {
        switch proximity {
        case .unknown:
            return "UNKNOWN"
        case .immediate:
            return "IMMEDIATE"
        case .near:
            return "NEAR"
        case .far:
            return "FAR"
        default:
            return "NOT HANDLED"
        }
    }
}
