//
//  FavoritesListViewController.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 11/06/2021.
//

import UIKit
import Firebase

class FavoritesListViewController: UIViewController {
    
    @IBOutlet weak var favoriteListTable: UITableView!
    var backActionTapped: () -> Void = { print("backActionTapped is not overriden") }
    
    private var state = State(favoritesList: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        Database.database().isPersistenceEnabled = true
        
        favoriteListTable.delegate = self
        favoriteListTable.dataSource = self
        
        favoriteListTable.register(UINib(nibName: "FavoritesViewcellTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesViewcellTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getfavoritesList()
    }
    
    func getfavoritesList() {
        var weatherRef: DatabaseReference!        
        let userId = Auth.auth().currentUser?.uid ?? ""
        weatherRef = Database.database().reference()
        
        weatherRef.child("users").child(userId).child("favorites").observe(.value, with: { snapshot in
            if snapshot.exists() {
                for child in snapshot.children {
                    let value = child as! DataSnapshot
                    let valueDict = value.value as! [String: Any]
                    
                    self.state.favoritesList.append(CurrentWeatherModel(
                        dt: valueDict["dt"] as? String ?? "",
                        icon: valueDict["icon"] as? String ?? "",
                        main: valueDict["main"] as? String ?? "",
                        max_temp: valueDict["max_temp"] as? String ?? "",
                        min_temp: valueDict["min_temp"] as? String ?? "",
                        name: valueDict["name"] as? String ?? "",
                        temp: valueDict["temp"] as? String ?? ""))
                    self.favoriteListTable.reloadData()
                }
            }
        })
        
        weatherRef.keepSynced(true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        [self .dismiss(animated: true, completion: nil)]
    }
    
    struct State {
        var favoritesList: [CurrentWeatherModel]
    }

}

extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.state.favoritesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesViewcellTableViewCell", for: indexPath) as! FavoritesViewcellTableViewCell
        cell.configure(with: self.state.favoritesList[indexPath.row])
        return cell
    }
}
