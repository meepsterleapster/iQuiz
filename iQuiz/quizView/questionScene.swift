//
//  questionScene.swift
//  iQuiz
//
//  Created by George Lee on 5/10/25.
//

import UIKit

class questionScene: UIViewController {
    
    
    var quizTopic: QuizTopic!
    
    var questions : [String] = []
    var answer : Int = 0
    @IBOutlet weak var quizOptions: UIMenu!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var quizDropdown: UIButton!
    
    @IBAction func onSubmit(_ sender: Any) {
        performSegue(withIdentifier: "showAnswer", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = quizTopic.questions
        answer = quizTopic.answer
        
        var actions: [UIAction] = []

        for (index, question) in questions.enumerated() {
            let action = UIAction(title: question, handler: { _ in
                print("Selected question \(index): \(question)")
            })
            actions.append(action)
        }
        
        quizDropdown.menu = UIMenu(title: "", children: actions)
        quizDropdown.showsMenuAsPrimaryAction = true
       
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
