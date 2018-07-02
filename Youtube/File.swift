//
//  File.swift
//  Youtube
//
//  Created by Sarthak Mishra on 28/06/18.
//  Copyright © 2018 Sarthak Mishra. All rights reserved.
//

import UIKit


class MenuBar: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    let collectionView: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
        
    }()
    var homeController: ViewController?
    let menuArray: [String] =  ["home","trending","subscriptions","account"]
    let menuCellId = "menuCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.backgroundColor = UIColor.red
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
    
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuCellId)
        
        let selectedIndexPath = NSIndexPath(item: 0,section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .top)
        setUpViews()
        setUpIndicator()
        
    }
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    func setUpIndicator() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let x = CGFloat(indexPath.row) * (frame.width/4)
//        horizontalBarLeftAnchorConstraint?.constant = x
//
//        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                      self.layoutIfNeeded()
//                    }, completion: nil)
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as! MenuCell
        
        cell.menuName = menuArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4 , height: frame.height)
    }
    
    func setUpViews() {
        
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
class MenuCell: UICollectionViewCell{
    
    var menuName: String? {
        
        didSet{
         
            imageView.image = UIImage(named: menuName!)?.withRenderingMode(.alwaysTemplate)
            
        }
    }
    let imageView: UIImageView = {
       
        let im = UIImageView()
        
        im.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        im.translatesAutoresizingMaskIntoConstraints = false
        return im
        
    }()
    override var isHighlighted: Bool{
    
        didSet{
            
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
        
    }
    
    override var isSelected: Bool{
        
        didSet{
            
             imageView.tintColor = isSelected ? UIColor.white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
        
    }
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    
        setUpViews()
    }
    func setUpViews(){
        
       
        addSubview(imageView)
        addConstraintsWithFormat("H:[v0(28)]", views: imageView)
        addConstraintsWithFormat("V:[v0(28)]", views: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

