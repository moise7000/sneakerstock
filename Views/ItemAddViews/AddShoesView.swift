//
//  AddShoesView.swift
//  26123
//
//  Created by ewan decima on 26/12/2022.
//

import SwiftUI


struct AddShoesView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: []) var deposits : FetchedResults<Deposit>
    
    var country  = ["EU",
                    "US"]
    var sizesUS = ["3.5", "4", "4.5",
                   "5", "5.5", "6",
                   "6.5", "7", "7.5",
                   "8", "8.5", "9", "9.5",
                   "10", "10.5", "11",
                   "11.5", "12", "12.5",
                   "13", "13.5", "14",
                   "14.5", "15", "15.5",
                   "16", "16.5", "17", "17.5",
                   "18"]
    var sizesEU = ["35", "36", "36.5",
                   "37.5", "38", "38.5",
                   "39", "40", "40.5",
                   "41", "42", "42.5",
                   "43", "44", "44.5",
                   "45", "45.5", "46",
                   "47", "47.5", "48.5",
                   "49.5"]
    var brands = ["Nike",
                   "Air Jordan",
                   "Adidas",
                   "Converse",
                   "New Balance",
                    "Supreme",
                   "Salomon",
                   "Reebok",
                   "Yeezy",
                   "Autre"
    ]
    
    
    @State private var selectedCountry = "EU"
    @State private var selectedSize = "41"
    @State private var selectedBrand = "Nike"
    
    @State private var otherBrand = ""
    
    
    
    //MARK: Essential Input Stuff
    @State private var name = ""
    @State private var size : Double = 8
    @State private var price: Double = 100
    @State private var priceStr : String = ""
    @State private var ressellPrice: String = ""
    @State private var stockxStyle: String = ""
  
    

    //MARK: Alert Stuff
    @State private var showAlert:Bool = false
    @State private var alertMessage: String = "Il en manque ..."
    
    @State private var showPopover: Bool = false
    @State private var showInfo: Bool = false
    
    
    
    

    
    var body: some View {
       
        Form{
            Section{
                VStack{
                    Picker("Marque", selection: $selectedBrand) {
                        ForEach(brands, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                if selectedBrand == "Autre"{
                    TextField("Marque", text: $otherBrand)
                }
                TextField("Nom", text: $name)
               
                
                
                HStack{
                    VStack{
                        Picker("Pays", selection: $selectedCountry) {
                            ForEach(country, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    Spacer()
                    VStack{
                        Picker("Taille", selection: $selectedSize) {
                            ForEach(getSize(), id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                TextField("Prix d'Achat", text : $priceStr)
                    .keyboardType(.numberPad)
            }
            
            //MARK: SKU
            Section{
                HStack{
                    TextField("StockX Style - SKU", text: $stockxStyle)
                    
                    Button {
                        showInfo.toggle()
                    } label :{
                        Label("", systemImage: "questionmark.circle")
                    }
                }
                if showInfo {
                    
                    Text("Code d'identification StockX (SKU).\n Exemple : BV1310-555 ")
                    Link("StockX.com", destination: URL(string: "https://stockx.com/fr-fr")!)
                    
                }
            }
            
            //MARK: Estimed Sell Price
            Section {
                TextField("Prix de Vente Estimé", text: $ressellPrice)
                    .keyboardType(.numberPad)
            }
            

            
            //MARK: deposit
            

            
            //MARK: Save Button
            HStack{
                Spacer()
                Button("OK"){
                    checkInputsValidity()
                    if !showAlert {
                        myCondition()
                        dismiss()
                    }

                    
                }
                
                .alert(isPresented: $showAlert){
                    Alert(title: Text("Oops ?"),
                            message: Text(alertMessage))
                }
                Spacer()
            }
        }
    }
    
    
    //MARK: Private functions
    
    
    
   
    private func getSize() -> Array<String> {
        if selectedCountry == "EU" {
            return sizesEU
        }
        else {
            return sizesUS
        }
    }
    
  

    
   
    
    
    private func myCondition() -> Void {
        let inputs = [name,stockxStyle, ressellPrice, priceStr]
        
        if !multipleInputStringValidity(inputArray: inputs) || (selectedBrand == "Autre" &&  inputStringValidity(input: otherBrand)){
                        showAlert = true
        }
        else {
            var brand = selectedBrand
            if selectedBrand == "Autre"{
                brand = otherBrand
            }
            
            DataController().addShoesRessell2(name: name,
                                              brand: brand,
                                              size:Double(selectedSize)!,
                                              price: price,
                                              priceStr: priceStr,
                                              ressellPrice: ressellPrice,
                                              stockxStyle: stockxStyle,
                                           
                                              context: managedObjContext)
            
            //dismiss()
            
        }
    }
    
  
    
    
    private func checkInputsValidity() -> Void {
        let inputs = [name,stockxStyle, ressellPrice, priceStr]
        if !multipleInputStringValidity(inputArray: inputs) || (selectedBrand == "Autre" &&  inputStringValidity(input: otherBrand)){
            showAlert = true
        }
    }
    
   
    
    

    
    private func showingPopover(){
        showPopover = true
    }
    
}
            
        
    


struct AddShoesView_Previews: PreviewProvider {
    static var previews: some View {
        AddShoesView()
    }
}
