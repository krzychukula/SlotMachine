//
//  ViewController.swift
//  SlotMachine
//
//  Created by Krzysztof Kula on 18/12/14.
//  Copyright (c) 2014 Krzysztof Kula. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    //1
    var titleLabel: UILabel!
    //3
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    var creditsTitleLabel: UILabel!
    var betTitleLabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    //4
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton: UIButton!
    
    
    //consts
    let kMarginForView: CGFloat = 10.0
    let kSixth:CGFloat = 1.0/6.0
    
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    let kThird:CGFloat = 1.0/3.0
    let kMarginForSlots:CGFloat = 2.0
    
    
    let kHalf:CGFloat = 1.0/2.0
    let kEight:CGFloat = 1.0/8.0
    
    //model
    var slots:[[Slot]] = []
    
    var credits = 0
    var currentBet = 0
    var winnings = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupContainerViews()
        setupFirstContainer(self.firstContainer)
        //
        setupThirdContainer(self.thirdContainer)
        setupFourthContainer(self.fourthContainer)
        
        hardReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions
    func resetButtonPressed(button: UIButton){
        println("resetButtonPressed")
        
        hardReset()
    }
    
    func betOneButtonPressed(button: UIButton){
        println("betOneButtonPressed")
        
        if credits <= 0 {
            showAlertWithText(header: "No More Credits", message: "Reset The Game")
        }else{
            if currentBet < 5 {
                currentBet += 1
                credits--
                updateMainView()
            }else{
                showAlertWithText(message: "You can only bet 5 credits at a time")
            }
        }
    }
    
    func betMaxButtonPressed(button:UIButton){
        println("bet max")
    }
    
    func spinButtonPressed(button:UIButton){
        println("spin")
        
        removeSlotImageViews()
        slots = Factory.createSlots()
        setupSecondContainer(self.secondContainer)
    }
    
    func setupContainerViews(){
        self.firstContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + kMarginForView,
            y: self.view.bounds.origin.y,
            width: self.view.bounds.width - (kMarginForView * 2),
            height: self.view.bounds.height * kSixth))
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.firstContainer)
        
        self.secondContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + kMarginForView,
            y: firstContainer.frame.height,
            width: self.view.bounds.width - (kMarginForView * 2),
            height: self.view.bounds.height * (3 * kSixth)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainer)
        
        self.thirdContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + kMarginForView,
            y: firstContainer.frame.height + secondContainer.frame.height,
            width: self.view.bounds.width - (kMarginForView * 2),
            height: self.view.bounds.height * kSixth))
        self.thirdContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.thirdContainer)
        
        self.fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView,
            y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height,
            width: self.view.bounds.width - (kMarginForView * 2),
            height: self.view.bounds.height * kSixth))
        self.fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.fourthContainer)
    }

    func setupFirstContainer(containerView:UIView){
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center
        containerView.addSubview(self.titleLabel)
    }
    
    func setupSecondContainer(containerView:UIView){
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                
                var slot:Slot
                var slotImageView = UIImageView()
                
                if slots.count != 0 {
                    let slotContainer = slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                }else{
                    slotImageView.image = UIImage(named: "Ace")
                }

                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRect(
                    x: containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(containerNumber) * kThird),
                    y: containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat(slotNumber) * kThird),
                    width: containerView.bounds.width * kThird - kMarginForSlots,
                    height: containerView.bounds.height * kThird - kMarginForSlots)
                containerView.addSubview(slotImageView)
            }
        }
    }
    
    func setupThirdContainer(containerView:UIView){
        self.creditsLabel = UILabel()
        self.creditsLabel.text = "000000"
        self.creditsLabel.textColor = UIColor.redColor()
        self.creditsLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.creditsLabel.sizeToFit()
        self.creditsLabel.center = CGPoint(
            x: containerView.frame.width * kSixth,
            y: containerView.frame.height * kThird)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditsLabel)
        
        self.betLabel = UILabel()
        self.betLabel.text = "000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(
            x: containerView.frame.width * kSixth * 3,
            y: containerView.frame.height * kThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.betLabel)
        
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self.winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPoint(
            x: containerView.frame.width * kSixth * 5,
            y: containerView.frame.height * kThird)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(winnerPaidLabel)
        
        
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.text = "Credits"
        self.creditsTitleLabel.textColor = UIColor.blackColor()
        self.creditsTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(
            x: containerView.frame.width * kSixth,
            y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.creditsTitleLabel)
        
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet"
        self.betTitleLabel.textColor = UIColor.blackColor()
        self.betTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3,
            y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.betTitleLabel)
        
        winnerPaidTitleLabel = UILabel()
        winnerPaidTitleLabel.text = "Winner Paid"
        winnerPaidTitleLabel.textColor = UIColor.blackColor()
        winnerPaidTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        winnerPaidTitleLabel.sizeToFit()
        winnerPaidTitleLabel.center = CGPoint(x: containerView.frame.width * 5 * kSixth, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(winnerPaidTitleLabel)
    }

    
    func setupFourthContainer(containerView: UIView){
        resetButton = UIButton()
        resetButton.setTitle("Reset", forState: UIControlState.Normal)
        resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        resetButton.backgroundColor = UIColor.lightGrayColor()
        resetButton.sizeToFit()
        resetButton.center = CGPoint(x: containerView.frame.width * kEight,
            y: containerView.frame.height * kHalf)
        resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.resetButton)
        
        betOneButton = UIButton()
        betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        betOneButton.titleLabel?.font = UIFont(name: "Superclarendenon-Bold", size: 12)
        betOneButton.backgroundColor = UIColor.greenColor()
        betOneButton.sizeToFit()
        betOneButton.center = CGPoint(x: containerView.frame.width * 3 * kEight, y: containerView.frame.height * kHalf)
        betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betOneButton)
        
        betMaxButton = UIButton()
        betMaxButton.setTitle("BetMax", forState: UIControlState.Normal)
        betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        betMaxButton.backgroundColor = UIColor.redColor()
        betMaxButton.sizeToFit()
        betMaxButton.center = CGPoint(x: containerView.frame.width * 5 * kEight, y: containerView.frame.height * kHalf)
        betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betMaxButton)
        
        spinButton = UIButton()
        spinButton.setTitle("Spin", forState: UIControlState.Normal)
        spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        spinButton.backgroundColor = UIColor.greenColor()
        spinButton.sizeToFit()
        spinButton.center = CGPoint(x: containerView.frame.width * 7 * kEight, y: containerView.frame.height * kHalf)
        spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(spinButton)
    }
    
    func removeSlotImageViews(){
        if self.secondContainer != nil {
            let container:UIView = self.secondContainer
            let subViews:Array? = container.subviews
            for view in subViews! {
                view.removeFromSuperview()
            }
        }
    }
    
    func hardReset(){
        removeSlotImageViews()
        slots.removeAll(keepCapacity: true)
        self.setupSecondContainer(self.secondContainer)
        credits = 50
        winnings = 0
        currentBet = 0
        
        updateMainView()
    }
    
    func updateMainView(){
        self.creditsLabel.text = "\(credits)"
        self.betLabel.text = "\(currentBet)"
        self.winnerPaidLabel.text = "\(winnings)"
    }
    
    func showAlertWithText(header:String = "Warning", message:String){
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

