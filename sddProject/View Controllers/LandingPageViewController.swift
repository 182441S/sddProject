import Foundation
import UIKit
import FirebaseAuth

class LandingPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate
{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    var wishlistItem = WishlistItem("", "", "", "", "", "")
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let path = itemList[indexPath.row]
        cell.textLabel?.text = "\(path.itemName)"
        
        return cell
    }
    
    func createSlides() -> [Slide] {
        
        let s1: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        s1.imageView.image = UIImage(named: "1")
        
        let s2: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        s2.imageView.image = UIImage(named: "2")
        
        let s3: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        s3.imageView.image = UIImage(named: "3")
        
        return [s1, s2, s3]
        
    }
    
    func slideScrollView(slides : [Slide]) {
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 450)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: 0)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
                
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: 0)
            scrollView.addSubview(slides[i])
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowItemDetails") {
            let itemDetailViewController = segue.destination as! ItemDetailViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow
            
            if (indexPath != nil) {
                let item = itemList[indexPath!.row]
                itemDetailViewController.item = item
            }
        }
    }
    
    var itemList : [Item] = []
    var wishlistItemList : [WishlistItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
//        Dummy Data
//        
//
//        itemList.append(Item("1", "Lightning to USB Cable (1m)", "An Apple cable meant for charging.", "Apple Cable (1m).jpg", "3 left"))
//
//        itemList.append(Item("2", "SYSTEMA Gum Care Toothbrush Compact (Soft) 2 + free 1 per pack", "System toothbrushes, new and unused.", "Systema Toothbrush.jpg", "5"))
//
//        itemList.append(Item("3", "Pringles Potato Chips (Sour Cream Onion)", "Pringles that are expiring in 4 months", "Pringles Sour Cream Onion.jpg", "3"))
        
        scrollView.delegate = self
        
        let slides = createSlides()
        slideScrollView(slides: slides)
        
//        DataManager.createItemDatabase()
        
        loadItems()
        
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationItem.leftBarButtonItem?.tintColor = .systemBackground
        
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.tintColor = .systemOrange
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Auth.auth().addStateDidChangeListener {
            
            (user, err) in
            
            if err == nil {
                _ = self.navigationController?.popViewController(animated: true)
            }
            
            else {
                if Auth.auth().currentUser != nil {
                    self.navigationItem.leftBarButtonItem?.isEnabled = true
                    self.navigationItem.leftBarButtonItem?.tintColor = .systemOrange
                    
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                    self.navigationItem.rightBarButtonItem?.tintColor = .systemBackground
                }
            }
        }
    }

    func loadItems() {
        DataManager.loadItems() {
            itemListFromFirestore in self.itemList = itemListFromFirestore

            self.tableView.reloadData()
        }
    }
    
//    No Reason To Delete From Main Item List
//
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let item = itemList[indexPath.row]
//            itemList.remove(at: indexPath.row)
//
//            DataManager.deleteItem(item)
//
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//
//        if editingStyle == .insert {
//            let item = itemList[indexPath.row]
//
//            WishlistDataManager.insertOrReplaceWishlistItem(item)
//        }
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
//            let item = self.itemList[indexPath.row]
//            self.itemList.remove(at: indexPath.row)
//
//            DataManager.deleteItem(item)
//
//            WishlistDataManager.deleteWishlistItem(item)
//
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
        
        let favourite = UITableViewRowAction(style: .normal, title: "Favourite") { (action, indexPath) in
            let item = self.itemList[indexPath.row]
            
            let email = Auth.auth().currentUser?.email
            
            self.wishlistItem.itemID = item.itemID
            self.wishlistItem.itemName = item.itemName
            self.wishlistItem.itemDesc = item.itemDesc
            self.wishlistItem.itemImage = item.itemImage
            self.wishlistItem.itemQuantity = item.itemQuantity
            self.wishlistItem.userID = email!
            
            WishlistDataManager.insertOrReplaceWishlistItem(self.wishlistItem)
        }
        
        favourite.backgroundColor = UIColor.blue
        
        if Auth.auth().currentUser != nil {
            return [favourite]
        }
        
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.tintColor = .systemBackground
            
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem?.tintColor = .systemOrange
        }
        
        catch let err as NSError {
            print("Cannot sign %@ out leh...", err)
        }
    }
}
