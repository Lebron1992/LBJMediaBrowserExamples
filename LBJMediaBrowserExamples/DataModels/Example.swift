import LBJMediaBrowser

enum Example: CaseIterable {
  case grid
  case customGrid
  case paging
  case customPaging

  var isCustom: Bool {
    switch self {
    case .grid, .paging:
      return false
    case .customGrid, .customPaging:
      return true
    }
  }

  var title: String {
    switch self {
    case .grid:
      return "Grid Example"
    case .customGrid:
      return "Custom Grid Example"
    case .paging:
      return "Paging Example"
    case .customPaging:
      return "Custom Paging Example"
    }
  }
}
