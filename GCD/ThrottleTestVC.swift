//
//  ThrottleTestVC.swift
//  GCD
//
//  Created by Hiren Patel on 05/06/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class ThrottleTestVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var filteredData: [[String: AnyObject]] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var throttler: Throttler? = nil
    
    /// Throttling interval
    public var throttlingInterval: Double? = 3.0 {
        didSet {
            guard let interval = throttlingInterval else {
                self.throttler = nil
                return
            }
            self.throttler = Throttler(seconds: Int(interval))
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.throttlingInterval = 2.0
        activityIndicator.startAnimating()
        searchWithText("Grilled")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = (filteredData[indexPath.row]["brand_name"] as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    // This method updates filteredData based on the text in the Search Box
    fileprivate func searchWithText(_ searchText: String) {
        throttler?.throttler(searchText: searchText, completion:{ [weak self] (brands, error) in
            if brands != nil {
                if let brandDetails = brands! ["branded"] {
                    self?.filteredData = brandDetails as! [[String: AnyObject]]
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.activityIndicator.stopAnimating()
                        self?.activityIndicator.isHidden = true
                    }
                } else {
                    self?.filteredData.removeAll()
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.activityIndicator.stopAnimating()
                    }
                }
            }
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWithText(searchText)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
