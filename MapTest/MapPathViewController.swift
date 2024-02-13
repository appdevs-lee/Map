//
//  MapPathViewController.swift
//  MapTest
//
//  Created by Awesomepia on 2/13/24.
//

import UIKit
import MapKit

final class MapPathViewController: UIViewController {
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        if #available(iOS 16.0, *) {
            mapView.preferredConfiguration = MKStandardMapConfiguration()
        } else {
            mapView.mapType = .standard
        }
        mapView.setUserTrackingMode(.follow, animated: true)
        mapView.setRegion(MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500), animated: true)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        return mapView
    }()
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        manager.delegate = self
        
        return manager
    }()
    
    let mapModel = MapModel()
    let stations: [Station] = [
        Station(title: "스타벅스 앞 정류장", coordinate: CLLocationCoordinate2D(latitude: 37.49960, longitude: 127.0336), subtitle: "첫 출발지입니다."),
        Station(title: "서봉빌딩 앞 정류장", coordinate: CLLocationCoordinate2D(latitude: 37.49918, longitude: 127.0370), subtitle: "특이사항 없습니다."),
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
        self.setPermission()
        self.setData()
        self.drawLineOnMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- MapPathViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension MapPathViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        self.view.addSubview(self.mapView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // mapView
        NSLayoutConstraint.activate([
            self.mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    func setPermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func setData() {
        self.mapModel.deleteAll()
        let date = self.convertDate(intoString: Date(), "yyyy-MM-dd HH:mm:ss")
        let location1 = Location()
        let location2 = Location()
        let location3 = Location()
        let location4 = Location()
        let location5 = Location()
        let location6 = Location()
        
        location1.latitude = 37.49969
        location1.longitude = 127.0336
        location1.date = date
        
        location2.latitude = 37.49989
        location2.longitude = 127.0343
        location2.date = date
        
        location3.latitude = 37.50068
        location3.longitude = 127.0369
        location3.date = date
        
        location4.latitude = 37.49937
        location4.longitude = 127.0376
        location4.date = date
        
        location5.latitude = 37.49909
        location5.longitude = 127.0367
        location5.date = date
    
        location6.latitude = 37.56992
        location6.longitude = 126.9590
        location6.date = date
        
        self.mapModel.save(data: location1)
        self.mapModel.save(data: location2)
        self.mapModel.save(data: location3)
        self.mapModel.save(data: location4)
        self.mapModel.save(data: location5)
        self.mapModel.save(data: location6)
    }
}

// MARK: - Extension for methods added
extension MapPathViewController {
    func drawLineOnMap() {
        var points: [CLLocationCoordinate2D] = []
        
        for location in self.mapModel.read() {
            let point: CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(location.latitude, location.longitude)
            
            points.append(point)
            
            let lineDraw = MKPolyline(coordinates: points, count:points.count)
            self.mapView.addOverlay(lineDraw)
        }
        
        for station in self.stations {
            self.mapView.addAnnotation(station)
            
        }
        
    }
    
    // Date -> String
    func convertDate(intoString date: Date, _ dateFormat: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")!
        formatter.dateFormat = dateFormat
        
        return formatter.string(from: date)
    }
}

// MARK: - Extension for selector methods
extension MapPathViewController {
    
}

// MARK: - Extension for CLLocationManagerDelegate
extension MapPathViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}

// MARK: - Extension for MKMapViewDelegate
extension MapPathViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline else { return MKOverlayRenderer() }
        
        let renderer = MKPolylineRenderer(polyline: polyLine)
        
        renderer.strokeColor = .red
        renderer.lineWidth = 5.0
        renderer.alpha = 1.0
        
        return renderer
    }
}
