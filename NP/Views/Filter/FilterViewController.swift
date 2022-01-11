//
//  FilterViewController.swift
//  NP
//
//  Created by Рушан Киньягулов on 01.12.2021.
//

import UIKit
import SnapKit

class FilterViewController: UIViewController {
    
    let filterView = FilterView()
    
    let filterLogic = FilterLogic()
    
    var buttonsDict: [String: Bool] = [:]
    private var maxPrice = ""
    private var minSquare = ""
    var maxPriceFromTextField: Float = 0
    var minSquareFromTextField: Float = 0
    
    override func loadView() {
        super.loadView()
        view = filterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Подобрать квартиру"
        setupButtons()
        setupToolbarForTextField()
        filterView.squareTextField.delegate = self
        filterView.priceTextField.delegate = self
        setupFlats()
        setupFirstData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [filterView.priceView, filterView.squareView].forEach { views in
            views.layer.borderColor = Color.brandGray.cgColor
            views.layer.borderWidth = 0.5
            views.layer.cornerRadius = 3
        }
    }
    
    private func setupButtons() {
        let buttons = [filterView.studioRoomButton, filterView.oneRoomButton, filterView.twoRoomButton, filterView.threeRoomButton, filterView.fourRoomButton, filterView.fourPlusRoomButton]
        buttons.forEach { button in
            button.addTarget(self, action: #selector(roomButtonsTapped(sender:)), for: .touchUpInside)
        }
        
        filterView.filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        filterView.clearFilterButton.addTarget(self, action: #selector(clearFilterButtonTapped(sender:)), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @objc func doneClicked() {
        self.view.endEditing(true)
    }
    
    private func setupToolbarForTextField() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                            target: nil,
                                            action: nil)
        let doneButton = UIBarButtonItem(title: "Готово",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneClicked))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        [filterView.squareTextField, filterView.priceTextField].forEach { field in
            field.inputAccessoryView = toolbar
        }
    }
    
    @objc func roomButtonsTapped(sender: UIButton!) {
        guard let buttonName = sender.titleLabel?.text else { return }
        setupPriceAndSquare()
        if sender.backgroundColor == .systemBackground {
            sender.backgroundColor = Color.brandRed
            sender.setTitleColor(.white, for: .normal)
            buttonsDict.updateValue(true, forKey: buttonName)
            filterLogic.flatsFiltered = []
            self.filterLogic.filterFlats(price: self.maxPriceFromTextField, square: (self.minSquareFromTextField), buttonsDict: self.buttonsDict)
            setupFilterButton()
        } else {
            sender.backgroundColor = .systemBackground
            sender.setTitleColor(.label, for: .normal)
            buttonsDict.removeValue(forKey: buttonName)
            filterLogic.flatsFiltered = []
            self.filterLogic.filterFlats(price: self.maxPriceFromTextField, square: (self.minSquareFromTextField), buttonsDict: self.buttonsDict)
            setupFilterButton()
        }
    }
    
    @objc func clearFilterButtonTapped(sender: UIButton!) {
        let buttons = [filterView.studioRoomButton, filterView.oneRoomButton, filterView.twoRoomButton, filterView.threeRoomButton, filterView.fourRoomButton, filterView.fourPlusRoomButton]
        buttons.forEach { button in
            button.backgroundColor = .systemBackground
            button.setTitleColor(.label, for: .normal)
        }
        buttonsDict.removeAll()
        filterLogic.flatsFiltered = []
        filterView.squareTextField.text = nil
        filterView.priceTextField.text = nil
        setupFirstData()
    }
    
    private func setupFlats() {
        filterLogic.setupFlats()
        filterLogic.calculateMinPriceAndSquare()
    }
    
    private func setupFirstData() {
        DispatchQueue.main.async {
            guard let maxPrice = self.filterLogic.maxPrice else { return }
            self.maxPrice = String(maxPrice)
            guard let minSquare = self.filterLogic.minSquare else { return }
            self.minSquare = String(minSquare)
            let roundMaxPrice = "\(Int(maxPrice) / 1_000_000),\(Int(maxPrice) % 1_000_000 / 100_000)"
            let roundMinSquare = "\(Int(minSquare)),\(Int(minSquare) % 100 / 10)"
            self.filterView.priceTextField.placeholder = roundMaxPrice
            self.filterView.squareTextField.placeholder = roundMinSquare
            self.filterLogic.filterFlats(price: maxPrice, square: Float(minSquare), buttonsDict: self.buttonsDict)
            self.setupFilterButton()
        }
    }
    
    func setupFilterButton() {
        DispatchQueue.main.async {
            let flatsCount = self.filterLogic.flatsFiltered.count
            let lastDigit = flatsCount % 10
            if flatsCount == 11 || flatsCount == 12 || flatsCount == 13 || flatsCount == 14 {
                self.filterView.filterButton.setTitle("\(flatsCount) объектов", for: .normal)
            } else if lastDigit == 1 {
                self.filterView.filterButton.setTitle("\(flatsCount) объект", for: .normal)
            } else if lastDigit == 2 || lastDigit == 3 || lastDigit == 4 {
                self.filterView.filterButton.setTitle("\(flatsCount) объекта", for: .normal)
            } else {
                self.filterView.filterButton.setTitle("\(flatsCount) объектов", for: .normal)
            }
        }
    }
    
    func setupPriceAndSquare() {
        if filterView.priceTextField.text != "" && filterView.priceTextField.text != nil {
            maxPriceFromTextField = (filterView.priceTextField.text! as NSString).floatValue * 1_000_000
        } else {
            maxPriceFromTextField = (maxPrice as NSString).floatValue
        }
        if filterView.squareTextField.text != "" && filterView.squareTextField.text != nil {
            minSquareFromTextField = (filterView.squareTextField.text! as NSString).floatValue
        } else {
            minSquareFromTextField = (minSquare as NSString).floatValue
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Объекты по выбранным фильтрам не найдены.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func filterButtonTapped(sender: UIButton) {
        let flats = filterLogic.flatsFiltered
        let flatsTableVC = FlatsTableViewController(flats: flats)
        flatsTableVC.modalTransitionStyle = .coverVertical
        flatsTableVC.modalPresentationStyle = .fullScreen
        if !flats.isEmpty {
            navigationController?.pushViewController(flatsTableVC, animated: true)
        } else {
            showAlert()
        }
    }
}
