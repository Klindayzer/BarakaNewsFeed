/*
 *	UIViewController.swift
 *	BarakaTest
 *
 *	Created by Klindayzer on 29/04/2022.
 */

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showLoader() {        
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hideLoader() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
