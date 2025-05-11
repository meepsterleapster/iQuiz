//
//  answerScene.swift
//  iQuiz
//
//  Created by George Lee on 5/10/25.
//

import UIKit

class answerScene: UIViewController {

    @IBOutlet weak var answerText: UILabel!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "nextQuestion", sender: self)
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
