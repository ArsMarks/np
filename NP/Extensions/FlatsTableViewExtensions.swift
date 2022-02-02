//
//  FlatsTableViewExtensions.swift
//  NP
//
//  Created by Рушан Киньягулов on 04.01.2022.
//

import UIKit

extension FlatsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        lazy var nilCell = UITableViewCell(style: .default, reuseIdentifier: Cell.tableViewCell)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.tableViewCell,
                                                       for: indexPath) as? FlatsTableViewCell else { return nilCell }
        let rooms = Int(flats[indexPath.row].roomsCount) ?? 0
        let square = (flats[indexPath.row].square as NSString).floatValue
        let floor = Int(flats[indexPath.row].floorCount) ?? 0
        let price = flats[indexPath.row].price
        let pricePerMeter = Int((price as NSString).floatValue / square)

        cell.setupFlatsInfo(rooms: rooms,
                            square: square,
                            floor: floor,
                            price: Int(price)!,
                            pricePerMeter: pricePerMeter)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flatsVC = FlatsViewController(flat: [flats[indexPath.row]])
        flatsVC.modalTransitionStyle = .partialCurl
        flatsVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(flatsVC, animated: true)
        flatsTableView.deselectRow(at: indexPath, animated: true)
    }
}
