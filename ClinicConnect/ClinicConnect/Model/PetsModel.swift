//
//  PetsModel.swift
//  ClinicConnect
//
//  Created by Macbook on 07/10/22.
//

import Foundation


struct PetsModel: Codable {
    let pets : [Pets]?
}

struct Pets : Codable {
    let image_url : String?
    let title : String?
    let content_url : String?
    let date_added : String?
}
