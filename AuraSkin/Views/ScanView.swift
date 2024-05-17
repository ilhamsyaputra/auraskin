//
//  ScanView.swift
//  AuraSkin
//
//  Created by Ayatullah Ma'arif on 06/05/24.
//

import SwiftUI
import PhotosUI

struct ScanView: View {
    
    var captureFunction : () -> Void
    var navManualInputFunction : () -> Void?
    var flashFunction: () -> Void?

    @State var photosPickerItem: PhotosPickerItem?
    @Binding var selectedImage: UIImage?
    
    @Binding var isSelected: Bool
//    @State var isClickCapture: Bool = false
    @Binding var isFlash: Bool

    
    
    var body: some View {
        
        VStack{
            
            HStack(){
                Spacer()
                Button(action: {
                    flashFunction()
                    isFlash.toggle()

                }, label: {
                    Image(systemName: isFlash ? "bolt.fill" : "bolt.slash.fill")
                        .font(.system(size: 26))
                    
                })
                Spacer()
                    .frame(width: 35)
            }
            
            Spacer()
            
            HStack(){
                Spacer()
                PhotosPicker(selection: $photosPickerItem, matching: .images)
                {
                    Image(systemName: "photo.stack")
                        .font(.system(size: 33))
                    
                }.onChange(of: photosPickerItem) { _, _ in
                    Task{
                        if let photosPickerItem,
                           let data = try? await photosPickerItem.loadTransferable(type: Data.self)
                        {
                            if let image = UIImage(data: data){
                                selectedImage = image
                                isSelected = true                              
                            }
                        }
                    }
                }
                
                
                Spacer()
                Button(action: {
                    captureFunction()
                    if(isFlash){
                        flashFunction()
                        isFlash.toggle()
                    }
                    
                }, label: {
                    Image(systemName: "circle")
                        .font(.system(size: 75))
                })
                
                Spacer()
                Button(action: {
                    navManualInputFunction()
                }, label: {
                    Image(systemName: "keyboard")
                        .font(.system(size: 33))
                })
                Spacer()
                
                
            }
            
            Spacer()
                .frame(height: 30)
            
        }
        .foregroundStyle(.white)
        
        
    }
    
}

//#Preview {
//    ScanView(captureFunction: testButton, navGalleryFunction: testButton, navManualInputFunction: testButton)
//}
