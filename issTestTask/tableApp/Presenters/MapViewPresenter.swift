//
//  MapViewPresenter.swift
//  tableApp
//
//  Created by Никита Комаров on 06.03.2022.
//

import Foundation
import Alamofire

// MARK: - Презентер контроллера представления карты
class MapViewPresenter {
    weak private var mapViewInputDelegate: MapViewInputDelegate?
    var routes:             [RoutePath]?
    
    func setMapViewInputDelegate(mapViewInputDelegate: MapViewInputDelegate?) {
        self.mapViewInputDelegate = mapViewInputDelegate
    }
    
    func makeRouteRequest(stop: String) {
        AF.request(APIKeyManager.shared.key + "/" + stop).responseDecodable(of: ExactStopResponse.self) { response in
            if case .success = response.result {
                self.routes = response.value?.routePath
                self.loadRouteData()
            }
        }
    }
    
    func loadRouteData()
    {
        self.mapViewInputDelegate?.loadRoutes(response: routes!)
    }
}

extension MapViewPresenter: MapViewOutputDelegate
{
    func requestRoutes(stop: String, completion: @escaping ([RoutePath]) -> Void) {
        makeRouteRequest(stop: stop)
        }
}
