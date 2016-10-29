//
//  ViewController.swift
//  Retro-Calculator
//
//  Created by Darshan Gowda on 29/10/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var btnSound : AVAudioPlayer!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    enum Operation : String {
    
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
        
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var result  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(sender : UIButton){
    
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
        
    }
    
    func processOperation(operation : Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if(runningNumber != ""){
             
                rightValString = runningNumber
                runningNumber = ""
                
                if(currentOperation == Operation.Divide){
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                }else if (currentOperation == Operation.Multiply){
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                }else if (currentOperation == Operation.Add){
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }else if (currentOperation == Operation.Subtract){
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                }
                
                leftValString = result
                outputLabel.text = result
            
            }
            
            currentOperation = operation
            
        }else {
        
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
            
        }
        
    }
    
    @IBAction func onDividePressed(sender : AnyObject){
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender : AnyObject){
        processOperation(operation: Operation.Multiply)
    }
    
    @IBAction func onAddPressed(sender : AnyObject){
        processOperation(operation: Operation.Add)
    }
    
    @IBAction func onSubtractPressed(sender : AnyObject){
        processOperation(operation: Operation.Subtract)
    }
    
    @IBAction func onEqualPressed(sender : AnyObject){
    
        processOperation(operation: currentOperation)
        
    }
    
}

