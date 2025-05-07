//
//  ProductCache.swift
//  FakeStore
//
//  Created by Aya on 06/05/2025.
//

import Foundation

struct ProductCache {
    let documentDirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    let fileName = "products.json"
    
    // can also be written with the do catch approche
    //which is better since we don't have to proceed this func call with a try
    
    func getProducts() throws -> [Product]? {
        
        guard let fileUrl = documentDirURL?.appending(path: fileName) else { return nil }
        guard FileManager.default.fileExists(atPath: fileUrl.path) else { return nil }
        let data = try Data(contentsOf: fileUrl)
        return try JSONDecoder().decode([Product].self, from: data)
    }
    
    func saveProducts(_ products: [Product]) {
        guard let fileUrl = documentDirURL?.appending(path: fileName) else { return }
        
        do {
            let data = try JSONEncoder().encode(products)
            try data.write(to: fileUrl)
        } catch {
            print("Failed to save products") // or log
        }
    }
    
    func invalidateCache() {
        guard let fileURL = documentDirURL?.appending(path: fileName) else { return }
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print("Failed to save products") // or log
        }
    }
}
