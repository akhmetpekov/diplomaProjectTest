//
//  Student.swift
//  MyAITU
//
//  Created by Erik on 14.05.2024.
//

import Foundation

struct Student {
    let student_image: String
    let IIN: String
    let birthdate: String
    let course: String
    let degree: String
    let department: String
    let education_program: String
    let educational_program_code: String
    let email: String
    let financing: String
    let group: String
    let is_academic_mobility: Bool
    let is_retire: Bool
    let middlename_cyrillic: String
    let name_cyrillic: String
    let name_latin: String
    let phone: String
    let student_status: String
    let surname_cyrillic: String
    let surname_latin: String
    let gender: String
    let barcode: String
    
    var FIO: String {
        return "\(surname_cyrillic) \(name_cyrillic) \(middlename_cyrillic)"
    }
    
    init() {
        self.student_image = ""
        self.IIN = ""
        self.birthdate = ""
        self.course = ""
        self.degree = ""
        self.department = ""
        self.education_program = ""
        self.educational_program_code = ""
        self.email = ""
        self.financing = ""
        self.group = ""
        self.is_academic_mobility = false
        self.is_retire = false
        self.middlename_cyrillic = ""
        self.name_cyrillic = ""
        self.name_latin = ""
        self.phone = ""
        self.student_status = ""
        self.surname_cyrillic = ""
        self.surname_latin = ""
        self.gender = ""
        self.barcode = ""
    }
    
    init?(dictionary: [String: Any]) {
        guard let IIN = dictionary["IIN"] as? String,
              let birthdate = dictionary["birthdate"] as? String,
              let course = dictionary["course"] as? String,
              let degree = dictionary["degree"] as? String,
              let department = dictionary["department"] as? String,
              let education_program = dictionary["education_program"] as? String,
              let educational_program_code = dictionary["educational_program_code"] as? String,
              let email = dictionary["email"] as? String,
              let financing = dictionary["financing"] as? String,
              let group = dictionary["group"] as? String,
              let is_academic_mobility = dictionary["is_academic_mobility"] as? Bool,
              let is_retire = dictionary["is_retire"] as? Bool,
              let middlename_cyrillic = dictionary["middlename_cyrillic"] as? String,
              let name_cyrillic = dictionary["name_cyrillic"] as? String,
              let name_latin = dictionary["name_latin"] as? String,
              let phone = dictionary["phone"] as? String,
              let student_status = dictionary["student_status"] as? String,
              let surname_cyrillic = dictionary["surname_cyrillic"] as? String,
              let gender = dictionary["gender"] as? String,
              let barcode = dictionary["barcode"] as? String,
              let student_image = dictionary["student_image"] as? String,
              let surname_latin = dictionary["surname_latin"] as? String else {
            return nil
        }
        
        self.IIN = IIN
        self.birthdate = birthdate
        self.course = course
        self.degree = degree
        self.department = department
        self.education_program = education_program
        self.educational_program_code = educational_program_code
        self.email = email
        self.financing = financing
        self.group = group
        self.is_academic_mobility = is_academic_mobility
        self.is_retire = is_retire
        self.middlename_cyrillic = middlename_cyrillic
        self.name_cyrillic = name_cyrillic
        self.name_latin = name_latin
        self.phone = phone
        self.student_status = student_status
        self.surname_cyrillic = surname_cyrillic
        self.surname_latin = surname_latin
        self.gender = gender
        self.barcode = barcode
        self.student_image = student_image
    }
}
