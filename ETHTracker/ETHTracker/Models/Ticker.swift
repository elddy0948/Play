import Foundation

struct Ticker: Decodable {
  let symbol: String
  let tickType: TickType
  let date: String
  let time: String
  let openPrice: String
  let closePrice: String
  let lowPrice: String
  let highPrice: String
  let value: String
  let volume: String
  let sellVolume: String // 매도 누적 거래량
  let buyVolume: String // 매수 누적 거래량
  let prevClosePrice: String // 전일 종가
  let chgRate: String // 변동률
  let chgAmt: String // 변동금액
  let volumePower: String // 체결강도
}
