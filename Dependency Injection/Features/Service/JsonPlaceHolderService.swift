//
//  JsonPlaceHolderService.swift
//  Dependency Injection
//
//  Created by Talha on 17.10.2022.
//

import Alamofire


protocol JsonPlaceHolderProtocol {
    func fetchAllPosts(onSuccess: @escaping ([PostModel])-> Void, onFail: @escaping (String?)-> Void)
}
enum JsonPlaceHolderPath: String {
    case POSTS = "/posts"
}
extension JsonPlaceHolderPath {
    func withBaseUrl() -> String {
        return "https://jsonplaceholder.typicode.com\(self.rawValue)"
    }
}

struct JsonPlaceHolderService: JsonPlaceHolderProtocol {
    func fetchAllPosts(onSuccess: @escaping ([PostModel]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(JsonPlaceHolderPath.POSTS.withBaseUrl(), method: .get).validate().responseDecodable(of: [PostModel].self) {
            (response) in
            
            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
    
    
}
