//
//  ViewController.swift
//  Calculator
//
//  Created by lzmhhh123 on 2017/8/28.
//  Copyright © 2017年 lzmhhh123. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain.addUnaryOperation(named: "✅") { [weak self] in
            self?.display.textColor = UIColor.green
            return sqrt($0)
        }
    }
    
    var userHaveTheDot = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            if userHaveTheDot == false || digit != "." {
                display.text = textCurrentlyInDisplay + digit
            }
            if digit == "." {
                userHaveTheDot = true
            }
        } else {
            if digit == "." {
                display.text = "0."
                userIsInTheMiddleOfTyping = true
            } else {
                display.text = digit
            }
            if displayValue != 0 {
                userIsInTheMiddleOfTyping = true
            }
        }
    }

    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
            userHaveTheDot = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
        
    }
    
}

