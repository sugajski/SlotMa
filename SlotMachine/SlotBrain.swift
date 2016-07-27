//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Maciej Sugajski on 27.07.2016.
//  Copyright © 2016 Maciej Sugajski. All rights reserved.
//

import Foundation

class SlotBrain {
    
    class func unpackSlotIntoSlotRows (slots: [[Slot]]) -> [[Slot]] {
        var slotRow: [Slot] = []
        var slotRow2: [Slot] = []
        var slotRow3: [Slot] = []
        
        for slotArray in slots {
            for var index = 0; index < slotArray.count; ++index {
                let slot = slotArray[index]
                if index == 0 {
                    slotRow.append(slot)
                }
                else if index == 1 {
                    slotRow2.append(slot)
                }
                else if index == 2 {
                    slotRow3.append(slot)
                }
                else {
                    print("Error")
                }
            }
        }
        var slotsInRows: [[Slot]] = [ slotRow, slotRow2, slotRow3 ]
        
        return slotsInRows
    }
    
    
    class func computeWinnings (slots: [[Slot]]) -> Int {
        var slotsInRows = unpackSlotIntoSlotRows(slots)
        var winnings = 0
        
        var flushWinCount = 0
        var threeOfAKindWinCount = 0
        var straightWinCount = 0
        
        for slotRow in slotsInRows {
            if checkFlush(slotRow) == true {
                print("Flush")
                winnings += 1
                flushWinCount += 1
            }
            
            if checkThreeInARow(slotRow) == true {
                print("Three in a row!")
                winnings += 1
                straightWinCount += 1
            }
            
            if checkThreeOfAKind(slotRow) == true {
            print("Three of a kind!")
                winnings  += 50
            }
        }
        
        if flushWinCount == 3 {
            print("Royal Flush!")
            winnings += 15
        }
        
        if straightWinCount == 3 {
            print("Epic Straight!")
            winnings += 1000
        }
        
        return winnings
    }
    
    
    class func checkFlush (slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.isRed == true && slot2.isRed == true && slot3.isRed == true {
            return true
        }
        else if slot1.isRed == false && slot2.isRed == false && slot3.isRed == false{
            return true
        }
        else{
            return false
        }

    }
    
    
    class func checkThreeInARow (slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.value == slot2.value - 1 && slot1.value == slot3.value - 2 {
        return true
        }
        else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2 {
            return true
        }
        else{
        return false
        }
    }
    
    
    class func checkThreeOfAKind(slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.value == slot2.value && slot1.value == slot3.value {
            return true
        }
        else{
            return false
        }
    }
}
