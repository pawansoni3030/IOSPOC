//
//  CreatUserAndVerifyViewController.swift
//  StepWell
//
//  Created by Pawan on 26/01/23.
//
import UIKit
import FirebaseAuth
import FirebaseFirestore

var defaults = UserDefaults.standard

class EmailVerifiAndCreateUserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var UserFirstName: UITextField!
    @IBOutlet weak var UserLastName: UITextField!
    @IBOutlet weak var UserEmail: UITextField!
    @IBOutlet weak var UserPhone: UITextField!
    @IBOutlet weak var UserPassword: UITextField!
    @IBOutlet weak var ReUserPassword: UITextField!
    @IBOutlet weak var CreateUserButton: UIButton!
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var countrySearchBar: UISearchBar!
    @IBOutlet weak var digitCodePopUpView: UIView!
    @IBOutlet weak var countryDigitCodeButton: UIButton!
    var countryData = [CountryData.Country]()
    var searchedCountry = [CountryData.Country]()
    var searching = false
    public static var indexAtRow: Int? = nil
    var countryDialCode: String = "+91" //default country digitCode
    override func viewDidLoad(){
        super.viewDidLoad()
        SetUpEnvironment()
    }
    @IBAction func onClickCreatUserButton(_ sender: Any) {
        let Error = validateFields()
        if Error != nil{
            showAlert(alertTitle: "Error", Error!)
        } else {   //Creating fresh data
            let userFirstName = UserFirstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let userLastName = UserLastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            var userPhone = UserPhone.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let userEmail = UserEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let userPassword = UserPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // Creating User using Email and Password
            userPhone = countryDialCode + userPhone
            print(userPhone)
            defaults.setValue(UserFirstName.text, forKey: "firstname")
            defaults.setValue(UserLastName.text, forKey: "lastName")
            defaults.setValue(UserEmail.text, forKey: "userMail")
            defaults.setValue(userPhone, forKey: "PhoneNumner")
            Auth.auth().createUser(withEmail: userEmail, password: userPassword) { ( AuthResult, Err) in
                if Err != nil {
                    let message = Err?.localizedDescription
                    self.showAlert(alertTitle: "Error", message!)}
                else{   // user is created , Store user data at fireStore
                    let  DB = Firestore.firestore() // creating a reference to firebase DataBase
                    DB.collection("UserAccountDetails").addDocument(data: ["First Name" : userFirstName as Any,"Last Name" : userLastName as Any,"Phone": userPhone as Any ,"Email": userEmail as Any,"UID" : AuthResult?.user.uid as Any]) { (ErrorInStoringData) in
                        if ErrorInStoringData != nil{
                            let errorInStoringUserData = ErrorInStoringData?.localizedDescription
                            self.showAlert(alertTitle: "Erorr", errorInStoringUserData!) }
                        else{
                            self.performSegue(withIdentifier: "ShowHome", sender: self)
                        } } } } } }
    func validateFields() -> String?{
        if UserPhone.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || UserFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || UserLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || UserEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || UserPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ReUserPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            self.showAlert(alertTitle: "Error", "Please Fill all Fields") }
        // check if password is same as ReEnterPassword
        else if UserPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines) != ReUserPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines){
            showAlert(alertTitle: "Error", "Password not Match") }
        return nil }
    func loadJsonFile(){
        guard let path = Bundle.main.path(forResource: "CountryData", ofType: "json") else{return}
        let url = URL(fileURLWithPath: path)
        do{
            let data = try Data(contentsOf: url)
            print(data)
            let country = try
            JSONDecoder().decode(CountryData.self, from: data)
            self.countryData = country.countryData
        } catch{ print(error) } }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchedCountry.count
        }
        else{
            return countryData.count}
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! CountryCodeCell
        if searching{
            Cell.countryFlagLabel.text = searchedCountry[indexPath.row].flag
            Cell.countryNameLabel.text = searchedCountry[indexPath.row].name
        }
        else{
            Cell.countryFlagLabel.text = countryData[indexPath.row].flag
            Cell.countryNameLabel.text = countryData[indexPath.row].name
        }
        return Cell }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching{
            EmailVerifiAndCreateUserViewController.indexAtRow = indexPath.row
            countryDigitCodeButton.titleLabel?.text = searchedCountry[indexPath.row].flag
            countryDialCode = searchedCountry[indexPath.row].dial_code ?? "+91"
            digitCodePopUpView.isHidden = true
        }else{
            EmailVerifiAndCreateUserViewController.indexAtRow = indexPath.row
            countryDigitCodeButton.titleLabel?.text = countryData[indexPath.row].flag
            countryDialCode = countryData[indexPath.row].dial_code ?? "+91"
            digitCodePopUpView.isHidden = true
        }        // close keyBoard when select cell
        self.countrySearchBar.searchTextField.endEditing(true)    }
    func SetUpEnvironment(){
        loadJsonFile()
        digitCodePopUpView.layer.cornerRadius = 24  //corner of popup
        digitCodePopUpView.isHidden = true
        countrySearchBar.showsCancelButton = true
        countryTableView.dataSource = self
        countryTableView.delegate = self
        countryTableView.rowHeight = 50
        countrySearchBar.delegate = self
    }
    @IBAction func showCountryList(_ sender: Any) {
        digitCodePopUpView.isHidden = false
    }
    @IBAction func onClickCancelPopUp(_ sender: Any) {
        digitCodePopUpView.isHidden = true
    }
}
extension EmailVerifiAndCreateUserViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedCountry = countryData.filter{
            $0.name!.lowercased().prefix(searchText.count) == searchText.lowercased() || $0.dial_code!.lowercased().prefix(searchText.count) == searchText.lowercased()
        }
        searching = true
        countryTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        countrySearchBar.text = ""
        countryTableView.reloadData()
    }
}
