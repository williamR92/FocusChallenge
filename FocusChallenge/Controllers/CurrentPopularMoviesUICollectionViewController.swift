//
//  CurrentPopularMoviesViewController.swift
//  FocusChallenge
//
//  Created by William Rivas on 1/19/21.
//

import UIKit
import SDWebImage

class CurrentPopularMoviesUICollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var lisOfMovies = [MovieDetail]() {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.navigationItem.title = "\(self.lisOfMovies.count) Movies"
            }
        }
    }
    
    lazy var searchBar : UISearchBar = {
    let s = UISearchBar()
        s.placeholder = "Search Movie"
        s.delegate = self
        s.tintColor = .white
        s.barTintColor = .darkGray
        s.barStyle = .default
        s.sizeToFit()
        return s
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
         sendRequest()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = self.view.frame.width/36
        self.collectionView = UICollectionView(frame: self.collectionView!.frame, collectionViewLayout: layout)
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        
        self.collectionView!.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(MoviesCollectionViewCell.self))
        
        self.collectionView!.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCellId")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.performSegue(withIdentifier: "results", sender: self)
        nameSearch = searchBar.text!
        print("ok!!!")
    }

    func sendRequest() {
        IJProgressView.shared.showProgressView(view: view)
        let tvRequest = MoviesRequest(language: "en-US")
        tvRequest.getTvPrograms{ [weak self] result  in
            switch result{
            case .failure(let error):
                print(error)
                IJProgressView.shared.hideProgressView()
                break
            case .success(let tvShows):
                self?.lisOfMovies = tvShows
                IJProgressView.shared.hideProgressView()
                break
            }
        }
       }
    
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        // Filter Action
        print("ok")
    }
    
    
   /* // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }*/
    

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return lisOfMovies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(MoviesCollectionViewCell.self), for: indexPath) as! MoviesCollectionViewCell
        let index = indexPath.row
        let urlImage = URL(string: getUrl(section: 3, supplementaryDataURL: lisOfMovies[index].poster_path))
        let title = lisOfMovies[index].title
        let dateOfIssue = lisOfMovies[index].release_date
        let voteAverage = lisOfMovies[index].vote_average
        let description = lisOfMovies[index].overview
        
        let myParagraphStyle1 = NSMutableParagraphStyle()
        myParagraphStyle1.lineSpacing = 0
        let attribute0 = NSMutableAttributedString(string: "TITLE: \(title)\n", attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size:self.view.frame.width/48)!, NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.paragraphStyle : myParagraphStyle1])
        let attribute1 = NSMutableAttributedString(string: "DATE: \(dateOfIssue)\n", attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size:self.view.frame.width/48)!, NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.paragraphStyle : myParagraphStyle1])
        attribute0.append(attribute1)
        let attribute2 = NSMutableAttributedString(string: "POINTS: \(voteAverage)\n", attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size:self.view.frame.width/48)!, NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.paragraphStyle : myParagraphStyle1])
        attribute0.append(attribute2)
        let attribute3 = NSMutableAttributedString(string: "OVERVIEW: \(description)", attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size:self.view.frame.width/48)!, NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.paragraphStyle : myParagraphStyle1])
        attribute0.append(attribute3)
        //HelveticaNeue-Light
        cell.lblDetail.numberOfLines = 0
        cell.lblDetail.attributedText = attribute0
        cell.imgTvShow.sd_setImage(with: urlImage)
        
        return cell
    }

   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width/2.065, height:  self.view.frame.width/2.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCellId", for: indexPath)
          header.addSubview(searchBar)
          searchBar.translatesAutoresizingMaskIntoConstraints = false
          searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
          searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
          searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
          searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
      return header
  }

}
