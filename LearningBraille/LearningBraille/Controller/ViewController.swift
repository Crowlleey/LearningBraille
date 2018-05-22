//
//  ViewController.swift
//  LearningBraille
//
//  Created by George Gomes on 09/03/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralDelegate{
    
  @IBOutlet weak var tableViewDevices: UITableView!
    
    var stBraille: String!
    
    var centralManager: CBCentralManager?
    var peripherals: Array<CBPeripheral>!
    var myBluetoothPeripheral : CBPeripheral!

    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        peripherals = [CBPeripheral]()
        print(peripherals, "por")
        
        var i = BLEConnector()
    
        self.tableViewDevices.register(CellBT.self, forCellReuseIdentifier: "CellBT")
        self.tableViewDevices.dataSource = self
        self.tableViewDevices.delegate = self
    }


}

extension ViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if (central.state == .poweredOn){
            print("1111")
            self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
        }
        else {
            print("222")
             self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
        }
        
//        var stateString: String? = nil
//        switch central.state {
//            case .resetting:
//                print("The connection with the system service was momentarily lost, update imminent.", "update imminent", 0)
//            case .unsupported:
//                print("The platform doesn't support Bluetooth Low Energy.", "weak Bluetooth Connection", 0)
//            case .unauthorized:
//                print("The app is not authorized to use Bluetooth Low Energy.", "weak Bluetooth Connection", 0)
//            case .poweredOff:
//                stateString = "Bluetooth is currently powered off."
//                print("Bluetooth is currently powered off , powered ON first.", "No Bluetooth Connection", 0)
//            case .poweredOn:
//                stateString = "Bluetooth is currently powered on and available to use."
//
//            default:
//                stateString = "State unknown, update imminent."
//        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        
        peripherals.append(peripheral)
       
        if let name = peripheral.name{
            print(name, "abracadabre")
        }
        tableViewDevices.reloadData()
        
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewDevices.dequeueReusableCell(withIdentifier: "cellBT") as! CellBT
        print(peripherals[indexPath.row].name, "APAPORRA")
        
        if let texto = peripherals[indexPath.row].name{
            cell.btname.text = texto
        }else{
            cell.btname.text = "nao tem nome"
        }
        
//        cell.btname.text = "\(peripherals[indexPath.row].name) pqp"
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.myBluetoothPeripheral = peripherals[indexPath.row]    //save peripheral
        self.myBluetoothPeripheral.delegate = self
        
        if let central = centralManager {
            
            central.stopScan()                          //stop scanning for peripherals
            central.connect(myBluetoothPeripheral, options: nil) //connect to my peripheral
            
        }
        
        print("caraio")
        centralManagerDidUpdateState(centralManager!)
        
    }
    
    
    
}
