//
//  Announcements.swift
//  MyAITU
//
//  Created by Erik on 25.05.2024.
//

import Foundation

struct Announcement {
    let banner_url: String
    let description: String
    let has_banner: Bool
//    let author: String
    let title: String
//    let published_at: Date
    
    init?(dictionary: [String: Any]) {
        guard let banner_url = dictionary["banner_url"] as? String,
              let description = dictionary["description"] as? String,
              let has_banner = dictionary["has_banner"] as? Bool,
              let title = dictionary["title"] as? String else {
                  return nil
              }
        
        self.banner_url = banner_url
        self.has_banner = has_banner
        self.description = description
        self.title = title
//        self.date = date
    }
}
