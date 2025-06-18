//
//  APIRequest.swift
//  DemoProductApp
//
//  Created by Ashish Pal on 17/06/25.
//

import Foundation

struct APIRequest {
    let url: URL
    let method: String
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
