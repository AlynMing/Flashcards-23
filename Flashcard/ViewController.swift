//
//  ViewController.swift
//  Flashcard
//
//  Created by Yichen Zhu on 2/21/20.
//  Copyright © 2020 Yichen Zhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var buttonOptOne: UIButton!
    @IBOutlet weak var buttonOptTwo: UIButton!
    @IBOutlet weak var buttonOptThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        buttonOptOne.layer.cornerRadius = 20.0
        buttonOptTwo.layer.cornerRadius = 20.0
        buttonOptThree.layer.cornerRadius = 20.0
        buttonOptOne.clipsToBounds = true
        buttonOptTwo.clipsToBounds = true
        buttonOptThree.clipsToBounds = true
        buttonOptOne.layer.borderWidth = 3.0
        buttonOptOne.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        buttonOptTwo.layer.borderWidth = 3.0
        buttonOptTwo.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        buttonOptThree.layer.borderWidth = 3.0
        buttonOptThree.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
        creationController.initialQuestion = frontLabel.text
        creationController.initialAnswer = backLabel.text
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
    
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden == true) {
            frontLabel.isHidden = false
        } else {
            frontLabel.isHidden = true
        }
    }
    
    func UpdateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?) {
        frontLabel.text = question
        backLabel.text = answer

    buttonOptOne.setTitle(extraAnswerOne, for: .normal)
    buttonOptTwo.setTitle(answer, for: .normal)
    buttonOptThree.setTitle(extraAnswerTwo, for: .normal)
    }
    
    @IBAction func didTapOptOne(_ sender: Any) {
        buttonOptOne.isHidden = true
    }
    @IBAction func didTapOptTwo(_ sender: Any) {
        frontLabel.isHidden = true
    }
    @IBAction func didTapOptThree(_ sender: Any) {
        buttonOptThree.isHidden = true
    }
    
    
}

