//
//  CardCollectionViewCell.swift
//  MagicTheGatheringDatabase
//
//  Created by Forrest Zhao on 4/6/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit
import SnapKit

class CardCollectionViewCell: UICollectionViewCell {
    
    var cardCellViewModel: CardCellViewModel? {
        didSet {
            if let unwrappedCardCellViewModel = cardCellViewModel {
                nameLabel.text = unwrappedCardCellViewModel.name
                rarityLabel.text = unwrappedCardCellViewModel.rarity
                backgroundColor = unwrappedCardCellViewModel.backGroundColor
            } else {
                print("Card cell view model is nil")
            }
        }
    }
    
    lazy fileprivate var cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy fileprivate var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
        label.textColor = UIColor.black
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    lazy fileprivate var rarityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        return label
    }()
    
    lazy fileprivate var spinner: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.isHidden = true
        activityView.hidesWhenStopped = true
        return activityView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        contentView.addSubview(cardImage)
        contentView.addSubview(spinner)
        contentView.addSubview(nameLabel)
        contentView.addSubview(rarityLabel)
        
        cardImage.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.7)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cardImage.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.1)
        }
        
        rarityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalTo(nameLabel.snp.trailing)
            make.height.equalTo(nameLabel.snp.height)
        }
        
        spinner.snp.makeConstraints { (make) in
            make.centerX.equalTo(cardImage.snp.centerX)
            make.centerY.equalTo(cardImage.snp.centerY)
        }
    }
    
    func updateWithImage(image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            cardImage.image = imageToDisplay
        } else {
            spinner.startAnimating()
            cardImage.image = nil
        }
    }
}
