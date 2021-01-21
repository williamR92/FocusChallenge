//
//  TvProgramsRequest.swift
//  FocusChallenge
//
//  Created by Carlos Rosales on 1/19/21.
//

import Foundation
import Alamofire

enum MoviesRequestError:Error{
    case noDataAvailable
    case invalidUser
    case noConnectedToNetwork
}

struct MoviesRequest {
    var resourceURL : String
      var urlComplement : String
      
    init(language: String, find : Int = 0, keyword : String = "") {
        if(find == 0){
            self.urlComplement = "&language=\(language)&page=1"
            self.resourceURL = getUrl(section: 2, supplementaryDataURL: urlComplement)
            
        }else{
            self.urlComplement = "&language=en-US&query=\(keyword)&page=1&include_adult=true"
            self.resourceURL = getUrl(section: 4, supplementaryDataURL: urlComplement)
        }
      }
    
    func getTvPrograms (completion: @escaping(Result<[MovieDetail]>) -> Void){
        print(resourceURL)
        Alamofire.request(resourceURL, method: .get, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            do{
                var ProgramsResultt = [MovieDetail]()
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        let decoder = JSONDecoder()
                        guard let jsonData = response.data else{ completion(.failure(MoviesRequestError.noDataAvailable)); return }
                        let tvProgramsResultResponse = try decoder.decode(Movies.self, from: jsonData)
                        ProgramsResultt = tvProgramsResultResponse.results
                        completion(.success(ProgramsResultt))
                        break
                    case 404:
                        completion(.failure(MoviesRequestError.noDataAvailable))
                        break
                    default:
                        completion(.failure(MoviesRequestError.noDataAvailable))
                    }
                } else {
                    completion(.failure(MoviesRequestError.noDataAvailable))
                }
                
            }catch let error as NSError{
                print(error)
                completion(.failure(MoviesRequestError.noDataAvailable))
            }
            
        }
    }
}

