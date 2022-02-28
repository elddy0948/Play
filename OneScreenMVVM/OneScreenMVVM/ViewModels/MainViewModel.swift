import RxSwift
import RxCocoa

class MainViewModel: ViewModelType {
  struct Input {
    let user: User
  }
  
  struct Output {
    let greeting: Driver<String>
  }
  
  func transform(input: Input) -> Output {
    let greeting = Observable<String>.just(
      "Hello!\n\(input.user.email)\n")
      .asDriver(onErrorJustReturn: "Hello!\nAnonymous\n")
    
    return Output(greeting: greeting)
  }
}
