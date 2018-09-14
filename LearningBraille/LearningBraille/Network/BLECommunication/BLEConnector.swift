//
//  BluetoothConector.swift
//  LearningBraille
//
//  Created by George Gomes on 21/05/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BLEUpdate {
    func update()
}

class BLEConnector: NSObject{
    
    static let shared = BLEConnector()
    
    var delegate: BLEUpdate?
    
    var centralManager: CBCentralManager!
    var myBluetoothPeripheral : CBPeripheral!
    var peripherals: [CBPeripheral]!{
        didSet{
            print("TO DO DELEGATE TO UPDATE")
            if let up = delegate{
                up.update()
            }
        }
    }
    
    private var characterist: CBCharacteristic?
    private(set) var isReady: Bool = false
    
    
    override init() {
      super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        
        self.peripherals = [CBPeripheral]()
    }
    
    func send(value: String) {
        if( self.isReady ) {
            let data = value.data(using: .utf8)!
            guard let characterist = self.characterist else { return }
            self.myBluetoothPeripheral.writeValue(data, for: characterist, type: .withoutResponse)
        }
    }
    
    func read() {
        if( self.isReady ) {
            guard let characterist = self.characterist else { return }
            self.myBluetoothPeripheral.readValue(for: characterist)
        }
    }    
}

extension BLEConnector: CBCentralManagerDelegate{
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("centralManagerDidUpdateState")
            if (central.state == .poweredOn){
                self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
            }
            else {
               
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
    
    func conectDeviceWith(_ name: String){
        for peripheral in self.peripherals{
            if(peripheral.name == name){
                self.myBluetoothPeripheral = peripheral
                centralManager.stopScan()
                centralManager.connect(myBluetoothPeripheral, options: nil) //connect to my peripheral
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        
        if let name = peripheral.name{
            peripherals.append(peripheral)
            print(name)
//            if(name == "braille"){
//                self.myBluetoothPeripheral = peripheral
//                central.stopScan()                          //stop scanning for peripherals
//                central.connect(myBluetoothPeripheral, options: nil) //connect to my peripheral
//
//            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
}

extension BLEConnector: CBPeripheralDelegate{
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        for service in peripheral.services ?? [] {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        for characterist in service.characteristics ?? []  {
            print( "sigla ", characterist.uuid.uuidString, " nome ",characterist.uuid)
            
            if(characterist.uuid.uuidString == "FFE1"){
            
                print(characterist.uuid.uuidString, "AQUI O BRAGDRATS")
                print("Discovered Characteristic \(characterist), for Service \(service)")
                self.characterist = characterist
                self.isReady = true
                peripheral.setNotifyValue(true, for: characterist)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let characteristOfInterest = self.characterist, let data = characteristOfInterest.value  else { return }
        if( characteristic.uuid.uuidString == characteristOfInterest.uuid.uuidString ) {
            send(value: "w")
            print(data)
            // Allows the delegate to handle data exchange (read)
//            self.delegate?.communicator(self, didRead: data)
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
    
        guard let characteristOfInterest = self.characterist, let _ = characteristOfInterest.value else { return }
        if( characteristic.uuid.uuidString == characteristOfInterest.uuid.uuidString ) {
            print(characteristOfInterest, "perig")
            // Allows the delegate to handle data exchange (write)
//            self.delegate?.communicator(self, didWrite: data)
            
            print("era pra ter mandado 2")
        }
        
    }
}
