//
//  BluetoothConector.swift
//  LearningBraille
//
//  Created by George Gomes on 21/05/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLEConnector: NSObject {
    
    var centralManager: CBCentralManager!
    var peripherals: [CBPeripheral]!
  
    
    
    
    override init() {
      super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
        self.peripherals = []
    }
    


}

extension BLEConnector: CBCentralManagerDelegate{
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }
    
}
