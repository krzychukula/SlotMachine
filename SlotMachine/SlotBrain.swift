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
    
    class func computeWinnings(slots: [[Slot]]) -> Int {
        var slotsInRows = unpackSlotIntoSlotRows(slots)
        var winnings = 0
        var flushWinCount = 0
        var threeOfAKindWinCount = 0
        var straightWinCount = 0
        for slotRow in slotsInRows {
            if checkFlush(slotRow) {
                println("flush")
                winnings++
                flushWinCount++
            }
            if flushWinCount == 3 {
                println("Royal Flush")
                winnings += 15
            }
            
            if checkThreeInARow(slotRow) {
                println("three in a row")
                winnings++
                straightWinCount++
            }
            if straightWinCount == 3 {
                println("Epic Straight")
                winnings += 1000
            }
            
            if checkThreeOfAKind(slotRow) {
                println("three of a kind")
                winnings += 3
                threeOfAKindWinCount++
            }
            if threeOfAKindWinCount == 3 {
                println("Threes all around")
                winnings += 50
            }
        }
        return winnings
    }
    
    class func checkFlush(slotRow:[Slot]) -> Bool {
        let one = slotRow[0]
        let two = slotRow[1]
        let three = slotRow[2]
        if one.isRed && two.isRed && three.isRed {
            return true
        }else if !one.isRed && !two.isRed && !three.isRed {
            return true
        }
        return false
    }
    
    class func checkThreeInARow (slotRow:[Slot]) -> Bool {
        let one = slotRow[0]
        let two = slotRow[1]
        let three = slotRow[2]
        
        if one.value == two.value - 1 && one.value == three.value - 2 {
                return true
        }else if one.value == two.value + 1 && one.value == three.value + 2 {
            return true
        }
        return false
    }
    
    class func checkThreeOfAKind (slotRow:[Slot]) -> Bool {
        let one = slotRow[0]
        let two = slotRow[1]
        let three = slotRow[2]
        
        if one.value == two.value && one.value == three.value {
            return true
        }
        return false
    }
}