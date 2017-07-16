//
//  ViewController.swift
//  retroCalc
//
//  Created by Saul Rivera on 7/12/17.
//  Copyright © 2017 Dymtech. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        outputLbl.text = "0"
    }

    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        preocessOperaation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        preocessOperaation(operation: .Multiply)
    }
    
    @IBAction func onSubstractPressed(sender: AnyObject) {
        preocessOperaation(operation: .Substract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        preocessOperaation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        preocessOperaation(operation: currentOperation)
    }
    
    @IBAction func clear(sender: AnyObject) {
        currentOperation = Operation.Empty
        rightValStr = ""
        leftValStr = ""
        runningNumber = ""
        outputLbl.text = "0"
    }
    
    func preocessOperaation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Substract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            currentOperation = operation
        } else {
            leftValStr = (Double(runningNumber) != nil) ? runningNumber : "0"
            runningNumber = ""
            currentOperation = operation
        }
    }

}

