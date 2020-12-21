//
//  BeaconVM.swift
//  DQ_Basic_Experiment
//
//  Created by guillaume MAIANO on 18/12/2020.
//

import Foundation
// to check beacons && to inform the user becaons can't be found if it turns out BT is OFF from the settings
import CoreBluetooth
// to get iBeacons
import CoreLocation
// Notifications - sans UI
import UserNotifications

/**
 As of iOS 11, turning off bluetooth in Control Center does not stop beacon detections. (Control Center is the quick menu you see when you swipe up from the bottom of the screen.) This menu item doesn't really turn off bluetooth, it only kills active Bluetooth connections and prevents new ones from being established. It does not prevent connectionless bluetooth communications like beacons.

 However, if you turn it off in Settings -> Bluetooth -> Off, you will see beacon detections stop.
 */
class BeaconVM: NSObject & CBCentralManagerDelegate & CLLocationManagerDelegate {
    
    var cm: CBCentralManager?
    
    var cLLM = CLLocationManager()
    
    var beacons: [BeaconCandidate] = []

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            // in this case, beacon detections should fail
            print("No beacon should be found")
            break
        case .resetting:
            break
        case .unsupported:
            break
        case .unknown:
            break
        case .poweredOn:
            // beacons should be seen
            // scan
            cm?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
            break
        case .unauthorized:
            // I believe beacons are still visible?
            print("Unauthorized")
            // check for perms
            switch CBManager.authorization {
            case .restricted:
                print("restricted")
                break
            case .denied:
                print("denied")
                break
            case .notDetermined:
                print("undetermined")
                break
            case .allowedAlways:
                print("allowed always, beacons should be detected for sure ;)")
                break
            default:
                print("Programmer error, case not handled")
            }
        default:
            print("Programmer error, state not handled")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        for beacon in beacons {
            print(beacon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        // warn user we lost track of the beacon
        guard region is CLBeaconRegion else { return } // oops, not a beacon... CLCircularRegion or?
        let content = UNMutableNotificationContent()
        content.title = "Left area?"
        content.body = "We have lost contact with our point of reference."
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: "AreaExit", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {_ in print("Area Exit Notified")})
    }
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        // warn user we got in range of the beacon
        let content = UNMutableNotificationContent()
        content.title = "Entered area"
        content.body = "We have made contact with our point of reference."
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: "AreaEntry", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {_ in print("Area Entry Notified")})
    }
    
    func monitorBeacon(_ candidate: BeaconCandidate) {
        let region = candidate.beaconRegion()
        cLLM.startMonitoring(for: region)
        cLLM.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: region.uuid))
    }
    func stopMonitoringBeacon(_ candidate: BeaconCandidate) {
        let region = candidate.beaconRegion()
        cLLM.stopRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: region.uuid))
        cLLM.stopMonitoring(for: region)
    }
    // MARK: LOG ISSUES -
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Region Monitoring failed: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed: \(error.localizedDescription)")
    }
    
    override init() {
        super.init()
        cm = CBCentralManager(delegate: self, queue: nil)
        if cm?.state == .poweredOn {
            cLLM.requestAlwaysAuthorization()
        }
        cLLM.delegate = self
        if let beaconUUID = UUID(uuidString: "11-46-FE-00-00-84-DF-C8") {
            print("Beacon defined")
            beacons.append(BeaconCandidate(major: 1, minor: 1, name: "BLUNO", uuid: beaconUUID))
        }
    }
}
