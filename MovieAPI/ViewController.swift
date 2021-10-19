//
//  ViewController.swift
//  MovieAPI
//
//  Created by Rodrigo Leyva on 10/19/21.
//

import UIKit
import Alamofire
import AlamofireImage

struct Movie: Codable{
    let id : Int
    let name: String
    let image : MovieImage
    let genres : [String]
    
}
struct MovieImage: Codable{
    let medium : String
    
}

class ViewController: UICollectionViewController {
    
    var movies : [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AF.request("https://api.tvmaze.com/shows").responseDecodable(of: [Movie].self) { response in
            if let movies = response.value {
                DispatchQueue.main.async {
                    self.movies = movies
                    self.collectionView.reloadData()
                }
            }

        }
//        let url = URL(string: "https://api.tvmaze.com/shows")
//                // create a URLSession to handle the request tasks
//                let session = URLSession.shared
//
//                // create a "data task" to make the request and run the completion handler
//                let task = session.dataTask(with: url!) {
//                    // see: Swift closure expression syntax
//                    data, response, error in
//                    print("in here")
//                    // see: Swift nil coalescing operator (double questionmark)
//                    print(data ?? "no data")
//                    do{
//                        let decoder = JSONDecoder()
//                        let moviesData = try decoder.decode([Movie].self, from: data!)
//
//                        DispatchQueue.main.async {
//                            self.movies = moviesData
//                            self.collectionView.reloadData()
//                        }
//                    }catch{
//                        print(error.localizedDescription)
//                    }
//                    // the "no data" is a default value to use if data is nil
//
//                }
//                // execute the task and wait for the response before
//                // running the completion handler. This is async!
//                task.resume()
        
        
        // Do any additional setup after loading the view.
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        cell.nameLabel.text = movies[indexPath.row].genres.first
        
        AF.request(movies[indexPath.row].image.medium).responseImage{ response in
            

            if case .success(let image) = response.result {
                DispatchQueue.main.async {
                   
                    cell.imageView.image = image
                    cell.imageView.layer.cornerRadius = 8.0
                    

                }
                
            }
            
        }
        
        
        return cell
    }
    
    
    


}

