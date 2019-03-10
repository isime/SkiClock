//
//  AllSkisController.swift
//  SkiClock
//
//  Created by Ian Sime on 3/8/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class AllSkisController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let animals = ["Cat", "Dog", "Cow", "Mulval"]
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell"/*Identifier*/, for: indexPath as IndexPath)
        cell.textLabel?.text = animals[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
