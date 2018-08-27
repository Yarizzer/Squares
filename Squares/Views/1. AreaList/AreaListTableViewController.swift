//
//  AreaListTableViewController.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 14/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class AreaListTableViewController: UITableViewController {

    var viewModel: AreaListViewModelType?
    
    private func updateModelSelectedIndex(withIndexPath indexPath: IndexPath) {
        guard let model = viewModel else { return }
        model.updateCurrentIndexPath(withIndexPath: indexPath)
    }
    
    @IBAction func addNewAreaAction(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Add new area", message: "Area is a plaseholder for all square notes", preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Area name"
            textField.clearButtonMode = .whileEditing
            textField.autocapitalizationType = .sentences
            textField.returnKeyType = .done
        }
        let okAction = UIAlertAction(title: "Done", style: .default) { [unowned self] action in
            guard let model = self.viewModel, let titleForNewArea = ac.textFields![0].text else { return }
            
            model.peformARecordForAreaInDB(withTitle: titleForNewArea, recordKey: "_Creation_")
            model.updateAreasArray()
            self.tableView.reloadData()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        self.present(ac, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AreaListViewModel()
        tableView.remembersLastFocusedIndexPath = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = viewModel else { return 0 }
        return model.getAreasCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel,
            let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AreaListTableViewCell else { return UITableViewCell() }

        tableViewCell.viewModel = model.getModelForCell(atIndexPath: indexPath)
        return tableViewCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel else { return }
        model.updateCurrentIndexPath(withIndexPath: indexPath)
        performSegue(withIdentifier: "showArea", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        updateModelSelectedIndex(withIndexPath: indexPath)
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { [unowned self] (action, IndexPath) in
            guard let model = self.viewModel else { return }
            print("model is existing")
            let ac = UIAlertController(title: "Edit area name", message: nil, preferredStyle: .alert)
            ac.addTextField { (textField) in
                textField.placeholder = "Area name"
                textField.text = model.getAreaNameForEditingRow()
                textField.clearButtonMode = .whileEditing
                textField.autocapitalizationType = .sentences
                textField.returnKeyType = .done
            }
            let doneAction = UIAlertAction(title: "Done", style: .default, handler: { [unowned self] action in
                guard let titleForArea = ac.textFields![0].text else { return }
                model.peformARecordForAreaInDB(withTitle: titleForArea, recordKey: "_Editing_")
                model.updateAreasArray()
                self.tableView.reloadData()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(doneAction)
            ac.addAction(cancelAction)
            self.present(ac, animated: true, completion: nil)
        }
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { [unowned self] (action, IndexPath) in
            guard let model = self.viewModel else { return }
            model.removeAreaRecordFromDB()
            tableView.deleteRows(at: [indexPath], with: .right)
        }

        editAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        return [deleteAction, editAction]
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let model = viewModel, let identifier = segue.identifier else { return }
        
        if identifier == "showArea" {
            if let dvc = segue.destination as? AreaViewController {
                dvc.viewModel = model.getModelForAreaVC()
            }
        }
    }

}
