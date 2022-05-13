//
//  IssLocatorTableController.swift
//  IssLocator
//
//  Created by Minerva Nolasco Espino on 12/05/22.
//

import UIKit

class IssLocatorTableController: UITableViewController {
    
    var vm : IssLocatorViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.getnumberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTest", for: indexPath)
        return UITableViewCell()
    }
}
