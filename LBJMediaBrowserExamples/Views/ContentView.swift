import SwiftUI

struct ContentView: View {

  var body: some View {
    NavigationView {
      List {
        ForEach(Example.allCases, id: \.self) { example in
          NavigationLink(destination: ExampleView(example: example)) {
            Text(example.title)
          }
        }
      }
      .navigationTitle("Examples")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
