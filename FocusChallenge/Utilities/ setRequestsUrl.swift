//
//   setRequestsUrl.swift
//  FocusChallenge
//
//  Created by Carlos Rosales on 1/19/21.
//

import Foundation
import Alamofire

var URLRequest = ""
var apiKey = "252040e3e56967de88b87df4add3bc1a"
var readAccessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNTIwNDBlM2U1Njk2N2RlODhiODdkZjRhZGQzYmMxYSIsInN1YiI6IjVlNDBiMTk5M2RkMTI2MDAxNjU0YzQ4OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fVEiY8YlxM6invE2qixRiythEA5vVsemWrekBV2Ia9U"

func getUrl(section: Int){
    switch section {
    case 0: //login
         URLRequest = "https://reqres.in/api/login"
    case 1:
         URLRequest = ""
    case 2: // get popular Movies
         URLRequest = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"//"&language=en-US&page=1"
    case 3: // get Image
         URLRequest = "https://image.tmdb.org/t/p/w500"//jQNOzoiaIQWxJAx8OUighnvnhRA.jpg"
    case 4: //search
         URLRequest = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)"
     default:
        URLRequest = ""
    }
}


func getUrl(section: Int, supplementaryDataURL: String) -> String
{
    getUrl(section: section)
    var finalURL : String
        finalURL = URLRequest + supplementaryDataURL

    finalURL = finalURL.replacingOccurrences(of: " ", with: "")
    
    return finalURL
}




