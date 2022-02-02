//
//  FavoriteViewController.swift
//  NP
//
//  Created by Рушан Киньягулов on 01.12.2021.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    let favoriteView = FavoriteView()

    var isLoadingViewController = false

    var flats: [Flat] = []
    var favoriteFlats: [Flat] = []
    var favoriteFlatID: [Flat] = []
    var flatParser = FlatParser()

    override func loadView() {
        super.loadView()
        view = favoriteView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Избранное"
        flatParser.delegate = self
        flatParser.flatParse()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isLoadingViewController {
            isLoadingViewController = false
        } else {
            getFavoriteFlats()
        }
    }

    private func setupTableView() {
        view.addSubview(favoriteView.flatsTableView)
        favoriteView.flatsTableView.register(FlatsTableViewCell.self, forCellReuseIdentifier: Cell.tableViewCell)
        favoriteView.flatsTableView.delegate = self
        favoriteView.flatsTableView.dataSource = self
        favoriteView.flatsTableView.frame = view.safeAreaLayoutGuide.layoutFrame
    }

    func getFavoriteFlats() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let fetchRequest: NSFetchRequest<FavoriteFlat> = FavoriteFlat.fetchRequest()
        let context = appDelegate?.persistentContainer.viewContext
        favoriteFlats = []
        favoriteFlatID = []
        DispatchQueue.main.async {
            if let objects = try? context?.fetch(fetchRequest) {
                for object in objects {
                    self.favoriteFlatID = self.flats.filter { $0.flatID == object.flatID }
                    self.favoriteFlats.insert(contentsOf: self.favoriteFlatID, at: self.favoriteFlats.startIndex)
                }
                if !objects.isEmpty {
                    self.setupTableView()
                    self.favoriteView.flatsTableView.reloadData()
                } else {
                    self.favoriteView.flatsTableView.removeFromSuperview()
                }
            }
        }
    }
}
