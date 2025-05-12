//
//  finishScene.swift
//  iQuiz
//
//  Created by George Lee on 5/10/25.
//

import UIKit

class finishScene: UIViewController {
    var quiz : CurrentQuiz!
    var finalScore: Int = 0
    var totalQuestions : Int = 0

    
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var performanceLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var IOSinBuiltBack: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let quiz = quiz else {
            fatalError("quiz not set")
        }

        
        navigationItem.hidesBackButton = true
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: "Home",
                style: .plain,
                target: self,
                action: #selector(goToRoot)
            )
        
       
        finalScore = quiz.score
        totalQuestions = quiz.questions.count

        scoreLabel.text = "You Got: \(finalScore), Out Of: \(totalQuestions)!"
        
        switch finalScore {
             case totalQuestions:
                 performanceLabel.text = "Perfect!"
             case (totalQuestions - 1)...:
                 performanceLabel.text = "Almost!"
             default:
                 performanceLabel.text = "Keep Practicing!"
             }
         }


    @IBAction func onReturnHome(_ sender: Any) {
        quiz = nil
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @objc func goToRoot() {
        navigationController?.popToRootViewController(animated: true)
        
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


