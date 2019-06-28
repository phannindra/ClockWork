//
//  ViewController.swift
//  clockWork
//
//  Created by Phanindra on 28/06/19.
//  Copyright © 2019 Phanindra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var numberOfRows:Int = 2
    var timeZones:[TimeZone] = [TimeZone.current]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        // Do any additional setup after loading the view.
    }
    
    func registerCells(){
        tableView.register(UINib(nibName: "TimeCell", bundle: nil), forCellReuseIdentifier: "timeCell")
        tableView.register(UINib(nibName: "timeCellAdder", bundle: nil), forCellReuseIdentifier: "timeAdder")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "timeAdder", for: indexPath) as! timeCellAdder
            cell.addTime.addTarget(self, action: #selector(addTimeZone), for: .touchDown)
            cell.selectionStyle = .none
            return cell
            
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! TimeCell
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM-dd-YYYY hh:mm:ss a"
            formatter.timeZone = self.timeZones[indexPath.row - 1]
            cell.time.text = formatter.string(from: Date())
            cell.timezoneName.text = self.timeZones[indexPath.row-1].identifier//TimeZone.current.identifier
            cell.selectionStyle = .none
            return cell
        
        }
        
    }
    
    @objc func addTimeZone(){
        
        let popUp = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        for tz in TimeZone.knownTimeZoneIdentifiers {
            let timeZone = TimeZone(identifier: tz)
            if let abbreviation = timeZone?.abbreviation() {
                popUp.addAction(UIAlertAction(title: "\(tz)\n\(abbreviation)", style: .default){_ in
                    self.timeZones.append(timeZone!)
                    self.numberOfRows = self.numberOfRows + 1
                    self.tableView.reloadData()
                })
            }
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default){_ in
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        popUp.addAction(okAction)
        popUp.addAction(cancelAction)
        self.present(popUp, animated: true, completion: nil)
        
    }


}

