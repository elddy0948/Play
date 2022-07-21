//
//  ViewController.swift
//  DraggableLabel
//
//  Created by 김호준 on 2021/11/05.
//

import UIKit

class ViewController: UIViewController {
  
  var centerWhenBeganView: CGPoint = CGPoint(x: 0, y: 0)

  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavButton()
  }
}


extension ViewController {
  private func configureNavButton() {
    let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(configureAlertController))
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }
  
  @objc private func configureAlertController() {
    let alertController = UIAlertController(title: "Alert", message: "문자를 입력하세요", preferredStyle: .alert)
    alertController.addTextField { _ in }
    let doneAction = UIAlertAction(title: "Done", style: .default) { action in
      self.createLabel(alertController.textFields?.first?.text)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
    alertController.addAction(doneAction)
    alertController.addAction(cancelAction)
    
    self.present(alertController, animated: true, completion: nil)
  }
  
  private func createLabel(_ text: String?) {
    let label = UILabel()
    view.addSubview(label)
    let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                      action: #selector(handlePanGestureRecognizer(_:)))
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .label
    label.text = text
    label.addGestureRecognizer(panGestureRecognizer)
    label.isUserInteractionEnabled = true
    
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      label.heightAnchor.constraint(equalToConstant: 50),
      label.widthAnchor.constraint(equalToConstant: 100)
    ])
  }
  
  @objc private func handlePanGestureRecognizer(_ recognizer: UIPanGestureRecognizer) {
    guard let movableView = recognizer.view else {
      return
    }
    print(movableView)
    let translation = recognizer.translation(in: movableView.superview)
    switch recognizer.state {
    case .began:
      self.centerWhenBeganView = movableView.center
    case .changed:
      let newCenter = CGPoint(x: centerWhenBeganView.x + translation.x, y: centerWhenBeganView.y + translation.y)
      movableView.center = newCenter
    default:
      print("Default")
    }
  }
}
