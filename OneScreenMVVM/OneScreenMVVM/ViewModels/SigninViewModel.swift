import Foundation
import RxSwift
import RxCocoa

class SigninViewModel: ViewModelType {
  struct Input {
    let email: Observable<String>     //Email textfield
    let password: Observable<String>  //Password textfield
    let signin: Observable<Void>      //Button
  }
  
  struct Output {
    let user: Observable<User>
  }
  
  func transform(input: Input) -> Output {
    let combinedForm = Observable.combineLatest(
      input.email, input.password
    )
    
    let user = input.signin
      .withLatestFrom(combinedForm)
      .map({ email, password -> User in
        return User(email: email, password: password)
      })
      .asObservable()
    
    return Output(user: user)
  }
}
