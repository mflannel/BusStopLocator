//
//  MapViewInputDelegate.swift
//  tableApp
//
//  Created by Никита Комаров on 06.03.2022.
//

import Foundation

// MARK: - Делегат MapViewInput
protocol MapViewInputDelegate: AnyObject {
    func loadRoutes(response: [RoutePath])
}
