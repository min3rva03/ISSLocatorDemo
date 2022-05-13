//
//  IssLocatorTableController.swift
//  IssLocator
//
//  Created by Minerva Nolasco Espino on 12/05/22.
//

import UIKit

class IssLocatorTableController: UIViewController , UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var locatorTableView: UITableView!
    
    var vm : IssLocatorViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.locatorTableView.reloadData()
    }
    
    // MARK: - Table view data source
   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.getnumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "cellTest", for: indexPath) as? locationCell,
               let objReturn = vm?.getCellForRow(index: indexPath.row) as? IssLocatorModel else {
            return UITableViewCell()
        }
        
        cell.latitudLbl?.text =  "Latitud : \(objReturn.iss_position?.latitude ?? "")"
        cell.longitudLbl?.text = "Longitud: \(objReturn.iss_position?.longitude ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
