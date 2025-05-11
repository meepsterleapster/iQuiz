//
//  ViewController.swift
//  iQuiz
//
//  Created by George Lee on 5/3/25.
//

import UIKit
struct QuizTopic{
    var title : String
    var desc : String
    var imageName : String
    var questions : [String]
    var answer : Int
    var questionText : String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    
    let quizTopics: [QuizTopic] = [
        QuizTopic(
            title: "Mathematics",
            desc: "A test around your basic algebra skills",
            imageName: "Math",
            questions: [
                "4",
                "22",
                "An irrational number",
                "Nobody knows"
            ],
            answer: 0,
            questionText: "What is 2+2?"
        ),
        QuizTopic(
            title: "Marvel Super Heroes",
            desc: "A test on your understanding of Marvel Trivia",
            imageName: "Marvel",
            questions: [
                "Tony Stark",
                "Obadiah Stane",
                "A rock hit by Megadeth",
                "Nobody knows"
            ],
            answer: 0,
            questionText: "Who is Iron Man?"
        ),
        QuizTopic(
            title: "Science!",
            desc: "A test on your understanding of Science Concepts",
            imageName: "Science",
            questions: [
                "One of the four classical elements",
                "A magical reaction given to us by God",
                "A band that hasn't yet been discovered",
                "Fire! Fire! Fire! heh-heh"
            ],
            answer: 0,
            questionText: "What is fire?"
        )
    ]


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizTopics.count
    }
    
    var selectedQuizTopic : QuizTopic?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedQuizTopic = quizTopics[indexPath.row]
        performSegue(withIdentifier: "showQuiz", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuiz",
           let destinationVC = segue.destination as? questionScene {
            destinationVC.quizTopic = selectedQuizTopic
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = quizTable.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! quizCell
        cell.quizTitle.text = quizTopics[indexPath.row].title
        cell.quizDesc.text = quizTopics[indexPath.row].desc
        cell.quizImage.image = UIImage(named: quizTopics[indexPath.row].imageName)
        
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

