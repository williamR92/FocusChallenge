//
//  TvShowsCollectionViewCell.swift
//  FocusChallenge
//
//  Created by Carlos Rosales on 1/19/21.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var containerView:UIView = {
        let containerView = UIView(frame: CGRect(x:0, y: 0, width:  UIScreen.main.bounds.width/2.065, height: UIScreen.main.bounds.width/2.6))
        containerView.backgroundColor = UIColor(red: 08.0/255.0, green: 85.0/255.0, blue: 33.0/255.0, alpha: 0.7)
        containerView.roundCorners(corners: [.topLeft, .bottomLeft, .topRight, .bottomRight], radius: 13)
        return containerView
    }()
    
    var imgTvShow:UIImageView = {
        var imgTv = UIImageView(frame: CGRect(x:0, y: 0, width:  UIScreen.main.bounds.width/2.065, height: UIScreen.main.bounds.width/2.6))
        imgTv.backgroundColor = .white
        imgTv.roundCorners(corners: [.topLeft, .bottomLeft], radius: 13)
        return imgTv
    }()
    
    var lblDetail:UILabel = {
        var lblDetail = UILabel(frame: CGRect(x:0, y: 0, width:UIScreen.main.bounds.width/2.065, height: UIScreen.main.bounds.width/2.6))
        lblDetail.textAlignment = .right
        lblDetail.textColor = .white
        lblDetail.backgroundColor = .clear
        return lblDetail
    }()


override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(self.containerView)
    imgTvShow.frame = CGRect(x:0, y: 0, width: frame.width/2, height: frame.height)
    lblDetail.frame = CGRect(x:frame.width/2, y: 0, width: frame.width/2, height: frame.height)
    self.containerView.addSubview(self.imgTvShow)
    self.containerView.addSubview(self.lblDetail)

}

}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
