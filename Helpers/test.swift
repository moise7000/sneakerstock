import SwiftUI
import SwiftSoup

import SwiftUI

struct ProductView: View {
  @State private var image: UIImage?
  let productID: String

  var body: some View {
    VStack {
      if image != nil {
        Image(uiImage: image!)
      } else {
        Text("Loading image...")
      }
    }.onAppear {
      loadImage(productID: self.productID) { result in
        switch result {
        case .success(let image):
          self.image = image
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
}

