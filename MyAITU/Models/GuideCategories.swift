//
//  GuideCategories.swift
//  MyAITU
//
//  Created by Erik on 19.05.2024.
//

import Foundation

struct GuideCategories {
    let title: String
    let icon: String
}

extension GuideCategories {
    static func getGuideCategories() -> [GuideCategories] {
        return [
            GuideCategories(title: "Basic concepts", icon: "book.fill"),
            GuideCategories(title: "Rules of educational process", icon: "exclamationmark"),
            GuideCategories(title: "Navigation of Microsoft Teams", icon: "teams"),
            GuideCategories(title: "Navigation of Moodle", icon: "logoAitu"),
            GuideCategories(title: "Student support services", icon: "info.bubble.fill"),
            GuideCategories(title: "Internal and work regulations", icon: "text.justify.leading"),
            GuideCategories(title: "Rules of academic integrity", icon: "hand.raised.square.on.square.fill"),
            GuideCategories(title: "Regulation on academic mobility", icon: "airplane"),
            GuideCategories(title: "Rules of the system for evaluating", icon: "a.circle.fill"),
            GuideCategories(title: "Instructions of the exam session", icon: "eye.fill")
        ]
    }
}
