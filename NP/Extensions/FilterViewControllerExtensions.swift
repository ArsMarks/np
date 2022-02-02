//
//  FilterViewControllerExtensions.swift
//  NP
//
//  Created by Рушан Киньягулов on 04.01.2022.
//

import UIKit

extension FilterViewController: UITextFieldDelegate {

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        setupPriceAndSquare()
        filterLogic.flatsFiltered = []
        self.filterLogic.filterFlats(price: self.maxPriceFromTextField,
                                     square: self.minSquareFromTextField,
                                     buttonsDict: self.buttonsDict)
        setupFilterButton()
        return true
    }
}

extension FilterLogic: FlatParserDelegate {
    func updateFlats(_: FlatParser, with flats: [Flat]) {
        self.flats = flats
    }
}
