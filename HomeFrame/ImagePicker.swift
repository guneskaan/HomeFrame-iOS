//
//  ImagePicker.swift
//  HomeFrame
//
//  Created by Gunesh Pinar on 2020-11-11.
//

import Foundation
import SwiftUI

struct imagePicker: UIViewControllerRepresentable{
    @Binding var image: UIImage?
    @Binding var showImagePicker: Bool
    
    typealias UIViewControllerType = UIImagePickerController
    // Allow communication between imagePickerCoordinator and imagePicker.
    typealias Coordinator = imagePickerCoordinator
    
    // Set default value for sourceType. This is later set to what source param is passed from the view.
    var sourceType:UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<imagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> imagePicker.Coordinator {
        return imagePickerCoordinator(image: $image, showImagePicker: $showImagePicker)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<imagePicker>) {}
}

class imagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @Binding var image: UIImage?
    @Binding var showImagePicker: Bool
    
    init(image: Binding<UIImage?>, showImagePicker: Binding<Bool>) {
        _image = image
        _showImagePicker = showImagePicker
    }
    
    // Gets triggered when an image is selected by the user.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // If we can unwrap the selected image, assign it to the binding variable.
        if let uiimage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            image = uiimage
            showImagePicker = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        showImagePicker = false
    }
}
