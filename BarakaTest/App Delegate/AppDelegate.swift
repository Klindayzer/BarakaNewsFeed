//
//  AppDelegate.swift
//  BarakaTest
//
//  Created by Klindayzer on 27/04/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)        
        window?.rootViewController = createNavigationController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func createNavigationController() -> UINavigationController {
        
        let controller = buildHomeHomeViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController
    }
    
    private func buildHomeHomeViewController() -> HomeViewController {
        
        let datasource: DataSourceable = Environment.instance.isLocal ? LocalDataSource() : ServerDataSource()
        let viewModel = HomeViewModel(datasource: datasource, newsParser: JsonDataParser(), stockParser: CsvDataParser())
        let controller = HomeViewController(viewModel: viewModel)
        return controller
    }
}
