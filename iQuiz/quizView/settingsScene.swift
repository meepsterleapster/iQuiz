//
//  settingsScene.swift
//  iQuiz
//
//  Created by George Lee on 5/17/25.
//

import UIKit

class settingsScene: UIViewController {
    var HTML = "http://tednewardsandbox.site44.com/questions.json"

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var checkForUpdatesButton: UIButton!
    
    @IBOutlet weak var textPlaceholder: UITextField!
       
       var defaultHTML = "http://tednewardsandbox.site44.com/questions.json"

       override func viewDidLoad() {
           super.viewDidLoad()
           
           textPlaceholder.text = defaultHTML
       }
    @IBAction func updateSource(_ sender: Any) {
        
        print(!textPlaceholder.text!.isEmpty)
        
        
        guard let url = URL(string: HTML) else {
            print("Invalid URL string: \(HTML)")
            return
        }

        spinner.startAnimating()

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()

                if let error = error {
                    print("Network error: \(error.localizedDescription)")
                            let alertController = UIAlertController(
                                title: "Error!",
                                message: "Network error: \(error.localizedDescription)",
                                preferredStyle: .alert
                            )
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let topics = try decoder.decode([QuizTopic].self, from: data)
                    ProvidedQuizSingleton.shared.quizTopics = topics
                    print("\(ProvidedQuizSingleton.shared.quizTopics)")
                } catch {
                    print("JSON decoding error: \(error.localizedDescription)")
                    let alertController = UIAlertController(
                        title: "Error!",
                        message: "JSON decoding error:  \(error.localizedDescription)",
                        preferredStyle: .alert
                    )
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
   
                }
            }
        }.resume()
    }
    
    

    @IBAction func onSourceChange(_ sender: Any) {
        
        HTML = textPlaceholder.text!
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
