//
//  ResultsCollectionViewController.swift
//  FocusChallenge
//
//  Created by Carlos Rosales on 1/20/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class ResultsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  var nameMovie = ""
    
    var lisOfMovies = [MovieDetail]() {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lisOfMovies = [MovieDetail]()
        
        
        sendRequest()
        self.navigationItem.title = nameSearch

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = self.view.frame.width/36
        self.collectionView = UICollectionView(frame: self.collectionView!.frame, collectionViewLayout: layout)
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        
        self.collectionView!.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(MoviesCollectionViewCell.self))
    }

    override func viewDidLayoutSubviews() {
        
    }
    
    func sendRequest() {
        let tvRequest = MoviesRequest(language: "en-US", find: 1, keyword: nameSearch)
        tvRequest.getTvPrograms{ [weak self] result  in
            switch result{
            case .failure(let error):
                print(error)
                Alert.Warning(delegate: self!, message: "no results!!")
                break
            case .success(let tvShows):
                self?.lisOfMovies = tvShows
                break
            }
        }
       }

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
        
        var urlImage = URL(string: "https://iconsplace.com/wp-content/uploads/_icons/ffe500/256/png/error-icon-19-256.png")
        if let url_ = lisOfMovies[index].poster_path{
            urlImage = URL(string: getUrl(section: 3, supplementaryDataURL: url_))!
        }
        
        
    
        var title = "N/A"
        if let title_ = lisOfMovies[index].title{
            title = title_
        }
        
        var dateOfIssue = "N/A"
        if let dateOfIssue_ = lisOfMovies[index].release_date{
            dateOfIssue = dateOfIssue_
        }
        
        var voteAverage = 0.0
        if let voteAverage_ = lisOfMovies[index].vote_average{
            voteAverage = voteAverage_
        }
        
        var description = "N/A"
        if let description_ = lisOfMovies[index].overview{
            description = description_
        }
        
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
    


}
