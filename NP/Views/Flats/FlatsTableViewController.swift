//
//  TableViewController.swift
//  NP
//
//  Created by Рушан Киньягулов on 16.12.2021.
//

import UIKit
import SnapKit

class FlatsTableViewController: UIViewController {
    
    private let flatsTableViewCell = FlatsTableViewCell()
    
    var flats: [Flat] = []
    
    let flatsTableView = UITableView()
    
    private let sortImageUp = UIImage(named: "priceSortUp")
    private let sortImageDown = UIImage(named: "priceSortDown")
    
    private let priceSortingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" По цене", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.tintColor = Color.brandRed
        button.sizeToFit()
        return button
    }()
    
    init(flats: [Flat]) {
        self.flats = flats
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setupRightBarButtonItem()
    }
    
    private func setupRightBarButtonItem() {
        let barButton = UIBarButtonItem(customView: priceSortingButton)
        navigationItem.rightBarButtonItem = barButton
        priceSortingButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        priceSortingButton.setImage(sortImageDown, for: .normal)
    }
    
    private func setupTableView() {
        view.addSubview(flatsTableView)
        flatsTableView.register(FlatsTableViewCell.self, forCellReuseIdentifier: Cell.tableViewCell)
        flatsTableView.delegate = self
        flatsTableView.dataSource = self
        flatsTableView.frame = view.bounds
    }
    
    @objc func rightButtonAction() {
        if priceSortingButton.imageView?.image == sortImageDown {
            flats = flats.sorted { $0.price < $1.price }
            priceSortingButton.setImage(sortImageUp, for: .normal)
        } else {
            flats = flats.sorted { $0.price > $1.price }
            priceSortingButton.setImage(sortImageDown, for: .normal)
            
        }

        flatsTableView.reloadData()
        flatsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}
