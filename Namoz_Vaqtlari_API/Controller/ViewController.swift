//
//  ViewController.swift
//  Namoz_Vaqtlari_API
//
//  Created by MacAir on 03/01/23.
//

import UIKit
import SnapKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Proporties
    
    let tableView  = UITableView()
    let textField  = UITextField()
    let pickerView = UIPickerView()
    let requestbtn = UIButton()
    let locationServices = CLLocationManager()
    
    var timeList: TimeList?
    var regionData = ["Andijon" , "Toshkent" , "Jizzax" , "Namangan" , "Navoiy" , "Samarqand" , "Buxoro" ]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        initializerLocationServices()

        
        //MARK: - Check Connection
        
        if NetworkMonitor.shared.isConnected {
            
            print("You're Connection")
        }
        else {
            
            showAlert(tittle: "Not connection", message: "Please check the connection")
        }
                
        //MARK: - textField -
        
         view.addSubview(textField)
        textField.placeholder = "   Enter text"
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldTapped), for: .touchUpInside)
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY).multipliedBy(0.2)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.96)
            make.height.equalTo(view.snp.height).multipliedBy(0.06)
        }
        
        //MARK: - tableView -

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 230
        tableView.backgroundColor = .red
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(15)
            make.bottom.equalTo(view.snp.bottom).offset(-475)
            make.right.equalTo(view.snp.right)
            make.left.equalTo(view.snp.left)
        }
        
        //MARK: - pickerView -
        
        view.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(15)
            make.bottom.equalTo(view.snp.bottom)
            make.right.equalTo(view.snp.right)
            make.left.equalTo(view.snp.left)
        }
    }
    
    //MARK: CoreLocation -
    
    func initializerLocationServices() {
        
        locationServices.delegate = self
        
        locationServices.allowsBackgroundLocationUpdates = true
        locationServices.showsBackgroundLocationIndicator = true
        
        guard CLLocationManager.locationServicesEnabled() else {
            
            return
        }
        
        locationServices.requestAlwaysAuthorization()
    }
    
    //MARK: - UIAlert -
    
    func showAlert(tittle: String , message: String) {
        
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Oke", style: UIAlertAction.Style.default) { make in
            exit(0)}
        alert.addAction(yesAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true,completion: nil)
        }
    
    }
    
    //MARK: - API -
    
    func fetchData(cityName: String) {
            
        let url = URL(string: "https://www.azamjondev.deect.ru/namozvaqtlari/index.php?region=\(cityName)")
        
        let dataTask = URLSession.shared.dataTask(with: url!) { (data , res , error) in
            
            guard let data = data , error == nil else {
                print("Error is \(String(describing: error))")
                return
            }
            var timeData: TimeList?
            
            do {
                timeData = try JSONDecoder().decode(TimeList.self, from: data)
                print(data)
            }
            catch let error {
                fatalError("\(error)")
                
            }
            guard let resultD = timeData else {
                print(".")
                return
            }
            
            let date = resultD.date
            let result = resultD.result
            let weekdateD = resultD.weekdate
            
            self.timeList = TimeList(date: date, weekdate: weekdateD, result: result)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        dataTask.resume()
    }
    
    //MARK: - TextField Delegate -
    
    @objc func textFieldTapped() {
        textField.endEditing(true)
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "   Enter text"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = textField.text {
            fetchData(cityName: city)
        }
        textField.text = ""
        
        }
    }

extension ViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.dateLabel.text = "\(timeList?.date ?? "0")"
        cell.weekdateLabel.text = "\(timeList?.weekdate ?? "0") kuni"
        cell.bomdodLabel.text = "Bomdod: \(timeList?.result.tong_saharlik ?? "0")"
        cell.quyoshLabel.text = "Quyosh: \(timeList?.result.quyosh ?? "0")"
        cell.peshinLabel.text = "Peshin: \(timeList?.result.peshin ?? "0")"
        cell.asrLabel.text = "Asr: \(timeList?.result.asr ?? "0")"
        cell.shomLabel.text = "Shom: \(timeList?.result.shom_iftor ?? "0")"
        cell.xuftonLabel.text = "Xufton: \(timeList?.result.xufton ?? "0")"
        
        return cell
    }
    
}
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regionData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fetchData(cityName: regionData[row])
    }
    
}
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return regionData.count
    }
    
}

//MARK: - CoreLocation Delegate -

extension ViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        let status = manager.authorizationStatus
        
        switch status {
        case .notDetermined:
            print("notDetermined")
            locationServicesNeededState()
        case .denied:
            print("denied")
            promptForAuthorization()
        case .restricted:
            print("restricted")
            locationServicesRestricedState()
        case .authorizedAlways:
            print("authorizedAlways")
            locationServices.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationServices.startUpdatingLocation()
        default:
            print("unknown")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
}

//MARK: - CoreLocation Delegate -

extension ViewController {
    
    func promptForAuthorization() {
        let alert = UIAlertController(title: "Location  access is needed to get your current location", message: "Please allow location access", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "Setting", style: .default , handler: { _ in
            UIApplication.shared.open(URL(string:
                                            UIApplication.openSettingsURLString)!, options:
                                        [:] , completionHandler: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default , handler: { [weak self] _ in
            self?.locationServicesNeededState()
        })
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        alert.preferredAction = settingAction
        
        present(alert, animated: true , completion: nil)
        
    }
    
    func locationServicesNeededState() {
        
    }
    
    func locationServicesRestricedState() {

    }
}
