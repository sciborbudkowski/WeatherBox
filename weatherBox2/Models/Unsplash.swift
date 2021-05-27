//
//  Unsplash.swift
//  weatherBox2
//
//  Created by Ścibor Budkowski on 26/04/2021.
//

import Foundation

struct UnsplashPhoto: Decodable {
    
    let id: String
    let createdAt: String
    let updatedAt: String?
    let promotedAt: String?
    let width: Int
    let height: Int
    let color: String
    let description: String?
    let altDescription: String?
    let urls: UnsplashPhotoUrls
    let user: UnsplashUser
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width
        case height
        case color
        case description
        case altDescription = "alt_description"
        case urls
        case user
    }
}

struct UnsplashPhotoUrls: Decodable {
    
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    
    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct UnsplashUser: Decodable {
    
    let id: String
    let updatedAt: String
    let username: String
    let name: String?
    let firstName: String?
    let lastName: String?
    let portfolioUrl: String?
    let bio: String?
    let location: String?
    let links: UnsplashUserLinks
    let profileImage: UnsplashUserProfileImage
    
    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case portfolioUrl = "portfolio_url"
        case bio
        case location
        case links
        case profileImage = "profile_image"
    }
}

struct UnsplashUserLinks: Decodable {
    
    let html: String
    
    enum CodingKeys: String, CodingKey {
        case html
    }
}

struct UnsplashUserProfileImage: Decodable {
    
    let small: String
    let medium: String
    let large: String
    
    enum CodingKeys: String, CodingKey {
        case small
        case medium
        case large
    }
}
