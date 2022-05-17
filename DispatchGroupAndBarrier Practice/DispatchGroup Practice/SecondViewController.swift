//
//  SecondViewController.swift
//  DispatchGroup Practice
//
//  Created by Oleg on 17.05.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    public var imageURLs = ["https://c4.wallpaperflare.com/wallpaper/751/770/514/mclaren-540c-car-red-cars-wallpaper-preview.jpg", "https://www.automotivpress.fr/wp-content/uploads/2015/04/mclaren_540c_2317.jpg", "https://c4.wallpaperflare.com/wallpaper/751/770/514/mclaren-540c-car-red-cars-wallpaper-preview.jpg", "https://images7.alphacoders.com/961/961059.jpg"]
    
    public var ivs = [UIImageView]()
    
    public var images = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Photos"

        appendImages()
        asyncGroup()
        
        }
      
    
    func appendImages() {
        ivs.append(UIImageView(frame: CGRect(x: 5, y: 100, width: 200, height: 200)))
        ivs.append(UIImageView(frame: CGRect(x: 5, y: 305, width: 200, height: 200)))
        ivs.append(UIImageView(frame: CGRect(x: 210, y: 100, width: 200, height: 200)))
        ivs.append(UIImageView(frame: CGRect(x: 210, y: 305, width: 200, height: 200)))
        for i in 0...3 {
            ivs[i].contentMode = .scaleAspectFit
            self.view.addSubview(ivs[i])
        }
    }
    
    func asyncLoadImages(imageURL: URL, runQueue: DispatchQueue, complitionQueue: DispatchQueue, complition: @escaping (UIImage? , Error?) -> ()) {
        runQueue.async(flags: .barrier) {
            do {
                let data = try Data(contentsOf: imageURL)
                complitionQueue.async { complition(UIImage(data: data), nil)}
            } catch let error {
                complitionQueue.async { complition(nil, error)}
            }
        } 
    }
    
    func asyncGroup() {
        let aGroup = DispatchGroup()
        
        for i in 0...3 {
            aGroup.enter()
            asyncLoadImages(imageURL: URL(string: imageURLs[i])!,
                            runQueue: .global(),
                            complitionQueue: .main) { result, error in
                guard let image1 = result else { return}
                self.images.append(image1)
                aGroup.leave()
            }
            
            aGroup.notify(queue: .main) { [self] in
                for i in 0...3 {
                    ivs[i].image = self.images[i]
                }
            }
        }
    }
    
    }
    


