//
//  MapViewOutputDelegate.swift
//  tableApp
//
//  Created by Никита Комаров on 06.03.2022.
//

import Foundation

// MARK: - Делегат MapViewOutput
protocol MapViewOutputDelegate: AnyObject {
    func requestRoutes(stop: String, completion: @escaping ([RoutePath]) -> Void)
}
