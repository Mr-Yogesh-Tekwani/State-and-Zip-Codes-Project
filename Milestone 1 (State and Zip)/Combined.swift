//
//  Combined.swift
//  Milestone 1 (State and Zip)
//
//  Created by Yogesh Tekwani on 5/17/23.
//

import Foundation
/*
 
 1. Scene:
 guard let windowScene = (scene as? UIWindowScene) else { return }

//        let vc = ViewController()
//        let navigationvc = UINavigationController(rootViewController: vc)
//        window?.rootViewController = navigationvc
 
 window = UIWindow(windowScene: windowScene)
 window?.rootViewController = SplitViewController()
 window?.makeKeyAndVisible()
 
 1.1 Split View
 class SplitViewController: UISplitViewController {
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         // Create the master and detail view controllers
         let masterViewController = ViewController()
         let detailViewController = FirstViewController()
         
         
         // Embed them in navigation controllers
         let masterNavigationController = UINavigationController(rootViewController: masterViewController)
         let detailNavigationController = UINavigationController(rootViewController: detailViewController)
         //let thirdnvc = UINavigationController(rootViewController: third)
         
         // Set the view controllers for the split view controller
         self.viewControllers = [masterNavigationController, detailNavigationController]
         
         // Set the preferred display mode for the split view controller
         self.preferredDisplayMode = .oneBesideSecondary
     }
 }

  1.2 CustomTableCell
 
 class CustomTableViewCell: UITableViewCell {

     static var identifier = "CustomTableViewCell"
         
         var stateLabel: UILabel = {
             let sLabel = UILabel()
             sLabel.textColor = .systemBlue
             sLabel.translatesAutoresizingMaskIntoConstraints = false
             return sLabel
         }()
     

         override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
             super.init(style: style, reuseIdentifier: reuseIdentifier)
             
             self.addSubview(stateLabel)
             
             
             
             NSLayoutConstraint.activate(
                 [stateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                  stateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
                  stateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
                  stateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             ])
         }
         
         required init?(coder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }

 }

 
 
 2. View
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
         splitViewController?.showDetailViewController(fvc, sender: self)
         
         // self.navigationController?.pushViewController(svc, animated: true)
         
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




 3. First
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
         splitViewController?.showDetailViewController(svc, sender: self)
         // self.navigationController?.pushViewController(svc, animated: true)
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


 
 
 
 
 
 4. Second
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
             // splitViewController?.popoverPresentationController
             
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
         self.navigationController?.popViewController(animated: true)
       }
 }


 */
