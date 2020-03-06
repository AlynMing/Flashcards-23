//
//  CreationViewController.swift
//  Flashcard
//
//  Created by Yichen Zhu on 3/5/20.
//  Copyright © 2020 Yichen Zhu. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraAnswerOne: UITextField!
    @IBOutlet weak var extraAnswerTwo: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    var flashcardsController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let extraAnswerOneText = extraAnswerOne.text
        let extraAnswerTwoText = extraAnswerTwo.text

        if (questionText == nil || answerText == nil
            || questionText!.isEmpty || answerText!.isEmpty) {
            let alert =
                UIAlertController(title: "Missing text",
                                  message: "You need a question and/or answer",
                                  preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        } else {
        flashcardsController.UpdateFlashcard(question: questionText!,
                                             answer: answerText!,
                                             extraAnswerOne: extraAnswerOneText,
                                             extraAnswerTwo: extraAnswerTwoText)
        dismiss(animated: true)
        }
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
