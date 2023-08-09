import UIKit
import SwiftyJSON

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var ContactListTabelView: UITableView!
    var ContactArray = [Contact(Name: "Pawan", Position: "Software Developer", Phone: "9953644655",Email: "pawan3030@gmail.com" ,ProfileImage: #imageLiteral(resourceName: "Gary")),Contact(Name: "Naina", Position: "Project Manager", Phone: "9997245320",Email: "Naina2000@gmail.com", ProfileImage: #imageLiteral(resourceName: "Rebecca")),Contact(Name: "Arpit", Position: "Business Analytic", Phone: "8790645321",Email: "Arpit2000@gmail.com", ProfileImage: #imageLiteral(resourceName: "Tyler")),Contact(Name: "Riya", Position: "DataBase Eng", Phone: "7869504231", Email: "Riya2001@gmail.com",ProfileImage: #imageLiteral(resourceName: "Madison")),Contact(Name: "Simran", Position: "Marketing Head", Phone: "9801726354",Email: "Simran1999@gmail.com", ProfileImage: #imageLiteral(resourceName: "Katherine"))]
    public static var ContactRowDataIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactListTabelView.dataSource = self
        ContactListTabelView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ContactArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ContactData = ContactArray[indexPath.row]
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Contactcell", for: indexPath) as! ContactCell
        Cell.accessoryType = .disclosureIndicator
        Cell.ContactNameLabel?.text = ContactData.Name
        Cell.ContactProfileLabel?.text = ContactData.Position
        Cell.ContactProfilePhoto?.image = ContactData.ProfileImage
        return Cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ViewController.ContactRowDataIndex = indexPath.row
        performSegue(withIdentifier: "ContactProfile", sender: self)
        
    }
    
}
