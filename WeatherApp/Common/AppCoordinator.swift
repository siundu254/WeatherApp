//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 06/06/2021.
//

import UIKit

final class AppCoordinator {
    
    private let window: UIWindow
    private let navigation: UINavigationController
    
    init(window: UIWindow, navigation: UINavigationController) {
        self.window = window
        self.navigation = navigation
        window.configure(with: navigation)
        navigation.configure()
    }
    
    convenience init() {
        self.init(window: UIWindow(), navigation: UINavigationController())
    }
    
    func start() {
        let mainView = ViewController()
        navigation.pushViewController(mainView, animated: true)
    }
}

// MARK: - UIWindow Extension
private extension UIWindow {
    func configure(with navigation: UINavigationController) {
        makeKeyAndVisible()
        rootViewController = navigation
    }
}

// MARK: -UINavigationController Extension
private extension UINavigationController {
    func configure() {
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.isEnabled = true
    }
}
