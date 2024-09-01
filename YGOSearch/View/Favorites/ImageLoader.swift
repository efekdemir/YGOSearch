//
//  ImageLoader.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/17/24.
//

import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: Image?
    private var cancellable: AnyCancellable?
    private var cache = ImageCache.getImageCache()

    func load(url: URL) {
        if let image = cache.get(forKey: url.absoluteString) {
            self.image = image
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ in Image(uiImage: UIImage(data: data) ?? UIImage(resource: .ygoSearch) ) }
            .catch { _ in Just(Image(systemName: "photo")) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.image = $0
                self?.cache.set(forKey: url.absoluteString, image: $0)
            }
    }
}

class ImageCache {
    var cache = NSCache<NSString, AnyObject>()
    
    static var imageCache = ImageCache()
    
    static func getImageCache() -> ImageCache {
        return imageCache
    }
    
    func get(forKey: String) -> Image? {
        return cache.object(forKey: NSString(string: forKey)) as? Image
    }
    
    func set(forKey: String, image: Image) {
        cache.setObject(image as AnyObject, forKey: NSString(string: forKey))
    }
}

struct AsyncImageView: View {
    @StateObject private var loader = ImageLoader()
    var url: URL

    init(url: URL) {
        self.url = url
    }

    var body: some View {
        Group {
            if let image = loader.image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
            }
        }
        .onAppear {
            loader.load(url: url)
        }
    }
}
