import Foundation
import UIKit

final class ImageCache {
    static let shared = ImageCache()  // Singleton instance
    private init() {}

    // Change private to internal
    let cacheDirectory: URL = {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("ImageCache")
    }()

    func loadImage(from url: URL) async throws -> UIImage {
        let cachedPath = cacheDirectory.appendingPathComponent(url.lastPathComponent)

        // Check if the image is already cached
        if FileManager.default.fileExists(atPath: cachedPath.path),
           let imageData = try? Data(contentsOf: cachedPath),
           let image = UIImage(data: imageData) {
            return image
        }

        // Download and cache the image
        let (data, _) = try await URLSession.shared.data(from: url)
        try FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        try data.write(to: cachedPath)
        guard let image = UIImage(data: data) else {
            throw URLError(.badURL)
        }
        return image
    }
}

