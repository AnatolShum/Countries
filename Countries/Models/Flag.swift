//
//  Flag.swift
//  Countries
//
//  Created by Anatolii Shumov on 29.02.2024.
//

import Foundation
import SwiftData

@Model
class Flag: Codable {
    var url: String?
    var info: String?
    
    init(url: String?, info: String?) {
        self.url = url
        self.info = info
    }
    
    enum CodingKeys: String, CodingKey {
        case url = "png"
        case info = "alt"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(String?.self, forKey: .url) ?? nil
        info = try container.decodeIfPresent(String?.self, forKey: .info) ?? nil
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(info, forKey: .info)
    }
}
