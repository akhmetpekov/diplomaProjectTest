//
//  Student.swift
//  MyAITU
//
//  Created by Erik on 14.05.2024.
//

import Foundation

struct Student {
    let name: String
    let surname: String
    let middleName: String?
    
    var FIO: String {
        "\(surname) \(name) \(middleName ?? "")"
    }
    
    let IIN: String
    let birthdate: String
    let sex: String
    let nationality: String
    let citizen: String
    let address: String
    let group: String
    let course: String
    let degree: String
    let departament: String
    let email: String
}

extension Student {
    static func getStudentInfo() -> [Student] {
        return [
            Student(
                name: "Эрик",
                surname: "Ахметпеков",
                middleName: "Муратович",
                IIN: "031007500554",
                birthdate: "07.10.2003",
                sex: "Мужской",
                nationality: "КАЗАХ",
                citizen: "Казахстан",
                address: "Мангилик ел 51",
                group: "SE-2113",
                course: "3",
                degree: "Бакалавриат",
                departament: "Software Engineering",
                email: "akhmetpekov@gmail.com"
            )
        ]
    }
}
