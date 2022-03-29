//
//  APIManager.swift
//  InternetReachabilitySwift
//
//  Created by Santhosh K on 29/03/22.
//

import Foundation
import UIKit

class ApiManager: NSObject {
    
    static let sharedInstance = ApiManager()
    var isAuthorised = true
    //var popUpView: CustomAlertView?
    var isForceUpgrade = false
    var offlineBanner: OfflineBannerView?
    var isUpdateOptional = false
    var gotoNextPopUp: (() -> Void)?
    
    private override init() {
        super.init()
       // NotificationCenter.default.addObserver(self, selector: #selector(logOutUser(_:)), name: Notification.Name.unAuthorised, object: nil)
    }
}

extension ApiManager {
    ///Method to show the offline banner
    func showOfflineError() {
        DispatchQueue.main.async (execute: { [weak self]() -> Void in
            guard let weakSelf = self else { return }
            weakSelf.offlineBanner?.removeFromSuperview()
            if weakSelf.offlineBanner == nil {
                weakSelf.offlineBanner = Bundle.main.loadNibNamed(String(describing: OfflineBannerView.self), owner: self, options: nil)?.first as? OfflineBannerView
                weakSelf.offlineBanner?.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.5 - 100, y: UIApplication.shared.statusBarFrame.height, width: 200, height: 24)
                weakSelf.offlineBanner?.layer.zPosition = 1
            }
            UIApplication.shared.keyWindow?.addSubview(weakSelf.offlineBanner ?? UIView())
        })
    }
    
    ///Method to remove the offline banner
    func removeOfflineError() {
        DispatchQueue.main.async (execute: { [weak self]() -> Void in
            guard let weakSelf = self else { return }
            weakSelf.offlineBanner?.removeFromSuperview()
        })
    }
}
