//
//  ViewController.swift
//  Milestone 1 (State and Zip)
//
//  Created by Yogesh Tekwani on 5/13/23.
//

import UIKit

struct stateZip {
    var stateName: String
    var zipCode: [String]
    mutating func updateZipCode(oldValue: String, newValue: String) {
        for (index ,value) in zipCode.enumerated() {
            if value == oldValue {
                zipCode[index] = newValue
            }
        }
    }
}

class ViewController: UIViewController {
    
//    var states: String = ""
//    var zip: String = ""
    
    var data: [stateZip] = []
    
    
    let mainStack1 : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    let label1 : UILabel = {
        let label = UILabel()
        return label
    }()
    
    let tableview: UITableView = {
        let tv = UITableView(frame: .zero)
        //tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        tableview.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        tableview.delegate = self
        tableview.dataSource = self
      
        let path = Bundle.main.path(forResource: "statedictionary", ofType: "plist")
      let dict = NSDictionary(contentsOfFile: path!)

        for (key, value) in dict! {
            if let key = key as? String , let value = value as? [String] {
                
                let zipObj = stateZip(stateName: key, zipCode: value)
                data.append(zipObj)
             //   print(data)
            }
        }
        
        label1.text = "States"
        //label1.textAlignment = .center
        label1.font = UIFont(name: "Times New Roman", size: 30)
        label1.textColor = .white
        tableview.delegate = self
        tableview.dataSource = self
        tableview.reloadData()
        
        mainStack1.addArrangedSubview(label1)
        mainStack1.addArrangedSubview(tableview)
        self.view.addSubview(mainStack1)
        //print(dataDict)
        
        mainStack1.translatesAutoresizingMaskIntoConstraints = false
        
        tableview.reloadData()
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [mainStack1.topAnchor.constraint(equalTo: safeArea.topAnchor),
             mainStack1.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
             mainStack1.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             mainStack1.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)])
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let fvc = FirstViewController()
        fvc.data = data[indexPath.row]
        fvc.delegate = self
        self.navigationController?.pushViewController(fvc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.stateLabel.text = data[indexPath.row].stateName
        
        
        return cell
    }
    
    
}
extension ViewController: FirstViewControllerDelegate {
    func updateZipCode(stateName: String, oldZipCode: String, newZipCode: String) {

        for (index, value) in data.enumerated(){
         //   print(value)
            if value.stateName == stateName {
                data[index].updateZipCode(oldValue: oldZipCode, newValue: newZipCode)
            }
        }
        
    }
}



