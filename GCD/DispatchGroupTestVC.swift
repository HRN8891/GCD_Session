//
//  DispatchGroupTestVC.swift
//  GCD
//
//  Created by Hiren Patel on 30/05/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit


class UserManager: NSObject {
    
    let user: User = User()
    let userId: NSNumber = 2

    static let instance: UserManager = UserManager()
    class var shared: UserManager {
        return instance
    }
}


class DispatchGroupTestVC: UIViewController {
    
    let group = DispatchGroup()
    @IBOutlet weak var firstGroupTaskLabel: UILabel!
    @IBOutlet weak var secondGroupTaskLabel: UILabel!
    @IBOutlet weak var thirdGroupTaskLabel: UILabel!

    let userManager: UserManager = UserManager.shared
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
    }
    
    func basicGroupUnderstanding() {
        
        let concurrentQueue = DispatchQueue(label: "com.gcd.concurrentQueue", qos: .userInitiated, attributes: [.concurrent])
        
//        let serialQueue = DispatchQueue(label: "com.gcd.serialQueue", qos: .userInitiated)
        
//        let firstQueue = DispatchQueue(label: "com.gcd.firstQueue", qos: .userInitiated, attributes: [.concurrent])
//        let secondQueue = DispatchQueue(label: "com.gcd.secondQueue", qos: .userInitiated, attributes: [.concurrent])
//        let thirdQueue = DispatchQueue(label: "com.gcd.thirdQueue", qos: .userInitiated, attributes: [.concurrent])
        
        
        let firstGroupTask = DispatchWorkItem { [weak self] in
            print(" firstGroupTask is start")
            DispatchQueue.main.async {
                self?.firstGroupTaskLabel.text = "firstGroupTask is start"
                self?.firstGroupTaskLabel.backgroundColor = UIColor.green
            }
            sleep(4)
            DispatchQueue.main.async {
                self?.firstGroupTaskLabel.text = "firstGroupTask is done"
                self?.firstGroupTaskLabel.backgroundColor = UIColor.yellow

            }
            print(" firstGroupTask is done")
            self?.group.leave()

        }
        
        let secondGroupTask = DispatchWorkItem { [weak self] in
            print(" secondGroupTask is start")
            DispatchQueue.main.async {
                self?.secondGroupTaskLabel.text = "secondGroupTask is start"
                self?.secondGroupTaskLabel.backgroundColor = UIColor.green

            }
            sleep(3)
            DispatchQueue.main.async {
                self?.secondGroupTaskLabel.text = "secondGroupTask is done"
                self?.secondGroupTaskLabel.backgroundColor = UIColor.yellow

            }
            print(" secondGroupTask is done")
            self?.group.leave()

        }
        
        let thirdGroupTask = DispatchWorkItem { [weak self] in
            print(" thirdGroupTask is start")
            DispatchQueue.main.async {
                self?.thirdGroupTaskLabel.text = "thirdGroupTask is start"
                self?.thirdGroupTaskLabel.backgroundColor = UIColor.green

            }
            sleep(2)
            DispatchQueue.main.async {
                self?.thirdGroupTaskLabel.text = "thirdGroupTask is done"
                self?.thirdGroupTaskLabel.backgroundColor = UIColor.yellow

            }
            print(" thirdGroupTask is done")
            self?.group.leave()
        }
        
        
        let tasks = [firstGroupTask, secondGroupTask, thirdGroupTask]

        for task in tasks {
            group.enter()
            concurrentQueue.async(execute: task )
        }
        
//        group.enter()
//         serialQueue.async(execute: firstGroupTask)
//
//         group.enter()
//         serialQueue.async(execute: secondGroupTask)
//
//         group.enter()
//         serialQueue.async(execute: thirdGroupTask)
        
        
      
        
        // If we want to wait only for the specific time interval than we can use following this.
        //        let deadline = DispatchTime.now() + .seconds(5)
        //        let result = group.wait(timeout: deadline)
        //        print(result.hashValue)
        
        
        // This will wait to complete all the task. This function will block the current thread.
//        group.wait()
//        print("All task is done")
//
        
        group.notify(queue: DispatchQueue.main) {
            print("All task is done")
        }
    }
    
    fileprivate func groupWithMultipleOperations() {
        let firstQueue = DispatchQueue(label: "com.gcd.firstQueue", qos: .userInitiated, attributes: [.concurrent])
        let secondQueue = DispatchQueue(label: "com.gcd.secondQueue", qos: .userInitiated, attributes: [.concurrent])
        let thirdQueue = DispatchQueue(label: "com.gcd.thirdQueue", qos: .userInitiated, attributes: [.concurrent])
        
        
        let firstGroupTask = DispatchWorkItem { [weak self] in
            print(" Fetching user information")
            ApiManager.shared.getUserInformation(group: (self?.group)!)
        }
        
        let secondGroupTask = DispatchWorkItem { [weak self] in
            print(" secondGroupTask is start")
            self?.group.leave()
            
        }
        
        let thirdGroupTask = DispatchWorkItem { [weak self] in
            print(" Fetching post information")
            ApiManager.shared.getAllPosts(group: (self?.group)!)
        }
        
        group.enter()
        firstQueue.async(execute: firstGroupTask)
        
        group.enter()
        secondQueue.async(execute: secondGroupTask)
        
        group.enter()
        thirdQueue.async(execute: thirdGroupTask)
        
        
        
        // This will notify the group on the respective queue that all task has been completed.
        group.notify(queue: DispatchQueue.main) {
            print("\n======User Detail ======\n")
            print(self.userManager.user.name ?? "")
            print(self.userManager.user.email ?? "")
            print(self.userManager.user.username ?? "")
            print(self.userManager.user.phone ?? "")
            print("\n========================\n")

            print("\n======User Post Detail ======\n")
            print("User has \(self.userManager.user.posts.count) post available")
            print("\n========================\n")
            print("All task is done")

        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func groupApi(sender: UIButton) {
        groupWithMultipleOperations()
    }
    
    @IBAction func groupBasic(sender: UIButton) {
        basicGroupUnderstanding()
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




class User: NSObject {
    
    var name: String?
    var email: String?
    var address: String?
    var username: String?
    var phone: String?
    var posts: [Post] = []
    
    override init() {
        
    }
    func configureUserDetail(userDetail: [String: AnyObject]) {
        self.name = userDetail["name"] as? String
        self.email = userDetail["email"] as? String
        self.address = userDetail["address"] as? String
        self.username = userDetail["username"] as? String
        self.phone = userDetail["phone"] as? String
    }
    override  var description: String  {
        var description = ""
        description += "name is \(self.name ?? "")\n"
        description += "email is \(self.email ?? "")\n"
        description += "address is \(self.address ?? "")\n"
        description += "username is \(self.username ?? "")\n"
        description += "phone is \(self.phone ?? "")\n"
        return description
    }
    
    
}


class Post: NSObject {
    
    var userId: String?
    var title: String?
    var id: String?
    
    override init() {
        
    }
    func configurePost(postDetail: [String: AnyObject]) {
        self.userId = postDetail["userId"] as? String
        self.title = postDetail["title"] as? String
        self.id = postDetail["id"] as? String
    }
}

class ApiManager: NSObject {
    
    static let instance: ApiManager = ApiManager()
    class var shared: ApiManager {
        return instance
    }
    
    
    func searchWithResult(searchText: String, completion:@escaping (_ brands: [String: AnyObject]?, _ error: Error?) -> ()) {
      
        let url : String = "https://trackapi.nutritionix.com/v2/search/instant?query=\(searchText)"
        print("Request : \(url)")
        let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        var request = URLRequest(url: URL.init(string: escapedString)!)
        request.httpMethod = "GET"
        request.setValue("ef928818", forHTTPHeaderField: "x-app-id")
        request.setValue("15354dd7a87bd29233fd8af834a83bf1", forHTTPHeaderField: "x-app-key")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if response != nil {
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion((json as! [String : AnyObject]), nil)
                }catch {
                    completion(nil, error)
                }
            }
            }.resume()
    }


    
    func getUserInformationForUserId(userID: String, completion:@escaping (_ user: User?, _ error: Error?) -> ()) {
        let url = URL(string: "http://jsonplaceholder.typicode.com/users/\(userID)")
        let session = URLSession.shared
        if let usableUrl = url {
            let task = session.dataTask(with: usableUrl, completionHandler: { (data, response, error) in
                if let data = data {
                    do {
                        let decoded = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictFromJSON = decoded as? [String:AnyObject] {
                            let user: User = User()
                            user.configureUserDetail(userDetail: dictFromJSON)
                            completion(user, nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            })
            task.resume()
        }
    }
    
    
    func getUserInformation(group: DispatchGroup?) {
        let url = URL(string: "http://jsonplaceholder.typicode.com/users/\(UserManager.shared.userId)")
        let session = URLSession.shared
        if let usableUrl = url {
            let task = session.dataTask(with: usableUrl, completionHandler: { (data, response, error) in
                if let data = data {
                    do {
                        let decoded = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dictFromJSON = decoded as? [String:AnyObject] {
                            UserManager.shared.user.configureUserDetail(userDetail: dictFromJSON)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                    if let groupObject = group {
                        groupObject.leave()
                    }
                }
            })
            task.resume()
        }
    }
    
    
    fileprivate func getAllPosts(group: DispatchGroup?) {
        let postUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")
        let postUrlsession = URLSession.shared
        if let postUrlsessionUsableUrl = postUrl {
            let task = postUrlsession.dataTask(with: postUrlsessionUsableUrl, completionHandler: { (data, response, error) in
                if let data = data {
                    do {
                        let decoded = try JSONSerialization.jsonObject(with: data, options: [])
                        if let allPosts = decoded as? [[String:AnyObject]] {
                            let userPosts:[[String:AnyObject]] = allPosts.filter{($0["userId"] as! NSNumber) == UserManager.shared.userId}
                            
                            if userPosts.count > 0 {
                                var posts: [Post] = []
                                for userPost in userPosts {
                                    let post: Post = Post()
                                    post.configurePost(postDetail: userPost)
                                    posts.append(post)
                                }
                                UserManager.shared.user.posts = posts
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                    if let groupObject = group {
                        groupObject.leave()
                    }
                }
            })
            task.resume()
        }
    }
}
