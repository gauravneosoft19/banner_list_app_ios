//
//  ViewController.swift
//  BannerListApp
//
//  Created by apple on 23/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var isSearching: Bool = false
    var searchBar: UISearchBar! = nil
    
    let listViewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.frame.size.height))
        searchBar.delegate = self
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.placeholder = "Search"
    }
}
//MARK: Table View Delegate & DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return listViewModel.itemList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
            cell.listViewModel = listViewModel
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)  as! ItemTableViewCell
            cell.itemTitle.text = listViewModel.itemList[indexPath.row].title
            cell.itemImageView?.image = UIImage(named: listViewModel.itemList[indexPath.row].imageName)
            cell.itemImageView?.clipsToBounds = true
            cell.itemImageView?.layer.cornerRadius = (cell.itemImageView?.frame.height)! / 2
            cell.itemImageView?.layer.masksToBounds = true
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return searchBar
        } else {
            return nil
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return isSearching ? 0 : 200
        } else {
            return 50
        }
    }
}
//MARK: Search Bar Delegate
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listViewModel.itemList = searchText.isEmpty ? listViewModel.getItemData() : listViewModel.getItemData().filter({ model in
            return model.title.range(of: searchText, options: .caseInsensitive) != nil
        })
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.searchTextField.resignFirstResponder()
        listViewModel.itemList = listViewModel.getItemData()
        tableView.reloadData()
    }
}

//MARK: Table View Delegate for refresh data
extension ViewController: TableViewProtocol {
    func refreshData() {
        self.tableView.reloadData()
    }
}
