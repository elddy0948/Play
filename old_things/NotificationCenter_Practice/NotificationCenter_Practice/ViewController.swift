import UIKit

class ViewController: UIViewController {
  
  private var button: UIButton!
  private var titleLabel: UILabel!
  private var clubLabel: UILabel!
  
  let clubService = ClubService()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureTitleLabel()
    configureClubLabel()
    configureButton()
    
    //Register Notification Center
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(performDidFetchBestClub(_:)),
                                           name: .DidFetchBestClub,
                                           object: nil)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    layout()
  }
  
  @objc func performDidFetchBestClub(_ notification: Notification) {
    guard let bestClub = notification.userInfo?["club"] as? Club else {
      return
    }
    clubLabel.text = "\(bestClub.name)\n\(bestClub.homeGround)\n\(bestClub.homeStadium)"
  }
  
  @objc func buttonPressed(_ sender: UIButton) {
    clubService.fetchBestClub()
  }

}

extension ViewController {
  private func configureButton() {
    button = UIButton()
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Where is the best club?", for: .normal)
    button.setTitleColor(.link, for: .normal)
    button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
  }
  
  private func configureTitleLabel() {
    titleLabel = UILabel()
    view.addSubview(titleLabel)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.text = "🎉"
    titleLabel.font = UIFont.systemFont(ofSize: 32)
    titleLabel.numberOfLines = 1
    titleLabel.textColor = .label
  }
  
  private func configureClubLabel() {
    clubLabel = UILabel()
    view.addSubview(clubLabel)
    
    clubLabel.translatesAutoresizingMaskIntoConstraints = false
    clubLabel.text = ""
    clubLabel.textColor = .label
    clubLabel.textAlignment = .center
    clubLabel.font = UIFont.systemFont(ofSize: 24)
    clubLabel.numberOfLines = 3
  }
}


extension ViewController {
  private func layout() {
    let padding: CGFloat = 8
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
      titleLabel.heightAnchor.constraint(equalToConstant: 36),
      
      clubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      clubLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
      clubLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -padding),
      
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
      button.heightAnchor.constraint(equalToConstant: 24),
    ])
  }
}
