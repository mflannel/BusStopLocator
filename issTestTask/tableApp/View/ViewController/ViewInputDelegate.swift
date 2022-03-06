//
//  File.swift
//  tableApp
//
//  Created by Никита Комаров on 05.03.2022.
//

import Foundation

// MARK: - Делегат ViewInput
protocol ViewInputDelegate: AnyObject {
    func requestData(with testData: [StopArr])
    func reloadTableview()
}
