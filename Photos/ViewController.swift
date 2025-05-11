//
//  ViewController.swift
//  albums
//
//  Created by Mac on 04/04/25.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var photoTableView: UITableView!
    
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var  photos : [Photos] = []
    
    var photoTableViewCell : PhotoTableViewCell?
    
    private let reusableIdentifierForPhotoTableViewCell = "PhotoTableViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
        jsionSerealization()
        registerWithXib()
        
        
    }
    
    func registerWithXib(){
        let uiNib = UINib(nibName: reusableIdentifierForPhotoTableViewCell, bundle: nil)
        self.photoTableView.register(uiNib, forCellReuseIdentifier: reusableIdentifierForPhotoTableViewCell)
    }
    func initSetting(){
        photoTableView.dataSource = self
        photoTableView.delegate = self
        
        url = URL(string: Constant.urlString)
        urlRequest = URLRequest(url: url!)
        urlSession = URLSession(configuration: .default)
    }
    
    func jsionSerealization(){
        let dataTask = urlSession?.dataTask(with: urlRequest!){
            
            data,res,error in
            
            let response = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
            print(response)
            
            for eachPhotos in response{
                let albumId = eachPhotos["albumId"] as! Int
                let id = eachPhotos["id"] as! Int
                let title = eachPhotos["title"] as! String
                let url = eachPhotos["url"] as! String
                let thumbnailUrl = eachPhotos["thumbnailUrl"] as! String
                
                let photosObject = Photos(albumId: albumId,
                                          id: id,
                                          title: title,
                                          url: url,
                                          thumbnailUrl: thumbnailUrl)
                
                self.photos.append(photosObject)
                //print("Swift Array of Photos --\(self.photos)")
            }
            DispatchQueue.main.async{
                self.photoTableView.reloadData()
            }
        }
        dataTask?.resume()
        
    }
}
extension ViewController : UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        photoTableViewCell = self.photoTableView.dequeueReusableCell(withIdentifier: reusableIdentifierForPhotoTableViewCell, for: indexPath) as? PhotoTableViewCell
        
        photoTableViewCell?.albumIdLable.text = "\(photos[indexPath.row].albumId)"
        photoTableViewCell?.idLable.text = "\( photos[indexPath.row].id)"
        photoTableViewCell?.titleLable.text = photos[indexPath.row].title
        
        let url1 = URL(string: photos[indexPath.row].url)
        photoTableViewCell?.imageView1.kf.setImage(with: url1,placeholder: UIImage(named: "M"))

        
        return photoTableViewCell ?? UITableViewCell()
    }
}



extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}


    
    
        
            
        

        
    
    




