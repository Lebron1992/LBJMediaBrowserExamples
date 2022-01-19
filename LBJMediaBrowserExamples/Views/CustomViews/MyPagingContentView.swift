import AVKit
import SwiftUI
import LBJMediaBrowser
import LBJImagePreviewer

struct MyPagingContentView: View {
  let result: MediaLoadedResult

  @State
  private var playVideo = false

  var body: some View {
    GeometryReader { geometry in
      switch result {
      case .stillImage(let image, let uiImage):
        view(for: image, withUIImage: uiImage, in: geometry)
      case .gifImage(let image, let data):
        view(for: image, withData: data, in: geometry)
      case .video(let video, let previewImage, let videoUrl):
        view(for: video, withPreviewImage: previewImage, andVideoUrl: videoUrl,  in: geometry)
      }
    }
  }

  func view(
    for image: MediaImage,
    withUIImage uiImage: UIImage,
    in geometry: GeometryProxy
  ) -> some View {

    ZStack(alignment: .bottom) {
      LBJUIImagePreviewer(uiImage: uiImage)
      if let media = image as? MyMedia {
        captionView(for: media)
      }
    }
    .frame(width: geometry.size.width, height: geometry.size.height)
  }

  func view(
    for image: MediaImage,
    withData data: Data,
    in geometry: GeometryProxy
  ) -> some View {

    ZStack(alignment: .bottom) {
      LBJGIFImagePreviewer(imageData: data)
      if let media = image as? MyMedia {
        captionView(for: media)
      }
    }
    .frame(width: geometry.size.width, height: geometry.size.height)
  }

  func view(
    for video: MediaVideo,
    withPreviewImage previewImage: UIImage?,
    andVideoUrl videoUrl: URL,
    in geometry: GeometryProxy
  ) -> some View {

    ZStack(alignment: .bottom) {
      ZStack {
        if let previewImage = previewImage {
          Image(uiImage: previewImage)
            .resizable()
            .aspectRatio(nil, contentMode: .fit)
        }
        Button {
          playVideo = true
        } label: {
          Image(systemName: "play.circle")
            .font(.system(size: 40, weight: .light))
            .foregroundColor(.white)
        }
      }
      .frame(width: geometry.size.width, height: geometry.size.height)
      if let media = video as? MyMedia {
        captionView(for: media)
      }
    }
    .sheet(isPresented: $playVideo) {
      VideoPlayer(player: AVPlayer(url: videoUrl))
    }
  }

  func captionView(for media: MyMedia) -> some View {
    Text(media.caption)
      .font(.system(size: 16))
      .foregroundColor(.white)
      .padding(4)
      .background(Color.gray)
  }
}
