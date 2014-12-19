//
//  Factory.swift
//  SlotMachine
//
//  Created by Krzysztof Kula on 19/12/14.
//  Copyright (c) 2014 Krzysztof Kula. All rights reserved.
//

import Foundation
import UIKit

class Factory {
    class func createSlots() -> [[Slot]] {
        
        let kNumberOfSlots = 3
        let kNumberOfContainers = 3
        var slots:[[Slot]] = []
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            var slotsSubArray:[Slot] = []
            
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                
                var slot = Slot(value: 0, image: UIImage(named: ""), isRed: true)
                slotsSubArray.append(slot)
            }
            
            slots.append(slotsSubArray)
        }
        
        return slots
    }
}