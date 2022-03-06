//
//  SheetViewController.swift
//  tableApp
//
//  Created by Никита Комаров on 01.03.2022.
//

import UIKit

// MARK: - Контроллер представления карточки
class SheetViewController   : UIViewController {

    var stopNameFromTable   : String?
    var busRouteNumbers     : [String]?
    var timeOfArrival       : [String]?
    
    var titleLabel          = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configureInfoTable()
    }
    
// MARK: - Вывод номеров маршрутов
    func addBusNumbersToStackView(stackView: UIStackView) {
        
        let title = UILabel()
        title.text = "🚌:"
        stackView.addArrangedSubview(title)
        
        for i in 0..<busRouteNumbers!.count
        {
            let label   = UILabel()
            label.text  = busRouteNumbers![i]
            stackView.addArrangedSubview(label)
        }
    }
    
// MARK: - Настройка таблицы маршрутов
    func configureInfoTable() {
        let stackView                   = UIStackView()
        stackView.distribution          = .equalCentering
        stackView.alignment             = .center
        stackView.backgroundColor       = .white
        view.addSubview(stackView)
        setStackConstraints(stackView: stackView)
        addBusNumbersToStackView(stackView: stackView)
        configureTime(stackView: stackView)
    }
    
// MARK: - Constraints таблицы маршрутов
    func setStackConstraints(stackView: UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints                                                             = false
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive                         = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive      = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive   = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive       = false
    }
    
// MARK: - Настройка заголовка
    func configureTitle() {
        view.addSubview(titleLabel)
        titleLabel.text                         = stopNameFromTable ?? "None"
        titleLabel.font                         = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment                = .left
        titleLabel.numberOfLines                = 0
        titleLabel.adjustsFontSizeToFitWidth    = true
        setTitleConstraints()
    }
    
// MARK: - Constraints заголовка
    func setTitleConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints                                                            = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive             = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive     = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive  = true
    }
    
// MARK: - Настройка таблицы времени прибытия
    func configureTime(stackView: UIStackView)
    {
        let timeStackView                   = UIStackView()
        timeStackView.distribution          = .equalCentering
        timeStackView.alignment             = .center
        timeStackView.backgroundColor       = .white
        view.addSubview(timeStackView)
        setTimeStackConstraints(timeStackView: timeStackView, stackView: stackView)
        addTimeToStackView(timeStackView: timeStackView)
    }
    
// MARK: - Отображение таблицы времени прибытия
    func addTimeToStackView(timeStackView: UIStackView) {
        
        let title = UILabel()
        title.text = "⏱:"
        timeStackView.addArrangedSubview(title)
        
        for i in 0..<busRouteNumbers!.count
        {
            let label       = UILabel()
            label.text      = timeOfArrival![i]
            timeStackView.addArrangedSubview(label)
        }
    }
    
// MARK: - Constraints таблицы времени прибытия
    func setTimeStackConstraints(timeStackView: UIStackView, stackView: UIStackView)
    {
        timeStackView.translatesAutoresizingMaskIntoConstraints                                                             = false
        timeStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5).isActive                           = true
        timeStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive      = true
        timeStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive   = true
    }
}
