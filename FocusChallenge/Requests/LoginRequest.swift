//
//  LoginRequest.swift
//  FocusChallenge
//
//  Created by Carlos Rosales on 1/20/21.
//

import Foundation
import Alamofire

struct LoginRequest {
    var resourceURL : String
    var urlComplement : String
    var user : String
    var pass : String
      
    init(user_: String, pass_ : String) {
        
            self.urlComplement = ""
            self.resourceURL = getUrl(section: 0, supplementaryDataURL: urlComplement)
        self.user = user_
        self.pass = pass_
        
      }
    
    func getLoguin (completion: @escaping(Result<LoginResponse>) -> Void){
        print(resourceURL)
        Alamofire.request(resourceURL, method: .post, parameters: Body(),encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            do{
                let Resultt = LoginResponse()
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        
                        let decoder = JSONDecoder()
                        guard let jsonData = response.data else{ completion(.failure(MoviesRequestError.noDataAvailable)); return }
                        let Response = try decoder.decode(LoginOk.self, from: jsonData)
                        Resultt.dataOk = Response
                        Resultt.code = "200"
                        completion(.success(Resultt))
                        break
                    case 400:
                        completion(.failure(MoviesRequestError.invalidUser))
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
    
    func Body() -> Parameters {
        var parameters = Parameters()
        parameters = [
            "email": user,
            "password": pass
        ]
        return parameters
    }
}
