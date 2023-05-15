//
//  FirstViewController.swift
//  Milestone 1 (State and Zip)
//
//  Created by Yogesh Tekwani on 5/13/23.
//

import UIKit

protocol FirstViewControllerDelegate {
    func updateZipCode(stateName: String, oldZipCode: String, newZipCode: String)
}

class FirstViewController: UIViewController {
    
    
    var data: stateZip? = nil
    var delegate: FirstViewControllerDelegate?
    
    let tableview: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        self.view.addSubview(tableview)
        tableview.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        tableview.delegate = self
        tableview.dataSource = self
    
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [tableview.topAnchor.constraint(equalTo: safeArea.topAnchor),
             tableview.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
             tableview.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             tableview.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)])
    }
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let svc = SecondViewController()
        svc.data = data?.zipCode[indexPath.row]
       // print(svc.data)
        svc.delegate = self
        self.navigationController?.pushViewController(svc, animated: true)
    }
    
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.zipCode.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.stateLabel.text = data?.zipCode[indexPath.row]
        
        
        return cell
    }
    
    
}
extension FirstViewController: SecondViewControllerDelegate {
    func changeZipCode(oldZipCode: String, newZipCode: String) {
        data?.updateZipCode(oldValue: oldZipCode, newValue: newZipCode)
        tableview.reloadData()
        if let data = data {
            delegate?.updateZipCode(stateName: data.stateName, oldZipCode: oldZipCode, newZipCode: newZipCode)
        }
    }
}

