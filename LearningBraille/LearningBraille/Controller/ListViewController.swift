//
//  ListViewController.swift
//  LearningBraille
//
//  Created by George Gomes on 21/05/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit

class ListViewController: UIViewController{
    
    @IBOutlet weak var tvDevices: UITableView!
    
//    var connector: BLEConnector!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.connector = BLEConnector()
        BLEConnector.shared.delegate = self
        
        self.tvDevices.dataSource = self
        self.tvDevices.delegate = self
    }
    
    @IBAction func btLoad(_ sender: Any) {
     
//        self.connector.send(value: "g")
    }
}

extension ListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BLEConnector.shared.peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dCell = self.tvDevices.dequeueReusableCell(withIdentifier: "cellBT") as! CellBT
        dCell.btname.text = BLEConnector.shared.peripherals[indexPath.row].name
        return dCell
    }
}

extension ListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        BLEConnector.shared.conectDeviceWith(BLEConnector.shared.peripherals[indexPath.row].name!)
    }
}

extension ListViewController: BLEUpdate{
    func update() {
        self.tvDevices.reloadData()
    }
    
    
}
