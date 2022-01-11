//
//  FavoriteViewControllerExtensions.swift
//  NP
//
//  Created by Рушан Киньягулов on 04.01.2022.
//

import UIKit

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteFlats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.tableViewCell, for: indexPath) as! FlatsTableViewCell
        let rooms = Int(favoriteFlats[indexPath.row].roomsCount) ?? 0
        let square = (favoriteFlats[indexPath.row].square as NSString).floatValue
        let floor = Int(favoriteFlats[indexPath.row].floorCount) ?? 0
        let price = favoriteFlats[indexPath.row].price
        let pricePerMeter = Int((price as NSString).floatValue / square)
        
        cell.setupFlatsInfo(rooms: rooms, square: square, floor: floor, price: Int(price)!, pricePerMeter: pricePerMeter)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flatsVC = FlatsViewController(flat: [favoriteFlats[indexPath.row]])
        flatsVC.modalTransitionStyle = .partialCurl
        flatsVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(flatsVC, animated: true)
        favoriteView.flatsTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoriteViewController: FlatParserDelegate {
    func updateFlats(_: FlatParser, with flats: [Flat]) {
        self.flats = flats
    }
}

