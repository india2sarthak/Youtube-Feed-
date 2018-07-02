//
//  Settings.swift
//  Youtube
//
//  Created by Sarthak Mishra on 29/06/18.
//  Copyright © 2018 Sarthak Mishra. All rights reserved.
//

import UIKit

class settingsMenu: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
 
    let blackView = UIView()
    let collectionView: UICollectionView = {
        
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let settings: [Setting] = {
        return [Setting(name: "Settings", imageName: "settings"), Setting(name: "Terms & privacy policy", imageName: "privacy"), Setting(name: "Send Feedback", imageName: "feedback"), Setting(name: "Help", imageName: "help"), Setting(name: "Switch Account", imageName: "switch_account"), Setting(name: "Cancel", imageName: "cancel")]
    }()
    
    let  cellId = "cellId"
    let cellHeight: CGFloat =  50
    
   func openOptions() {
    if let window = UIApplication.shared.keyWindow {
        
        
        
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        let height: CGFloat = CGFloat(settings.count) * cellHeight
        
       
        let ypos = window.frame.height - height
        print("Okay So the height :\(height)")
         collectionView.frame =  CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        
        window.addSubview(blackView)
        window.addSubview(collectionView)
        
        blackView.frame = window.frame
        blackView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,  options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 1
            self.collectionView.frame = CGRect(x: 0, y: ypos, width: window.frame.width, height: self.collectionView.frame.height)
            
        }, completion: nil)
        
    }
}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
    cell.singleCell = settings[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected this -> Run \(settings[indexPath.row].name)")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    @objc func handleDismiss() {
   
        print("SJJSJSXXXXX")
        UIView.animate(withDuration: 0.5) {
        self.blackView.alpha = 0
        if let window = UIApplication.shared.keyWindow
        {
          self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: self.collectionView.frame.height)
            
            
        }
        
    }
}
    override init() {
        super.init()
        //start doing something here maybe....
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
}

class SettingCell: UICollectionViewCell{
    
    var singleCell: Setting? {
        
        didSet{
            
            nameLabel.text = singleCell?.name
            
            if let imageName = singleCell?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
           
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        
    }
   
    override var isHighlighted: Bool{
        
        didSet{
            
           backgroundColor = isHighlighted ? UIColor(red: 227/255, green: 228/255, blue: 229/255, alpha: 1) :  UIColor.white
        }
        
    }
    
    override var isSelected: Bool{
        
        didSet{
            
           backgroundColor = isSelected ? UIColor(red: 227/255, green: 228/255, blue: 229/255, alpha: 1) :  UIColor.white
        }
        
    }
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    func setUpViews() {
        
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat("H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        
        addConstraintsWithFormat("V:|[v0]|", views: nameLabel)
        
        addConstraintsWithFormat("V:[v0(30)]", views: iconImageView)
        
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
