//
//  ViewController.swift
//  ClinicConnect
//
//  Created by Macbook on 07/10/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var btnStackView: UIStackView!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    
    @IBOutlet weak var viewOfficeHours: UIView!
    @IBOutlet weak var lblOfficeHours: UILabel!
    @IBOutlet weak var tblPetDetails: UITableView!
    
    let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchDataForHome()
    }
    
    func fetchDataForHome(){
        homeViewModel.getConfigData {[weak self] in
            
                DispatchQueue.main.async {
                    self?.btnChat.isHidden = self?.homeViewModel.settingsModel?.settings?.isChatEnabled ?? false
                    self?.btnCall.isHidden = self?.homeViewModel.settingsModel?.settings?.isCallEnabled ?? false
                    
                    if self?.homeViewModel.settingsModel?.settings?.isChatEnabled ?? true || self?.homeViewModel.settingsModel?.settings?.isCallEnabled ?? true {
                        self?.btnStackView.isHidden = true
                    } else{
                        self?.btnStackView.isHidden = false
                    }
                    
                    self?.lblOfficeHours.text = "Office Hours: \(self?.homeViewModel.settingsModel?.settings?.workHours ?? "")"
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                        self?.tblPetDetails.reloadData()
                    }
                    
                }
                
           
        }
    }
    
    func setupView() {
        self.navigationItem.title = ScreenTitle.home
        viewOfficeHours.layer.borderWidth = 2
        viewOfficeHours.layer.borderColor = UIColor.gray.cgColor
        registerTableViewCell()
        
    }
    
    // MARK: - RegisterTableViewCell
    private func registerTableViewCell() {
        tblPetDetails.register(UINib(nibName: Constants.TableViewCell.petTableViewCell, bundle: Bundle(for: HomeViewController.self)), forCellReuseIdentifier: Constants.TableViewCell.petTableViewCell)
    }
    
    @IBAction func btnChatTapped(_ sender: Any) {
        getOfficeHours()
    }
    
    @IBAction func btnCallTapped(_ sender: Any) {
        getOfficeHours()
    }
    
    
    func getOfficeHours(){
        let calendar = Calendar(identifier: .gregorian)
        let now = Date()
        let weekday = calendar.component(.weekday, from: now as Date)
        print(weekday)
        if weekday != 1 && weekday != 7 {
            let startWorkinngHour = now.dateAt(hours: 9)
            let endWorkinngHour = now.dateAt(hours: 18)
            if now >= startWorkinngHour && now <= endWorkinngHour {
                print("The time is between")
                showAlert(vc: self, title: Constants.alert, message: Constants.thankYou)
            } else {
                print("The time is not between")
                showAlert(vc: self, title: Constants.alert, message: Constants.workHoursEnded)
            }
        } else {
            print("The time is not between")
            showAlert(vc: self, title: Constants.alert, message: Constants.workHoursEnded)
        }
    }
    
}


// MARK: - Table View delegate, datasource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeViewModel.petsModel?.pets?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:Constants.TableViewCell.petTableViewCell) as? PetTableViewCell {
            cell.configure(pets: self.homeViewModel.petsModel?.pets?[indexPath.row])
            
            return cell
        }
        return UITableViewCell()
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let petDetailViewController = storyBoard.instantiateViewController(withIdentifier: Constants.ViewController.petDetailsViewController) as! PetDetailsViewController
        petDetailViewController.petsModel =  self.homeViewModel.petsModel?.pets?[indexPath.row]
        self.navigationController?.pushViewController(petDetailViewController, animated: true)
    }
    
}
