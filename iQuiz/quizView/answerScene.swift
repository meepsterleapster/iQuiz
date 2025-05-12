//
//  answerScene.swift
//  iQuiz
//
//  Created by George Lee on 5/10/25.
//
import UIKit

class AnswerScene: UIViewController {

    var quiz: CurrentQuiz!
    var question: Question!
    var selectedAnswerIndex: Int!

    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var correctAnswerLabel: UILabel!
    
  
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: "Home",
                style: .plain,
                target: self,
                action: #selector(goToRoot)
            )
        
        
        questionLabel.text = question.text
        correctAnswerLabel.text = "Correct Answer: \(question.options[question.correctAnswerIndex])"
        if selectedAnswerIndex == question.correctAnswerIndex {
            resultLabel.text = "You were right!"
            resultLabel.textColor = .systemGreen
        } else {
            resultLabel.text = "You were wrong!"
            resultLabel.textColor = .systemRed
        }
    }

    @IBAction func onNext(_ sender: Any) {
        if quiz.currentQuestionIndex < quiz.questions.count-1 {
            quiz.advanceToNextQuestion()
            let nextQuestionVC = storyboard?.instantiateViewController(withIdentifier: "questionScene") as! QuestionScene
            nextQuestionVC.quiz = quiz
            navigationController?.pushViewController(nextQuestionVC, animated: true)
        } else {
            let finishVC = storyboard?.instantiateViewController(withIdentifier: "finishScene") as! finishScene
            finishVC.quiz = quiz
            navigationController?.pushViewController(finishVC, animated: true)
        }
    }
    
    @objc func goToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
