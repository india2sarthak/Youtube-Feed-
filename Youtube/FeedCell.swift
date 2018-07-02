//
//  FeedCell.swift
//  Youtube
//
//  Created by Sarthak Mishra on 29/06/18.
//  Copyright © 2018 Sarthak Mishra. All rights reserved.
//

import UIKit

class newsCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var indexint: Int = 0 {
        
        didSet{
            print("INDEX INT :\(indexint)")
            Video.getVideos(key: indexint) { (videos) in
                self.videoList = videos
                
                self.collectionView.reloadData()
            }
        }
    }
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var videoList: Video.videos? = nil
    
    
    let feedIdentifier  =  "feedIdentifier"
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = .brown
        collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        collectionView.register(FeedCellSingle.self, forCellWithReuseIdentifier: feedIdentifier)
        
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = videoList?.items?.count {
            return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedIdentifier, for: indexPath) as! FeedCellSingle
        
        cell.itemVideo = videoList?.items?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width,height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let videoCont = VideoLauncher()
        videoCont.video_id =  (videoList?.items?[indexPath.item].id?.videoId)!
        videoCont.showVideoContainer()
        
        
        
    }

    
    
}
    class FeedCellSingle: UICollectionViewCell {
        var loaded: Bool = false
        
        var itemVideo: Video.itemsList!{
            
            didSet{
                
                if let title = itemVideo?.snippet?.title{
                    titleLabel.text = title
                    
                    subtitleTextView.text = itemVideo.snippet?.channelTitle
                    thumbnailImageView.loadImageUsingUrlString(urlString: (itemVideo.snippet?.thumbnails.high.url)!)
                    
                    Video.getChannelArt(channelID: (itemVideo.snippet?.channelId)!) { (art) in
                        
                        self.userProfileImageView.loadImageUsingUrlString(urlString: art)
                        
                    }
                    
                }
            }
            
            
        }
        
        override init(frame: CGRect) {
            
            super.init(frame: frame)
            setUpView()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        let thumbnailImageView: CustomImageView = {
            let imageView = CustomImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: "ab")
            imageView.clipsToBounds = true
            return imageView
        }()
        
        let userProfileImageView: CustomImageView = {
            let imageView = CustomImageView()
            imageView.image = UIImage(named: "ab")
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 22
            imageView.layer.masksToBounds = true
            imageView.clipsToBounds = true
            return imageView
        }()
        
        let separatorView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.black
            view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
            return view
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Taylor Swift - Blank Space"
            label.numberOfLines = 2
            
            return label
        }()
        
        let subtitleTextView: UITextView = {
            let textView = UITextView()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
            textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
            textView.textColor = UIColor.lightGray
            return textView
        }()
        
        let title: UILabel = {
            
            let label = UILabel()
            return label
        }()
        
        
        
        
        func setUpView()
        {
            addSubview(thumbnailImageView)
            addSubview(separatorView)
            addSubview(userProfileImageView)
            addSubview(titleLabel)
            addSubview(subtitleTextView)
            
            addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
            
            addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
            
            //vertical constraints
            addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
            
            addConstraintsWithFormat("H:|[v0]|", views: separatorView)
            
            addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
            addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
            
            
            addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
            
            
            addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
            addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
            
            
            addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
            
            
            // addConstraintsWithFormat("H:|[v0]|", views: titleLabel)
            
            
            
            
            
        }
        
        
        
        
}
