//
//  ViewController.swift
//  iQuiz
//
//  Created by George Lee on 5/3/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let quizSections = ["Mathematics","Marvel Super Heroes","Science"]
    let quizDesc = ["A test around your basic algebra skills","A test on your understanding of Marvel Trivia","A test on your understanding of Science Concepts"]
    let quizImage = ["Math","Marvel","Science"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizSections.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = quizTable.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! quizCell
        cell.quizTitle.text = quizSections[indexPath.row]
        cell.quizDesc.text = quizDesc[indexPath.row]
        cell.quizImage.image = UIImage(named: quizImage[indexPath.row])
        
        cell.layoutIfNeeded()
        return cell
    }
    

    @IBAction func settingButton(_ sender: Any) {
            let alertController = UIAlertController(
                title: "Placeholder",
                message: "Settings go here",
                preferredStyle: .alert
            )

            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    
    
    
    
    @IBOutlet weak var quizTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        quizTable.delegate = self
        quizTable.dataSource = self
        quizTable.rowHeight =  100

    }


    
}

