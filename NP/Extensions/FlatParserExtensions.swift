//
//  FlatParserExtensions.swift
//  NP
//
//  Created by Рушан Киньягулов on 04.01.2022.
//

import UIKit

protocol FlatParserDelegate: AnyObject {
    func updateFlats(_: FlatParser, with flats: [Flat])
}

extension FlatParser: XMLParserDelegate {
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        if elementName == "object" {
            flatID = ""
            buildingName = []
            price = ""
            square = ""
            floorCount = ""
            roomsCount = ""
            wcCount = ""
            flatDescription = ""
            photo = []
        }
        self.elementName = elementName
    }

    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {

        if elementName == "object" {
            let flat = Flat(flatID: flatID,
                            buildingName: buildingName,
                            price: price,
                            square: square,
                            floorCount: floorCount,
                            roomsCount: roomsCount,
                            wcCount: wcCount,
                            flatDescription: flatDescription,
                            photo: photo)
            self.flat.append(flat)
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "ExternalId" {
                flatID += data
            } else if self.elementName == "Name" {
                buildingName += [data]
            } else if self.elementName == "Price" {
                price += data
            } else if self.elementName == "TotalArea" {
                square += data.replacingOccurrences(of: ",", with: ".")
            } else if self.elementName == "FloorNumber" {
                floorCount += data
            } else if self.elementName == "FlatRoomsCount" {
                roomsCount += data
            } else if self.elementName == "SeparateWcsCount" {
                wcCount += data
            } else if self.elementName == "Description" {
                flatDescription += data
            } else if self.elementName == "FullUrl" {
                photo += [data]
            }
        }
    }
}
