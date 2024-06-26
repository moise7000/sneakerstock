//
//  AddApparelView.swift
//  26123
//
//  Created by ewan decima on 25/02/2023.
//

import SwiftUI
import PhotosUI

struct AddApparelView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    
    @State private var sizes = ["XS", "S", "M", "L","XL", "+XL"]
    
    
    
    @State private var name = ""
    @State private var brand = ""
    @State private var selectedSize = "M"
    @State private var buyvalueString :  String = ""
    @State private var sellestimatedvalueSring: String = ""
    
    @State private var buyvalue : Double  = 0
    @State private var sellestimatedvalue : Double = 0
    
    @State private var imageApparelSelected: PhotosPickerItem?
    @State private var imageApparelSelectedData: Data?
    
    
    var body: some View {
        //Circle()
          //  .frame(width: 150, height: 150)
            //.padding()
        Spacer()
        
        if let imageApparelSelectedData,
           let uiImage = UIImage(data: imageApparelSelectedData){
            
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                
                .clipShape(Circle())
                .frame(width: 120, height: 120)
        }
        else{
           Circle()
                .frame(width: 120, height: 120)
                .foregroundColor(.gray).opacity(0.2)
        }
        
        VStack{
            PhotosPicker(selection: $imageApparelSelected, matching: .images){
                Image(systemName: "photo")
                    .imageScale(.large)
            }
                .foregroundColor(.blue)
            
           
        }
        .padding()
        .onChange(of: imageApparelSelected){ newItem in
            Task{
                if let data = try? await newItem?.loadTransferable(type: Data.self){
                    imageApparelSelectedData = data
                    
                    
                }
            }
        }
        
        
        
        
        Form{
            Section{
                TextField("Marque", text: $brand)
                TextField("Nom", text: $name)
                
                Picker("Taille", selection: $selectedSize) {
                    ForEach(sizes, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Prix d'Achat", text: $buyvalueString)
                    .keyboardType(.numberPad)

                
            }
            
            Section{
                TextField("Prix de Vente Estimé", text: $sellestimatedvalueSring)
                    .keyboardType(.numberPad)
            }
            
            HStack{
                Spacer()
                Button("OK"){
                    myCondition()
                }.alert(isPresented: $showAlert){
                    Alert(title: Text("Oops ?"),
                          message: Text("Il en manque"))
                }
                Spacer()
            }
            
        }
        
        
        
        
        
        
        
        
        
        
    }
    
    private func myCondition(){
        if name == ""  || brand == "" || buyvalueString=="" || sellestimatedvalueSring == "" || imageApparelSelected == nil{
            showAlert = true
        }
        else {
            buyvalue = Double(buyvalueString)!
            sellestimatedvalue = Double(sellestimatedvalueSring)!
            DataController().addApparel(name: name,
                                        brand: brand,
                                        size: selectedSize,
                                        buyvalue: buyvalue,
                                        imageData: imageApparelSelectedData!,
                                        sellestimatedvalue: sellestimatedvalue,
                                        context: managedObjContext)
            dismiss()
            
        }
    }

    
}



struct AddApparelView_Previews: PreviewProvider {
    static var previews: some View {
        AddApparelView()
    }
}
