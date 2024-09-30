//
//  ImagePicker.swift
//  MemeEditor
//
//  Created by 장혜령 on 9/25/24.
//

import SwiftUI
import UIKit
import Photos

struct ImagePicker: UIViewControllerRepresentable {
  @Binding var selectedImage: UIImage?
  @Environment(\.presentationMode) var presentationMode
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var parent: ImagePicker
    
    init(parent: ImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let uiImage = info[.originalImage] as? UIImage {
        parent.selectedImage = uiImage
      }
      parent.presentationMode.wrappedValue.dismiss()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      parent.presentationMode.wrappedValue.dismiss()
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    checkPhotoLibraryPermission { granted in
      if !granted {
        print("사진 접근 권한이 허용되어 있지 않음")
        showPermissionDeniedAlert(on: picker)
        context.coordinator.parent.presentationMode.wrappedValue.dismiss()
      }
    }
    
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
  private func checkPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
    let status = PHPhotoLibrary.authorizationStatus()
    switch status {
    case .authorized:
      completion(true)
    case .denied, .restricted:
      completion(false)
    case .notDetermined:
      PHPhotoLibrary.requestAuthorization { status in
        DispatchQueue.main.async {
          completion(status == .authorized)
        }
      }
    default:
      completion(false)
    }
  }
  
  private func showPermissionDeniedAlert(on viewController: UIViewController) {
      let alert = UIAlertController(
          title: "사진 접근 권한 필요",
          message: "사진을 선택하려면 설정에서 접근 권한을 허용해주세요.",
          preferredStyle: .alert
      )
      
      alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
      alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default, handler: { _ in
          if let appSettings = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSettings)
          }
      }))
      
      // UIAlertController를 UIImagePickerController 위에 표시
      DispatchQueue.main.async {
          viewController.present(alert, animated: true, completion: nil)
      }
  }
}
