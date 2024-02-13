//
//  KakaoMapViewController.swift
//  MapTest
//
//  Created by Awesomepia on 2/2/24.
//

import UIKit

final class KakaoMapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- KakaoMapViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension KakaoMapViewController: EssentialViewMethods {
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
        
    }
    
    func setLayouts() {
        //let safeArea = self.view.safeAreaLayoutGuide
        
        //
        NSLayoutConstraint.activate([
            
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    func setKakaoMap() {
//        let mapController =
    }
}

// MARK: - Extension for methods added
extension KakaoMapViewController {
    
}

// MARK: - Extension for selector methods
extension KakaoMapViewController {
    
}

