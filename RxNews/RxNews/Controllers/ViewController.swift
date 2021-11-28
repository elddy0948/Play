//
//  ViewController.swift
//  RxNews
//
//  Created by 김호준 on 2021/11/26.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .systemBackground
    tableView.dataSource = self
    
    tableView.tableFooterView = UIView()
    
    //Register Cells
    tableView.register(ArticleTableViewCell.self,
                       forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)
    return tableView
  }()
  
  private lazy var activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.hidesWhenStopped = true
    indicator.tintColor = .label
    return indicator
  }()
  
  private let bag = DisposeBag()
  private let articleResponseViewModel = ArticleResponseViewModel()
  private var articleViewModels = [ArticleViewModel]() {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupTableView()
    setupActivityIndicator()
    
    activityIndicator.startAnimating()
    articleResponseViewModel.fetchArticleResponse()
      .subscribe(onNext: { [weak self] articleViewModels in
        self?.articleViewModels = articleViewModels
      }, onError: { _ in
        print("Error occured!")
      }, onCompleted: { [weak self] in
        DispatchQueue.main.async {
          self?.activityIndicator.stopAnimating()
        }
      })
      .disposed(by: bag)
  }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articleViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier,
                                                   for: indexPath) as? ArticleTableViewCell else {
      return UITableViewCell()
    }
    
    let articleViewModel = articleViewModels[indexPath.row]
    cell.setupCellData(with: articleViewModel)
    
    return cell
  }
}

//MARK: - UI
extension ViewController {
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
    ])
  }
  
  private func setupActivityIndicator() {
    tableView.addSubview(activityIndicator)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
    ])
  }
}
