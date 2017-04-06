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
        imageView.backgroundColor = UIColor.blue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy fileprivate var nameLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.textAlignment = .center
        label.backgroundColor = UIColor.orange
        return label
    }()
    
    lazy fileprivate var rarityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.green
        return label
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(rarityLabel)
        
        cardImage.snp.makeConstraints { (make) in
            make.topMargin.equalTo(contentView.snp.topMargin)
            make.leadingMargin.equalTo(contentView.snp.leadingMargin)
            make.trailingMargin.equalTo(contentView.snp.trailingMargin)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.7)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(cardImage.snp.bottomMargin)
            make.width.equalTo(cardImage.snp.width)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.1)
            make.centerX.equalTo(cardImage.snp.centerX)
        }
        
        rarityLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(nameLabel.snp.bottomMargin)
            make.width.equalTo(nameLabel.snp.width)
            make.height.equalTo(nameLabel.snp.height)
            make.centerX.equalTo(nameLabel.snp.centerX)
        }
        
    }
}
