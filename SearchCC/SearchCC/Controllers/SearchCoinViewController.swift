import UIKit
import RxCocoa
import RxSwift

class SearchCoinViewController: UIViewController {
  
  private var searchCrypto: UITextField!
  private var coinImageView: UIImageView!
  private var coinNameLabel: UILabel!
  
  private let placeholderImage = UIImage(systemName: "questionmark.circle")!
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureSearchCrypto()
    configureImageView()
    configureCoinNameLabel()
    
    let search = searchCrypto.rx
      .controlEvent(.editingDidEndOnExit)
      .map { self.searchCrypto.text ?? "" }
      .filter { !$0.isEmpty }
      .flatMapLatest({ text in
        APIRequest.shared
          .fetchCoin(name: text)
      })
      .asDriver(onErrorJustReturn: .empty)
    
    search.map(\.name)
      .drive(coinNameLabel.rx.text)
      .disposed(by: disposeBag)
  }
  
  private func configureSearchCrypto() {
    let padding: CGFloat = 8
    
    searchCrypto = UITextField()
    view.addSubview(searchCrypto)
    
    searchCrypto.translatesAutoresizingMaskIntoConstraints = false
    searchCrypto.placeholder = "Search Crypto ex)bitcoin"
    searchCrypto.autocorrectionType = .no
    searchCrypto.autocapitalizationType = .none
    
    NSLayoutConstraint.activate([
      searchCrypto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
      searchCrypto.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      searchCrypto.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      searchCrypto.heightAnchor.constraint(equalToConstant: 32),
    ])
  }
  
  private func configureImageView() {
    coinImageView = UIImageView(image: placeholderImage)
    view.addSubview(coinImageView)
    
    coinImageView.translatesAutoresizingMaskIntoConstraints = false
    coinImageView.contentMode = .scaleAspectFit
    coinImageView.tintColor = .label
    
    NSLayoutConstraint.activate([
      coinImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      coinImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      coinImageView.heightAnchor.constraint(equalToConstant: 100),
      coinImageView.widthAnchor.constraint(equalToConstant: 100),
    ])
  }
  
  private func configureCoinNameLabel() {
    let padding: CGFloat = 8
    
    coinNameLabel = UILabel()
    view.addSubview(coinNameLabel)
    
    coinNameLabel.translatesAutoresizingMaskIntoConstraints = false
    coinNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    coinNameLabel.textColor = .label
    coinNameLabel.textAlignment = .center
    coinNameLabel.text = "Coin Name"
    
    NSLayoutConstraint.activate([
      coinNameLabel.topAnchor.constraint(equalTo: coinImageView.bottomAnchor, constant: padding),
      coinNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      coinNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      coinNameLabel.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
}

