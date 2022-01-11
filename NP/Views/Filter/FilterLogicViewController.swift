//
//  FilterLogic.swift
//  NP
//
//  Created by Рушан Киньягулов on 12.12.2021.
//

import UIKit

class FilterLogic {
    var flatParser = FlatParser()
    var flats: [Flat] = []
    var maxPrice: Float? = 0
    var minSquare: Float? = 0
    var flatsFiltered: [Flat] = []
    
    func setupFlats() {
        flatParser.flatParse()
        flatParser.delegate = self
    }
    
    func calculateMinPriceAndSquare() {
        DispatchQueue.main.async {
            let maxPrice = self.flats.max { $0.price < $1.price }?.price ?? "0"
            let minSquare = self.flats.min { ($0.square as NSString).floatValue < ($1.square as NSString).floatValue }?.square ?? "0"
            self.maxPrice = (maxPrice as NSString).floatValue
            self.minSquare = (minSquare as NSString).floatValue
            }
        }
    
    func filterFlats(price: Float, square: Float, buttonsDict: [String: Bool]) {
        DispatchQueue.main.async {
            if buttonsDict["Студия"] == true {
                
            }
            if buttonsDict["1"] == true {
                let filter = self.flats.filter { Int($0.roomsCount) == 1 }
                self.flatsFiltered.append(contentsOf: filter)
            }
            if buttonsDict["2"] == true {
                let filter = self.flats.filter { Int($0.roomsCount) == 2 }
                self.flatsFiltered.append(contentsOf: filter)
            }
            if buttonsDict["3"] == true {
                let filter = self.flats.filter { Int($0.roomsCount) == 3 }
                self.flatsFiltered.append(contentsOf: filter)
            }
            if buttonsDict["4"] == true {
                let filter = self.flats.filter { Int($0.roomsCount) == 4 }
                self.flatsFiltered.append(contentsOf: filter)
            }
            if buttonsDict["    4+    "] == true {
                let filter = self.flats.filter { Int($0.roomsCount) ?? 0 >= 5 }
                self.flatsFiltered.append(contentsOf: filter)
            }
            if buttonsDict.values.isEmpty {
                let filter = self.flats
                self.flatsFiltered.append(contentsOf: filter)
            }
            let filter = self.flatsFiltered.filter {
                ($0.square as NSString).floatValue >= square &&
                ($0.price as NSString).floatValue <= Float(price)
            }
            self.flatsFiltered = filter
        }
    }
}
