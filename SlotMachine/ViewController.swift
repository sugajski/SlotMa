//
//  ViewController.swift
//  SlotMachine
//
//  Created by Maciej Sugajski on 26.07.2016.
//  Copyright © 2016 Maciej Sugajski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //containers
    var firstContainer: UIView!
    var secondContainter: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    var slots: [[Slot]] = []
    
    //Stats
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    
    //buttons
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton: UIButton!
    
    //constant & variable values
    let kMarginForView:CGFloat = 10.0
    let kMarginForSlot:CGFloat = 2.0
    
    let kSixth:CGFloat = 1.0/6.0
    let kThird:CGFloat = 1.0/3.0
    
    let kHalf:CGFloat = 1.0/2.0
    let kEight:CGFloat = 1.0/8.0
    
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    
    var titleLabel: UILabel!
    
    // information labels
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    var creditsTitleLabel: UILabel!
    var betTitleLabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupContainerViews()
        setupFirstContainer(self.firstContainer)
//        setupSecondContainer(self.secondContainter)
        setupThirdContainer(self.thirdContainer)
        setupFourthContainer(self.fourthContainer)
        
        
        hardReset()
        
        
        
//        //showing the difference between using class func and normal func from class
//        //class func
//        Factory.createSlots()
//        
//        //normal func from class
//        var factoryInstance = Factory()
//        factoryInstance.createSlot()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions
    
    func resetButtonPressed (button: UIButton) {
        hardReset()
    }
    
    func betOneButtonPressed (button: UIButton) {
        print("Wcisnales bet one button")
    }
    
    func betMaxButtonPressed (button: UIButton) {
        print("Wcisnales bet max button")
    }
    
    func spinButtonPressed (button: UIButton) {
        removeSlotImageViews()
        slots = Factory.createSlots()
        setupSecondContainer(self.secondContainter)
    }
    
    func setupContainerViews () {
        
        //first container
        self.firstContainer = UIView(frame: CGRect(x:self.view.bounds.origin.x + kMarginForView, y:self.view.bounds.origin.y, width:self.view.bounds.width - (kMarginForView * 2), height:self.view.bounds.height * kSixth))
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.firstContainer)
        
        //second container
        self.secondContainter = UIView(frame: CGRect(x:self.view.bounds.origin.x + kMarginForView, y:firstContainer.frame.height, width:self.view.bounds.width - (kMarginForView * 2), height:self.view.bounds.height * (3 * kSixth)))
        self.secondContainter.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainter)
        
        //third container
        self.thirdContainer = UIView(frame: CGRect(x:self.view.bounds.origin.x + kMarginForView, y:firstContainer.frame.height + secondContainter.frame.height, width:self.view.bounds.width - (kMarginForView * 2), height:self.view.bounds.height * kSixth))
        self.thirdContainer.backgroundColor = UIColor.grayColor()
        self.view.addSubview(self.thirdContainer)
        
        //fourth container
        self.fourthContainer = UIView(frame: CGRect(x:self.view.bounds.origin.x + kMarginForView, y:firstContainer.frame.height + secondContainter.frame.height + thirdContainer.frame.height, width:self.view.bounds.width - (kMarginForView * 2), height:self.view.bounds.height * kSixth))
        self.fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.fourthContainer)

    }
    
    func setupFirstContainer (containerView: UIView) {
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size:40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center
        containerView.addSubview(self.titleLabel)
    }
    
    func setupSecondContainer (containerView: UIView) {
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                
                var slot:Slot
                var slotImageView = UIImageView()
                
                if slots.count != 0 {
                    let slotContainer = slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                }
                else{
                    slotImageView.image = UIImage(named:"Ace")
                }
                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRect(x:containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(containerNumber) * kThird), y:containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat(slotNumber) * kThird), width:containerView.bounds.width * kThird - kMarginForSlot, height:containerView.bounds.height * kThird - kMarginForSlot)
                containerView.addSubview(slotImageView)
            }
        }
    }
    
    func setupThirdContainer (containerView: UIView) {
        
        //creditsLabel
        self.creditsLabel = UILabel()
        self.creditsLabel.text = "000000"
        self .creditsLabel.textColor = UIColor.redColor()
        self.creditsLabel.font = UIFont(name:"Menlo-Bold", size:16)
        self.creditsLabel.sizeToFit()
        self.creditsLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditsLabel)
        
        //betLabel
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self .betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name:"Menlo-Bold", size:16)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.betLabel)
        
        //winnerPaidLabel
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self .winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name:"Menlo-Bold", size:16)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.winnerPaidLabel)
        
        //creditsTitleLabel
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.text = "Credits"
        self .creditsTitleLabel.textColor = UIColor.blackColor()
        self.creditsTitleLabel.font = UIFont(name:"AmericanTypewriter", size:14)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.creditsTitleLabel)
        
        //betTitleLabel
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet"
        self .betTitleLabel.textColor = UIColor.blackColor()
        self.betTitleLabel.font = UIFont(name:"AmericanTypewriter", size:14)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.betTitleLabel)
        
        //winnerPaidTitleLabel
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "Winner Paid"
        self .winnerPaidTitleLabel.textColor = UIColor.blackColor()
        self.winnerPaidTitleLabel.font = UIFont(name:"AmericanTypewriter", size:14)
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.winnerPaidTitleLabel)
    }
    
    
    func setupFourthContainer (containerView: UIView) {
        
        //reset button
        self.resetButton = UIButton()
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
        self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size:12)
        self.resetButton.backgroundColor = UIColor.lightGrayColor()
        self.resetButton.sizeToFit()
        self.resetButton.center = CGPoint(x: containerView.frame.width * kEight, y: containerView.frame.height * kHalf)
        self.resetButton.addTarget(self, action: #selector(ViewController.resetButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(resetButton)
        
        //bet one button
        self.betOneButton = UIButton()
        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size:12)
        self.betOneButton.backgroundColor = UIColor.greenColor()
        self.betOneButton.sizeToFit()
        self.betOneButton.center = CGPoint(x: containerView.frame.width * kEight * 3, y: containerView.frame.height * kHalf)
        self.betOneButton.addTarget(self, action: #selector(ViewController.betOneButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betOneButton)
        
        //bet max button
        self.betMaxButton = UIButton()
        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size:12)
        self.betMaxButton.backgroundColor = UIColor.redColor()
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPoint(x: containerView.frame.width * kEight * 5, y: containerView.frame.height * kHalf)
        self.betMaxButton.addTarget(self, action: #selector(ViewController.betMaxButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betMaxButton)
        
        //spin button
        self.spinButton = UIButton()
        self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size:12)
        self.spinButton.backgroundColor = UIColor.redColor()
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPoint(x: containerView.frame.width * kEight * 7, y: containerView.frame.height * kHalf)
        self.spinButton.addTarget(self, action: #selector(ViewController.spinButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(spinButton)
    }
    
    
    func removeSlotImageViews () {
            let container: UIView? = self.secondContainter
            let subViews:Array? = container!.subviews
            for view in subViews! {
                view.removeFromSuperview()
        }
    }
    
    func hardReset() {
        removeSlotImageViews()
        slots.removeAll(keepCapacity: true)
        self.setupSecondContainer(secondContainter)
        credits = 50
        winnings = 0
        currentBet = 0
        
        updateMainView()
    }
    
    func updateMainView () {
        self.creditsLabel.text = "\(credits)"
        self.betLabel.text = "\(currentBet)"
        self.winnerPaidLabel.text = "\(winnings)"
    }
    
    func showAlertWithText (header: String = "Warning", message : String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    // alert.addAction(UIAlertAction(title: "ok", style: UIAlertViewStyle.Default, handler: nil)))
}

