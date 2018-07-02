//
//  ViewController.swift
//  Youtube
//
//  Created by Sarthak Mishra on 28/06/18.
//  Copyright © 2018 Sarthak Mishra. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    var titleLabel: UILabel?
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]

    let masterIden  = "masterCellId"
    var videoList: Video.videos? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.navigationBar.isTranslucent = false
        
       
       
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        titleLabel?.text = "Home"
        titleLabel?.textColor = UIColor.white
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        
        // Do any additional setup after loading the view, typically from a nib.
    
        setCollectionView()
        setUpMenuBar()
        setupNavBarButtons()
    
    }
    lazy var menuBar: MenuBar = {
        
        let mb = MenuBar()
        mb.homeController = self 
        return mb
    }()
    
    func setCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(newsCell.self, forCellWithReuseIdentifier: masterIden)
        
      
        collectionView?.isPagingEnabled = true
        
    }
   
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    let ms = settingsMenu()
    
    @objc func handleMore() {
        ms.openOptions()
    }
    @objc func handleSearch() {
        print(123)
    }

    func setUpMenuBar()
   {
    
    let redView = UIView()
    redView.backgroundColor = UIColor.red
    view.addSubview(redView)
    
    view.addConstraintsWithFormat("H:|[v0]|", views: redView)
    view.addConstraintsWithFormat("V:|[v0(50)]|", views: redView)
    
     view.addSubview(menuBar)
     view.addConstraintsWithFormat("H:|[v0]|", views: menuBar) 
     view.addConstraintsWithFormat("V:[v0(50)]", views: menuBar)
    menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true

    
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: masterIden, for: indexPath) as! newsCell
       cell.indexint = indexPath.item
      
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
        
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetSection = (targetContentOffset.pointee.x) / (view.frame.width)
        let index = IndexPath (item: Int(targetSection), section: 0)
        menuBar.collectionView.selectItem(at: index, animated: true, scrollPosition: .top)
        setTitleIndex(num: Int(targetSection))
        
       
    }
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as! IndexPath, at: .centeredHorizontally, animated: true)
        setTitleIndex(num: menuIndex)
    
    }

    func setTitleIndex(num: Int) {
      
        titleLabel?.text = titles[num]
    }
    
//
}


extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = NSURL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        let imageURL = URL(string: urlString as! String)
        
      
        DispatchQueue.global(qos: .background).async {
        
            if let imageData = try? Data(contentsOf: imageURL!) {
                let toCache  = UIImage(data: imageData)
         
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.image = UIImage(data: imageData)
                    imageCache.setObject(toCache!, forKey: urlString as AnyObject)
                    
                })
            }
        }
      
        
    }
    
}
