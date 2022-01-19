import UIKit
import LBJMediaBrowser

private let imageUrls = [
  "https://i.picsum.photos/id/249/1000/2000.jpg?hmac=LuHPEUVkziRf9usKW97DBxEzcifzgiCiRtm8vuJNZ9Q",
  "https://i.picsum.photos/id/17/1000/1000.jpg?hmac=5FRnLOBphDqiw_x9GZSSzNW0nfUgQ7kAVZdigKUxZvg",
  "https://media1.giphy.com/media/3o6Mbbs879ozZ9Yic0/giphy.gif?cid=790b7611f1db1ba27ec414c5d5b14fa0e0b6a1e216267dd0&rid=giphy.gif&ct=g",
  "https://www.example.com/test.png",
  "https://i.picsum.photos/id/62/1000/1500.jpg?hmac=6RG38x1oSbkw0aEoiHACAHEbUczQo_wXH22k0EWrueg",
  "https://i.picsum.photos/id/573/2000/3000.jpg?hmac=zWDJVoZPjb0L4jo_u7oXLC4m1dVJdI6Taoqu_6Ur1fM",
  "https://i.picsum.photos/id/988/1200/1300.jpg?hmac=TY3ULGEPR0nHWAYN8iqJZ0tHr4OK4MhBC5BgMiRV5Ls",
  "https://i.picsum.photos/id/1050/2000/1500.jpg?hmac=1wCAxLdsQCb2Yg99hfj0J-dCOshexlB3cKYM_pQOofw",
  "https://i.picsum.photos/id/287/1200/1600.jpg?hmac=nGoOXgqOvwXAOSfKNgRjmnCAj_Z85vau56xcj13KGR0",
  "https://i.picsum.photos/id/550/1400/2500.jpg?hmac=wz6FC8u4baJmQU-B4-OOyu8nMXO-b7VmupGSt7wi-oE",
  "https://i.picsum.photos/id/260/1200/500.jpg?hmac=ZMJeETUAlzrHjlwB72i76bB0zJjzpyPB1BVNwunC3uY"
]

private let videoNames = [
  "BigBuckBunny",
  "ElephantsDream",
  "ForBiggerBlazes",
  "ForBiggerEscapes",
  "ForBiggerJoyrides",
  "ForBiggerMeltdowns",
  "Sintel"
]

enum MockData { }

// MARK: - Default Medias
extension MockData {
  static let uiImages: [MediaUIImage] = (1...3)
    .compactMap { UIImage(named: "IMG_000\($0)") }
    .map { MediaUIImage(uiImage: $0) }

  static let gifImages: [MediaGifImage] = ["lebron", "curry"].map { MediaGifImage(source: .bundle(name: $0, bundle: .main)) }

  static let urlImages = imageUrls
    .map { MediaURLImage(imageUrl: URL(string: $0)!) }

  static let urlVideos: [MediaURLVideo] = {
    var videos = videoNames
      .map { name -> MediaURLVideo in
        let prefix = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample"
        return MediaURLVideo(
          videoUrl: URL(string: "\(prefix)/\(name).mp4")!,
          previewImageUrl: URL(string: "\(prefix)/images/\(name).jpg")!
        )
      }

    videos.append(.init(
      videoUrl: Bundle.main.url(forResource: "ForBiggerFun", withExtension: "mp4")!,
      previewImageUrl: nil
    ))

    return videos
  }()

  static let mixedMedias = [uiImages, gifImages, urlImages, urlVideos]
    .compactMap { $0 as? [Media] }
    .reduce([], +)
}

// MARK: - Custom Medias
extension MockData {
  static let myUIImages: [MyMediaUIImage] = (1...3)
    .map { (UIImage(named: "IMG_000\($0)")!, "UIImage \($0)") }
    .map { MyMediaUIImage(uiImage: $0.0, caption: $0.1) }

  static let myGifImages: [MyMediaGifImage] = ["lebron", "curry"].map { MyMediaGifImage(source: .bundle(name: $0, bundle: .main), caption: $0) }

  static let myURLImages = imageUrls.indices
    .map { MyMediaURLImage(imageUrl: URL(string: imageUrls[$0])!, caption: "URLImage \($0)") }

  static let myURLVideos: [MyMediaURLVideo] = {
    var videos = videoNames
      .map { name -> MyMediaURLVideo in
        let prefix = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample"
        return MyMediaURLVideo(
          videoUrl: URL(string: "\(prefix)/\(name).mp4")!,
          previewImageUrl: URL(string: "\(prefix)/images/\(name).jpg")!,
          caption: name
        )
      }

    videos.append(.init(
      videoUrl: Bundle.main.url(forResource: "ForBiggerFun", withExtension: "mp4")!,
      previewImageUrl: nil,
      caption: "The video in bundle"
    ))

    return videos
  }()

  static let mixedMyMedias = [myUIImages, myGifImages, myURLImages, myURLVideos]
    .compactMap { $0 as? [Media] }
    .reduce([], +)
}
