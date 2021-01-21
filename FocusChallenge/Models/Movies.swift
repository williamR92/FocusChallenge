//
//  TvPrograms.swift
//  FocusChallenge
//
//  Created by Carlos Rosales on 1/19/21.
//

import Foundation

struct Movies: Decodable {
    var results: [MovieDetail]
}

struct MovieDetail: Decodable {
    var id : Int!
    var title : String!
    var vote_count : Int!
    var release_date : String!
    var poster_path : String!
    var overview : String!
    var vote_average : Double!
}

//var id : Int
//var name : String
//var vote_count : Int
//var first_air_date : String
//var poster_path : String
//var overview : String
//var vote_average : Decimal
