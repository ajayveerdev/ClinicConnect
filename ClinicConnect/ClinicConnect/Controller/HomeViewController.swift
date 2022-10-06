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
        let frame = CGRect(x: self.view.frame.width/2 - 20, y:  self.view.frame.height/2 - 20, width: 20, height: 20)
        addActivityIndicator(style: .medium, view: self.view, frame: frame)
        homeViewModel.getConfigData { [weak self] in
            DispatchQueue.main.async {
                showActivityIndicator(show: false)
                self?.tblPetDetails.reloadData()
                self?.btnChat.isHidden = !(self?.homeViewModel.settingsModel?.settings?.isChatEnabled ?? true)
                self?.btnCall.isHidden = !(self?.homeViewModel.settingsModel?.settings?.isCallEnabled ?? true)
                
                if self?.homeViewModel.settingsModel?.settings?.isChatEnabled ?? true || self?.homeViewModel.settingsModel?.settings?.isCallEnabled ?? true {
                    self?.btnStackView.isHidden = false
                } else{
                    self?.btnStackView.isHidden = true
                }
                self?.lblOfficeHours.text = "\(Constants.officeHours) \(self?.homeViewModel.settingsModel?.settings?.workHours ?? "")"
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
        getOfficeHours(vc: self)
    }
    
    @IBAction func btnCallTapped(_ sender: Any) {
        getOfficeHours(vc: self)
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
