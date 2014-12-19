//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Krzysztof Kula on 19/12/14.
//  Copyright (c) 2014 Krzysztof Kula. All rights reserved.
//

import Foundation

class SlotBrain {
    class func unpackSlotIntoSlotRows (slots: [[Slot]]) -> [[Slot]] {
        var slotRow: [Slot] = []
        var slotRow2: [Slot] = []
        var slotRow3: [Slot] = []
        
        for slotArray in slots {
            for var index = 0; index < slotArray.count; index++ {
                let slot = slotArray[index]
                if index == 0 {
                    slotRow.append(slot)
                }else if index == 1 {
                    slotRow2.append(slot)
                }else if index == 2 {
                    slotRow3.append(slot)
                }
            }
        }
        
        return [slotRow, slotRow2, slotRow3]
    }
}