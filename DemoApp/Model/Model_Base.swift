
import Foundation
struct Model_Base : Codable {
	let title: String?
	let rows: [Rows]

	enum CodingKeys: String, CodingKey {
		case title = "title"
		case rows = "rows"
	}


}
