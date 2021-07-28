//
//  RESTHelper.swift
//  SecureStaticLibrary
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation
public class RESTHelper {
    //--------------------------------------------------------------------
    //GET
     public static func getRequest<T: Decodable>(url: String, completion: @escaping (T, NSError?) -> ()){
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!){(data,  response, err) in
            guard let data = data else {return}
            do{
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj, err as NSError?)
            }catch let jsonErr{
                print("Request, Failed to decode json:", jsonErr)
            }
        }.resume()
    }
}
