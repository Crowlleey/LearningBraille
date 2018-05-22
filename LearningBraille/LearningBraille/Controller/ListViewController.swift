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
    
    var connector: BLEConnector!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.connector = BLEConnector()
        
        
        self.tvDevices.dataSource = self
        self.tvDevices.delegate = self
    }
    
    @IBAction func btLoad(_ sender: Any) {
     
        self.connector.send(value: "g")
    }
    
    
}

extension ListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dCell = self.tvDevices.dequeueReusableCell(withIdentifier: "cellBT") as! CellBT
        return dCell
    }
    
    
}

extension ListViewController: UITableViewDelegate{
    
}
