//
//  ContentView.swift
//  HomeFrame
//
//  Created by Gunesh Pinar on 2020-11-07.
//

import SwiftUI

struct ContentView: View {
    @State var showActionSheet = false
    @State var showImagePicker = false
    
    @State var sourceType:UIImagePickerController.SourceType = .camera
    
    @State var image:UIImage?
    
    func getDisplayImage(selectedImage:UIImage?) -> Image{
        let image: Image = selectedImage != nil ? Image(uiImage: selectedImage!) : Image(systemName: "timelapse")

        return image.resizable()
    }
    
    var body: some View {
        VStack{
            getDisplayImage(selectedImage: self.image).scaledToFit().frame(width:300, height: 300)
            Button(action: {
                self.showActionSheet = true
            }){
                Text("Show Image Picker")
            }.actionSheet(isPresented: $showActionSheet){
                ActionSheet(title: Text("Add a picture"), message: nil, buttons: [
                                //Buttons
                                .default(Text("Camera"), action: {
                                    self.showImagePicker = true
                                    self.sourceType = .camera
                                }),
                                .default(Text("Photo Library"), action: {
                                    self.showImagePicker = true
                                    self.sourceType = .photoLibrary
                                }),
                                .cancel()
                ])
            }.sheet(isPresented: $showImagePicker){
                imagePicker(image: self.$image, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
