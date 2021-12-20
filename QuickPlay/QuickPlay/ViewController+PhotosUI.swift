//
//  ViewController+PhotosUI.swift
//  QuickPlay
//
//  Created by 김호준 on 2021/12/20.
//

import PhotosUI

//MARK: - PhotosUI
extension ViewController {
  func setupPHPickerViewController() {
    let configuration = setupConfiguration()
    let viewController = createPHPickerViewController(
      with: configuration
    )
    
    present(
      viewController,
      animated: true,
      completion: nil
    )
  }
  private func setupConfiguration() -> PHPickerConfiguration {
    var configuration = PHPickerConfiguration()
    configuration.selectionLimit = 0
    return configuration
  }
  
  private func createPHPickerViewController(
    with configuration: PHPickerConfiguration
  ) -> PHPickerViewController {
    videos.removeAll()
    let pickerViewController = PHPickerViewController(
      configuration: configuration
    )
    pickerViewController.delegate = self
    return pickerViewController
  }
}


extension ViewController: PHPickerViewControllerDelegate {
  func picker(
    _ picker: PHPickerViewController,
    didFinishPicking results: [PHPickerResult]) {
      print(results)
      for result in results {
        let itemProvider = result.itemProvider
        guard let typeIdentifier = itemProvider
                .registeredTypeIdentifiers.first,
              let uType = UTType(typeIdentifier) else {
                return
              }
        
        if uType.conforms(to: .movie) {
          itemProvider.loadFileRepresentation(
            forTypeIdentifier: typeIdentifier) { url, error in
              if let error = error {
                print(error.localizedDescription)
              } else {
                guard let videoURL = url else { return }
                
                let documentDirectory = FileManager.default.urls(
                  for: .documentDirectory,
                     in: .userDomainMask
                ).first
                
                guard let targetURL = documentDirectory?.appendingPathComponent(
                  videoURL.lastPathComponent
                ) else {
                  return
                }
                
                do {
                  if FileManager.default.fileExists(atPath: targetURL.path) {
                    try FileManager.default.removeItem(at: targetURL)
                  }
                  try FileManager.default.copyItem(at: videoURL, to: targetURL)
                  DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.videos.append(targetURL)
                  }
                } catch {
                  //Error handling
                }
              }
            }
        }
      }
      isPresented = false
      
      picker.dismiss(
        animated: true,
        completion: nil
      )
    }
  
}
