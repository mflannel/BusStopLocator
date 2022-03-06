//
//  ViewOutputDelegate.swift
//  tableApp
//
//  Created by Никита Комаров on 05.03.2022.
//

import Foundation

// MARK: - Делегат ViewOutput
protocol ViewOutputDelegate: AnyObject {
    func requestAndLoadData()
    func getNumberOfStops() -> Int
}
