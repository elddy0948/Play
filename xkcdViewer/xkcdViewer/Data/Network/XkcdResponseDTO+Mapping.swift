import Foundation

struct XkcdResponseDTO: Decodable {
  let month: String
  let num: Int
  let link: String
  let year: String
  let news: String
  let safeTitle: String
  let transcript: String
  let alt: String
  let img: String
  let title: String
  let day: String
  
  enum CodingKeys: String, CodingKey {
    case month, num, link, year, news
    case safeTitle = "safe_title"
    case transcript, alt, img, title, day
  }
}

extension XkcdResponseDTO {
  func toDomain() -> Xkcd {
    return Xkcd(
      month: month,
      num: num,
      link: link,
      year: year,
      news: news,
      safeTitle: safeTitle,
      transcript: transcript,
      alt: alt,
      img: img,
      title: title,
      day: day)
  }
}
