//
//  CustomTableViewCell.swift
//  FoodPin
//
//  Created by 000 on 15/9/10.
//  Copyright (c) 2015年 000. All rights reserved.
//
import UIKit

class CustomTableViewCell: UITableViewCell {

    var nameLabel: UILabel!
    var locationLabel: UILabel!
    var typeLabel: UILabel!
    var thumbnailImageView: UIImageView!
    let HMStatusCellInset:CGFloat! = 10.0
    
//    var restaurant:Restaurant!
   
//    var restaurant:Restaurant!
//    {
//        get
//        {
//            return self.restaurant
//        }set
//        {
//           // self.restaurant = newValue
//            self.setNewRestaurant(newValue)
//        }
//    }
    


    var restaurant:Restaurant!
  {

       didSet
        {
            setView(restaurant)
        }
  }


    func updateHeightCell()
    {
        self.thumbnailImageView.image = self.restaurant.image
        self.nameLabel.text = self.restaurant.name
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected statex
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.thumbnailImageView  = UIImageView()
        self.contentView.addSubview(self.thumbnailImageView)
        self.nameLabel  = UILabel()
        self.nameLabel.numberOfLines = 0
        self.contentView.addSubview(self.nameLabel)
//        [self.contentView addSubview:self.lblBody];
        //布局
//        self.setView(self.restaurant)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //布局
    func setView(restaurant:Restaurant)
    {
        let superview = self

        self.thumbnailImageView.mas_makeConstraints { make in
            make.left.equalTo()(superview.mas_top).offset()(10)
            make.top.equalTo()(superview.mas_top).offset()(10)
            make.width.equalTo()(35)
            make.height.equalTo()(35)
        }
        self.nameLabel.mas_makeConstraints { make in
            make.left.equalTo()(self.thumbnailImageView.mas_right).offset()(10)
            make.top.equalTo()(self.thumbnailImageView)
            make.width.equalTo()(superview.frame.width - self.thumbnailImageView.frame.width - 10)
            make.bottom.equalTo()(-20);
        }

    }
  
    //赋值
    override func layoutSubviews()
    {
        super.layoutSubviews()
        if((restaurant) != nil)
        {
            thumbnailImageView.image = restaurant.image
            nameLabel.text = restaurant.name
        }
        
    }

}
