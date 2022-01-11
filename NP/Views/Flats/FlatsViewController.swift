//
//  FlatsViewController.swift
//  NP
//
//  Created by Рушан Киньягулов on 17.12.2021.
//

import UIKit
import SnapKit
import CoreData

class FlatsViewController: UIViewController {
    
    let flatsView = FlatsView()
    
    private var flat: [Flat] = []
    private var favoriteFlat: [FavoriteFlat] = []
    
    init(flat: [Flat]) {
        self.flat = flat
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = flatsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControl()
        
        flatsView.photoCollectionView.delegate = self
        flatsView.photoCollectionView.dataSource = self
        
        setupData()
        setupPhotos()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkFlatIsFavorite(flatID: flat.first?.flatID ?? "")
    }
    
    func setupButtons() {
        flatsView.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        flatsView.reserveButton.addTarget(self, action: #selector(reserveButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupData() {
        guard let rooms = Int(flat.first?.roomsCount ?? "") else { return }
        if rooms == 1 {
            flatsView.titleLabel.text = "Квартира с 1-ой спальней"
        } else if rooms == 2 || rooms == 3 || rooms == 4 {
            flatsView.titleLabel.text = "Квартира с \(rooms)-мя спальнями"
        } else {
            flatsView.titleLabel.text = "Квартира с \(rooms)-ю спальнями"
        }
        let square = flat.first?.square
        flatsView.squareLabel.text = square ?? "" + " м²"
        flatsView.roomsLabel.text = flat.first?.roomsCount
        flatsView.wcRoomsLabel.text = flat.first?.wcCount
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ru_RU")
        let price = flat.first?.price ?? "0"
        flatsView.priceLabel.text = formatter.string(from: Int(price)! as NSNumber)?.replacingOccurrences(of: ",00", with: "")
        guard let pricePerMeter =  formatter.string(from: NSNumber(value: (price as NSString).floatValue / (square! as NSString).floatValue))?.replacingOccurrences(of: ",00", with: "") else { return }
        flatsView.pricePerMeterLabel.text = pricePerMeter + " за м²"
        flatsView.flatDescription.text = flat.first?.flatDescription
    }
    
    private func setupPhotos() {
        flatsView.activityIndicator.startAnimating()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            let photos = self.flat.first?.photo ?? []
            for (_, element) in photos.enumerated() {
                guard let imageURL = URL(string: element) else { return }
                let imageData: Data = try! Data(contentsOf: imageURL)
                self.flatsView.photos.append(UIImage(data: imageData)!)
            }
            DispatchQueue.main.async {
                self.flatsView.photoCollectionView.reloadData()
                self.flatsView.activityIndicator.stopAnimating()
                self.flatsView.pageContol.numberOfPages = self.flatsView.photos.count
                self.flatsView.pageContol.currentPage = 0
            }
        }
    }
    
    private func setupPageControl() {
        flatsView.pageContol.pageIndicatorTintColor = Color.brandGray
        flatsView.pageContol.currentPageIndicatorTintColor = Color.brandRed
        flatsView.pageContol.addTarget(self, action: #selector(pageControllerAction), for: .valueChanged)
    }
    
    @objc func pageControllerAction(_ sender: UIPageControl) {
        flatsView.photoCollectionView.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @objc func reserveButtonTapped(_ sender: UIButton) {
        let slideVC = FlatReserveViewController(flatID: flat.first?.flatID ?? "")
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Удалить" {
            deleteFavoriteFlat(flatID: flat.first?.flatID ?? "")
            sender.setTitle("В избранное", for: .normal)
        } else {
            sender.setTitle("Удалить", for: .normal)
            saveFavoriteFlat(flatID: flat.first?.flatID ?? "")
        }
    }
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    private func checkFlatIsFavorite(flatID: String) {
        let context = getContext()
        
        let fetchRequest: NSFetchRequest<FavoriteFlat> = FavoriteFlat.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                if object.flatID == flatID {
                    flatsView.favoriteButton.setTitle("Удалить", for: .normal)
                }
            }
        }
    }
    
    private func saveFavoriteFlat(flatID: String) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteFlat", in: context) else { return }
        let favoriteFlatObject = FavoriteFlat(entity: entity, insertInto: context)
        favoriteFlatObject.flatID = flatID
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func deleteFavoriteFlat(flatID: String) {
        let context = getContext()

        let fetchRequest: NSFetchRequest<FavoriteFlat> = FavoriteFlat.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                if object.flatID == flatID {
                    context.delete(object)
                }
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
