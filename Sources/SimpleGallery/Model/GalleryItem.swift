//
//  File.swift
//  
//
//  Created by daniel.da.cunha.lima on 05/01/21.
//

import Foundation

public enum GalleryItemType {
    case picture
    case video
}

public struct GalleryItem {

    public let imageURL: URL
    public var videoURL: URL?
    public let type: GalleryItemType

    public init(imageURL: URL, videoURL: URL? = nil) {
        self.imageURL = imageURL
        self.videoURL = videoURL
        self.type = videoURL != nil ? .video : .picture
    }

}
