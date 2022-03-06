//
//  StopViewController.swift
//  tableApp
//
//  Created by Никита Комаров on 01.03.2022.
//

import UIKit
import MapKit

//MARK: - Контроллер представления вида карты
class MapViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    var sheetViewController: SheetViewController?
    var data:               StopArr?
    var routes:             [RoutePath]?
    var busses:             [String]        = []
    var time:               [String]        = []
    var stopLocation                        = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    private var presenter       = MapViewPresenter()
    weak private var mapViewOutputDelegate: MapViewOutputDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setMapViewInputDelegate(mapViewInputDelegate: self)
        self.mapViewOutputDelegate = presenter
        self.mapViewOutputDelegate?.requestRoutes(stop: data!.id) { _ in
        }
    }
    
// MARK: - Кнопка "Назад"
    @IBAction func backButtonPressed(_ sender: Any) {
        sheetViewController!.dismiss(animated: true, completion: nil)
        _ = navigationController?.popViewController(animated: true)
    }
    
// MARK: - Инициализация карточки из Storyboard
    func instanciateSheetVC() {
        self.sheetViewController = (self.storyboard?.instantiateViewController(withIdentifier: "SheetViewController") as! SheetViewController)
    }
    
// MARK: - Настройка карты
    func configureMap() {
        self.stopLocation       = CLLocationCoordinate2D(latitude: data!.lat + 0.0001, longitude: data!.lon)
        let annotation          = MKPointAnnotation()
        annotation.title        = data!.name
        annotation.coordinate   = stopLocation
        map.setCenter(stopLocation, animated: true)
        map.addAnnotation(annotation)
    }
    
    // Настройка масштаба карты (default)
    func configureZoom(stopLocation: CLLocationCoordinate2D) {
        let defaultCoords       = CLLocation(latitude: stopLocation.latitude - 0.00025, longitude: stopLocation.longitude)
        let distance            = CLLocationDistance(50)
        let mapCoords           = MKCoordinateRegion.init(center: defaultCoords.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        
        map.setRegion(mapCoords, animated: true)
    }
    
// MARK: - Настройка карточки
    func showSheetVC(_ sheetVC: SheetViewController) {
        
        if let sheet = sheetVC.sheetPresentationController {
            sheet.detents                                           = [.medium()]
            sheet.largestUndimmedDetentIdentifier                   = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge         = false
            sheet.prefersEdgeAttachedInCompactHeight                = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached  = true
            sheet.prefersGrabberVisible                             = true
            sheet.preferredCornerRadius                             = 32
        }
        setUpSheetData(vc: sheetVC)
        present(sheetVC, animated: true, completion: nil)
        
    }
    
    func setUpSheetData(vc: SheetViewController)
    {
        getBussesAndTime(route: routes ?? [])
        vc.stopNameFromTable    = data?.name
        vc.busRouteNumbers      = busses
        vc.timeOfArrival        = time
    }
    
    func getBussesAndTime(route: [RoutePath])    {
        var i = 0

        while i < route.count
        {
            self.busses.append(route[i].number)
            if route[i].timeArrival.isEmpty == false {
                self.time.append(route[i].timeArrival[0])
            }
            else {
                self.time.append("n/d")
            }
            i += 1
        }
    }
}

extension MapViewController: MapViewInputDelegate {
    func loadRoutes(response: [RoutePath]) {
        self.routes = response
        instanciateSheetVC()
        self.showSheetVC(sheetViewController!)
        self.configureMap()
        self.configureZoom(stopLocation: stopLocation)
    }
}
