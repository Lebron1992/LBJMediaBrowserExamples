import SwiftUI

struct MyErrorView: View {

  let error: Error
  let retry: (() -> Void)?

  init(error: Error, retry: (() -> Void)? = nil) {
    self.error = error
    self.retry = retry
  }

  var body: some View {
    GeometryReader { geometry in
      VStack {
      Text(error.localizedDescription)
        .foregroundColor(.white)
        .padding(4)

        if let retry = retry {
          Button {
            retry()
          } label: {
            Text("Retry")
              .font(.system(size: 16, weight: .regular))
              .foregroundColor(.black)
              .frame(width: 100, height: 40)
              .background(Color.white)
              .cornerRadius(20)
          }
        }
      }
      .frame(width: geometry.size.width, height: geometry.size.height)
    }
  }
}
