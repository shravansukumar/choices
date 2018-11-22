//
//  VariantsRequester.swift
//  choices
//
//  Created by Shravan Sukumar on 17/11/18.
//  Copyright © 2018 shravan. All rights reserved.
//

import Foundation


enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}

final class VariantsRequester {
    
    typealias fetchVariantsClosure = ((_ masterVariant: MasterVar?,_ success: Bool) -> ())
    
    func fetchVariants(_ completion: @escaping fetchVariantsClosure) {
        guard let url = constructURLComponents().url else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, false)
            } else {
                let decoder = JSONDecoder()
                do {
                    if let data = data {
                        let variations = try decoder.decode(MasterVar.self, from: data)
                        completion(variations, true)
                    } else {
                        completion(nil, false)
                    }
                } catch let error {
                    print(error)
                    completion(nil, false)
                }
            }
        }
        task.resume()
    }
    
    private func constructURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.myjson.com"
        components.path = "/bins/3b0u2"
        return components
    }
    
}
