//
//  Events.swift
//  MyAITU
//
//  Created by Erik on 19.05.2024.
//

import Foundation

struct Event {
    let banner_url: String
    let description: String
    let event_type: String
    let registration_link: String
    let title: String
//    let date: Date
    
    
    init?(dictionary: [String: Any]) {
        guard let banner_url = dictionary["banner_url"] as? String,
              let description = dictionary["description"] as? String,
              let event_type = dictionary["event_type"] as? String,
              let title = dictionary["title"] as? String,
//              let date = dictionary["ends_at"] as? Date,
              let registration_link = dictionary["registration_link"] as? String else {
                  return nil
              }
        
        self.banner_url = banner_url
        self.event_type = event_type
        self.description = description
        self.registration_link = registration_link
        self.title = title
//        self.date = date
    }
}

