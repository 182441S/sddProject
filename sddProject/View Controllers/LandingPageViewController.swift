import Foundation
import UIKit

class LandingPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate
{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    
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
        
        if (segue.identifier == "TempAddItem") {
            let tempAddItemViewController = segue.destination as! TempAddItemViewController
            let item = Item("", "", "", "", "")
            tempAddItemViewController.item = item
        }
    }
    
    var itemList : [Item] = []
    
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
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
//        DataManager.createItemDatabase()
        
        loadItems()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        loadItems()
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemList[indexPath.row]
            itemList.remove(at: indexPath.row)

            DataManager.deleteItem(item)

            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
