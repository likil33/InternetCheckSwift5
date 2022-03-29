//
//  OfflineBannerView.swift


import UIKit

class OfflineBannerView: UIView, NibLoadableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12
    }
}
