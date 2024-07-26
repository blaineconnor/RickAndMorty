//
//  RickAndMortyService.swift
//  RickAndMorty
//
//  Created by Fatih Emre Sarman on 29.02.2024.
//

import Alamofire

enum RickAndMortyServiceEndPoint: String {
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH =  "/character"
    
    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRickAndMortyService {
    func fetchAllDatas(response: @escaping ([Result]?) -> Void)
}

struct RickAndMortyService: IRickAndMortyService {
    func fetchAllDatas(response: @escaping ([Result]?) -> Void) {
        AF.request(RickAndMortyServiceEndPoint.characterPath()).responseDecodable(of: PostModel.self) { (model)  in
            
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data.results)           
        }
    }
}
