//
//  Video.swift
//  Youtube
//
//  Created by Sarthak Mishra on 28/06/18.
//  Copyright © 2018 Sarthak Mishra. All rights reserved.
//

import UIKit

class Video {
   
    static func getVideos(key: Int,completionHandler: @escaping (videos) -> ()) {
        
        var url: String =  ""
        
        var appCategories = videos()
       if(key == 0)
       {
        url = "https://www.googleapis.com/youtube/v3/search?part=snippet&chart=latest&maxResults=15&key=<API_KEY>&regionCode=IN"
       }else if (key == 1) {
        
        url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=Hans%20Zimmer%20Soundtrack&maxResults=15&key=<API_KEY>&regionCode=IN"
        
        }else if (key == 2)
       {
        
        url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=Unbox%20Therapy&maxResults=15&key=<API_KEY>&regionCode=IN"
        
       }else{
        url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=Selena%20Gomez%20VEVO&maxResults=15&key=<API_KEY>&regionCode=IN"
        
        
        }
        let api_url = URL(string: url)
       
        if let api_url_str = api_url {
       

            URLSession.shared.dataTask(with: api_url_str, completionHandler: { (data, response, error) -> Void in
            
           
            if error != nil {
                print(error)
                
            }
            
            do {
                
                let modeled = try JSONDecoder().decode(videos.self, from:data!)
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(modeled)
                })

            } catch let err {
                print(err)
            }
            
        }) .resume()
        
        }
    }
    static func getChannelArt(channelID: String, completionHandler: @escaping (String) -> ()) {
        
        
        var appCategories = videos()
        
        let url = "https://www.googleapis.com/youtube/v3/channels?part=snippet&id=\(channelID)&fields=items%2Fsnippet%2Fthumbnails&key=AIzaSyCBSk3oNsdIcpEtfUt6HFESAe8L6ZuAgko"
        
        let api_url = URL(string: url)
        
        URLSession.shared.dataTask(with: api_url!, completionHandler: { (data, response, error) -> Void in
            
            
            if error != nil {
                print(error)
                
            }
            
            do {
                
                let modeled = try JSONDecoder().decode(channel.self, from:data!)
                
                
                
                var imagUrl = modeled.items![0].snippet?.thumbnails.medium.url
                
                
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(imagUrl!)
                })
                
                
                
                
                
                
                
                
            } catch let err {
                print(err)
            }
            
        }) .resume()
        
        
    }
    static func getUrlVideo(videoID: String, completionHandler: @escaping (String) -> ()) {
        
        
        var appCategories = videos()
    
        let url = "http://localhost:8888/index.php?yid=\(videoID)";

       
        let api_url = URL(string: url)
      print(url)
        URLSession.shared.dataTask(with: api_url!, completionHandler: { (data, response, error) -> Void in
            
         
            if error != nil {
                print(error)
                
            }
            
            do {

                
                
                                let modeled = try JSONDecoder().decode(videoRes.self, from:data!)


               print(modeled)
                var imagUrl: String = modeled.url!
                imagUrl = "https%3A%2F%2Fr3---sn-q4f7sn7k.googlevideo.com%2Fvideoplayback%3Fc%3DWEB%26amp%3Bmm%3D31%252C26%26amp%3Bmn%3Dsn-q4f7sn7k%252Csn-qxo7rn7l%26amp%3Bms%3Dau%252Conr%26amp%3Bmt%3D1530472855%26amp%3Bmv%3Dm%26amp%3Bitag%3D18%26amp%3Blmt%3D1521051684810004%26amp%3Bipbits%3D0%26amp%3Bmime%3Dvideo%252Fmp4%26amp%3Bkey%3Dyt6%26amp%3Bexpire%3D1530494600%26amp%3Bfvip%3D3%26amp%3Bgir%3Dyes%26amp%3Brequiressl%3Dyes%26amp%3Bratebypass%3Dyes%26amp%3Bsource%3Dyoutube%26amp%3Binitcwndbps%3D120000%26amp%3Bpl%3D49%26amp%3Bdur%3D225.488%26amp%3Bei%3DKCo5W-yGL8WhDoyOmLAK%26amp%3Bsparams%3Dclen%252Cdur%252Cei%252Cgir%252Cid%252Cinitcwndbps%252Cip%252Cipbits%252Citag%252Clmt%252Cmime%252Cmm%252Cmn%252Cms%252Cmv%252Cpl%252Cratebypass%252Crequiressl%252Csource%252Cexpire%26amp%3Bfexp%3D23709359%26amp%3Bip%3D2600%253A3c00%253A%253Af03c%253A91ff%253Afe52%253Af0d3%26amp%3Bclen%3D12967681%26amp%3Bid%3Do-ANE0kzzNOaBgWX-HmtUaW3NnxjHLYU1vxdFKvOJPA1cg%26amp%3Bsignature%3DDF1FC7A50144F52279F4358DA7E2CEB9F137B5A2.691011F06988481DD57624D2ABBDBFD99267C6B7%26amp%3Btitle%3DSamjhawan%2BUnplugged%2B%7C%2BHumpty%2BSharma%2BKi%2BDulhania%2B%7C%2BSinger%3A%2BAlia%2BBhatt EoCz3Vx1pXg"
                
                imagUrl = imagUrl.decodeUrl()!

                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(imagUrl)
                })

                
                
                
                
                
                
                
                
                
            } catch let err {
                print(err)
            }
            
        }) .resume()
        
        
    }
    func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    class videos: Decodable {
        
        var items: [itemsList]?
    }
    class channel: Decodable{
        var items: [imageList]?
    }
    class itemsList: Decodable {
        
        var id: IdObs?
        var snippet: snippetObs?
    }
    class imageList: Decodable{
        
        
        var snippet: snippetObsThumb?
    }
    class  snippetObsThumb: Decodable{
        
        var thumbnails: thumbs = thumbs()
    }
    class IdObs: Decodable {
        var videoId: String?
    }
    
    class snippetObs: Decodable  {
      
        var channelId: String?
        var title: String?
        var channelTitle: String?
        var thumbnails: thumbs = thumbs()
       
    }
    class highres: Decodable{
        
        var url: String?
    }
    class thumbs: Decodable {
        
        var high: highres = highres()
        var medium: highres = highres()
    }
    
    class videoDownload: Decodable{
        
        var videos: [videoRes]
    }
    class videoRes: Decodable{
        
        var url: String?
    }
    
    
}
extension String
{
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
}
