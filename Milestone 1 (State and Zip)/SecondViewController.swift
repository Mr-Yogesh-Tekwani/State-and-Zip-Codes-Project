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

extension String {
    var isNumber: Bool {
        return self.range(
            of: "^[0-9]*$", // 1
            options: .regularExpression) != nil
    }
}

extension SecondViewController: UITableViewDelegate{
    @objc  func okPressed() {
        guard let x = newZipText.text , x != "" else {
            return
        }
        var check = true
        
        if x.isNumber && x.count == 5 {
            check = false
          if let data = data {
              delegate?.changeZipCode(oldZipCode: data, newZipCode: x)
            
            guard let fileUrl = Bundle.main.url(forResource: "statedictionary", withExtension: "plist") else { return }
            guard var dictdata = NSMutableDictionary(contentsOf: fileUrl) else { return }

            dictdata.setValue( x, forKey: data)
            print(x)
            print(data)

            if dictdata.write(to: fileUrl, atomically: true) {
                print("Data updated successfully")
            } else {
                print("Failed to update data")
            }
            //splitViewController?.popoverPresentationController
            
            // self.navigationController?.popViewController(animated: true)
            
            let dic:[stateZip] = ViewController().data


                    if let infoPlistPath = Bundle.main.url(forResource: "statedictionary", withExtension: "plist") {

                        do  {

                            let data = try PropertyListSerialization.data(fromPropertyList: dic, format: PropertyListSerialization.PropertyListFormat.binary, options: 0)

                            do {
                                print("Try Data Updating")
                                try data.write(to: infoPlistPath)

                            }catch (let err){
                                print("Error at 137")
                                print(err.localizedDescription)

                            }

                        }catch (let err){
                            print("Error at 143")
                            print(err.localizedDescription)

                        }
                        
                    }
            

          }
        }
        else{
            let alertController = UIAlertController(title: "Alert", message: "Enter 5 digit numeric zip code !", preferredStyle: .alert)
               let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
               }
               alertController.addAction(okAction)
               present(alertController, animated: true, completion: nil)
        }
        //let nav = SecondViewController()
        //self.navigationController?.popViewController(animated: true)
        
      }
}
