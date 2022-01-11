//
//  FilterLogicViewController.swift
//  NP
//
//  Created by Рушан Киньягулов on 11.12.2021.
//

import Foundation

class FlatParser: NSObject {
    
    weak var delegate: FlatParserDelegate?
    
    var flat: [Flat] = []
    var elementName = ""
    var flatID = ""
    var buildingName: [String] = []
    var price = ""
    var square = ""
    var floorCount = ""
    var roomsCount = ""
    var wcCount = ""
    var flatDescription = ""
    var photo: [String] = []
    
    let urlQuote: URLComponents = {
        var resultURL = URLComponents()
        resultURL.scheme = "https"
        resultURL.host = "napetrovskom.ru"
        resultURL.path = "/cian.xml"
        return resultURL
    }()
    
    let session = URLSession.shared

    func flatParse() {
        guard let url = urlQuote.url else { return }
        let parser = XMLParser(contentsOf: url)
        parser?.delegate = self
        parser?.parse()
        DispatchQueue.main.async {
            self.delegate?.updateFlats(self, with: self.flat)
        }
    }
}
