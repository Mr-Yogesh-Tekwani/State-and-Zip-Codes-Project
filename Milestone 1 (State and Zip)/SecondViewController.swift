//
//  SecondViewController.swift
//  Milestone 1 (State and Zip)
//
//  Created by Yogesh Tekwani on 5/13/23.
//

import UIKit


protocol SecondViewControllerDelegate {
    func changeZipCode(oldZipCode: String, newZipCode: String)
}

class SecondViewController: UIViewController {

    var data: String?
    
    var delegate: SecondViewControllerDelegate?
    
    var editLabel: UILabel = {
        let eLabel = UILabel()
        eLabel.text = "Edit Zip Code"
        eLabel.textColor = .blue
        return eLabel
    }()
    
   lazy  var zipLabel: UILabel = {
        var zLabel = UILabel()
        zLabel.textColor = .blue
        zLabel.text = data
        return zLabel
    }()
    
    var newZipText: UITextField = {
        var newText = UITextField()
       newText.placeholder = "Enter Zip"
        newText.textColor = .black
        return newText
    }()
    
    var okButton: UIButton = {
        let ok = UIButton()
        ok.setTitle("OK", for: .normal)
        ok.backgroundColor = .green
        ok.addTarget(self, action: #selector(okPressed), for: .touchUpInside)
        return ok
    }()
    
    var stackview: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .fillEqually
        
        sv.backgroundColor = .white
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackview.addArrangedSubview(editLabel)
        stackview.addArrangedSubview(zipLabel)
        stackview.addArrangedSubview(newZipText)
        stackview.addArrangedSubview(okButton)
        
        
        self.view.addSubview(stackview)
        self.view.backgroundColor = .white
        let safeArea = self.view.safeAreaLayoutGuide
        
        
        
        NSLayoutConstraint.activate(
            [stackview.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
             stackview.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,constant: -200),
             stackview.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             stackview.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
             okButton.heightAnchor.constraint(equalToConstant: 5),
             okButton.widthAnchor.constraint(equalToConstant: 150)])
        
    
    }
}

extension SecondViewController: UITableViewDelegate{
    @objc  func okPressed() {
        guard let x = newZipText.text , x != "" else {
            return
        }
        
          if let data = data {
              
              delegate?.changeZipCode(oldZipCode: data, newZipCode: x)
          }
        //let nav = SecondViewController()
        self.navigationController?.popViewController(animated: true)
      }
}
