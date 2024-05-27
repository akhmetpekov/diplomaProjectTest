//
//  ImageLoader.swift
//  MyAITU
//
//  Created by Erik on 23.05.2024.
//

import UIKit

class ImageLoader {
    static func downloadImage(_ urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return image
    }
}
