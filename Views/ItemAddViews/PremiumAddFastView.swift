//
//  PremiumAddFastView.swift
//  26123
//
//  Created by ewan decima on 19/11/2023.
//

import SwiftUI

struct PremiumAddFastView: View {
    
    var shoes: Shoes
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: []) var deposits : FetchedResults<Deposit>
    
    
    @State private var selectedSize: String = ""
    @State private var selectedCountry: String = ""
    @State private var privatePriceStr: String = ""
    @State private var priceStr: String?
    @State private var privateRessellPrice: String = ""
    @State private var ressellPrice: String?
    
    
    @State private var pickerDepositName: String = ""
    @State private var newInputDepositName: String = ""
    @State private var newDepositName: String?
    
    @State private var showingAlert: Bool = false
    
    var country  = ["Pays", "EU", "US"]
    var sizesUS = ["Taille","3.5", "4", "4.5",
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
    
    @State private var showExplanation:Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                GetShoesImage(shoes:shoes, radius : 200)
                HStack{
                    Text(shoes.brand!).bold()
                    Text(shoes.name!)
                }
                
                
                VStack{
                    HStack{
                        VStack{
                            Picker("Pays", selection: $selectedCountry) {
                                ForEach(country, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        VStack{
                            Picker("Taille", selection: $selectedSize) {
                                ForEach(getSize(), id: \.self) {
                                    Text($0)
                                }
                            }.pickerStyle(.wheel)
                        }
                    }
                    
                    TextField("Prix d'achat (optionnel)", text: $privatePriceStr)
                        .keyboardType(.numberPad)
                        .padding()
                    
                    TextField("Prix de Vende Estimé (optionnel)", text: $privateRessellPrice)
                        .keyboardType(.numberPad)
                        .padding()
                    
                    

                    
                    
                        
                        .padding()
                    


                    
                    
                    Button("Ajouter"){
                        if notRaiseAlert(){
                            addToBase2()
                           
                            dismiss()
                            
                            
                        } else {
                            showingAlert.toggle()
                        }
                        
                    }
                    .padding()
                    .alert(isPresented: $showingAlert){
                        Alert(title: Text("Oops ?"),
                                message: Text("Il en manque"))
                    }

                    
                    
                }
                .navigationTitle("Ajout Rapide")
                
            }
            .alert(isPresented: $showExplanation){
                Alert(title: Text("Explication"),
                        message: Text("Si les champs marqués (optionnel) sont laissés vides alors la nouvelles sneakers se verra affecter les mêmes valeurs que la sneakers initiale."))
            }
            .toolbar{
                //MARK: show what optional mean
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        showExplanation.toggle()
                    } label: {
                        Label("", systemImage: "questionmark.circle")
                    }
                }
                
            }
            
           
            
            
            
        }
    }
    
    
    private func getSize() -> Array<String>{
        if selectedCountry == "EU"{
            return sizesEU
        }
        else{
            return sizesUS
        }
    }
    
    private func notRaiseAlert() -> Bool{
       
        if Double(selectedSize) == nil {
            return false
        }
        let inputs = [selectedSize, selectedCountry]
        return multipleInputStringValidity(inputArray: inputs)
    }
    
   
    
    
    private func addToBase(){
        let size = Double(selectedSize)!
        
        if inputStringValidity(input: privatePriceStr){
            priceStr = privatePriceStr
        }
        
        if inputStringValidity(input: privateRessellPrice){
            ressellPrice = privateRessellPrice
        }
        
        DataController().addFastShoes(shoes: shoes,
                                      size: size,
                                      priceStr: priceStr,
                                      ressellPrice: ressellPrice,
                                      context: managedObjContext)
    }
    
    
    
    private func addToBase2(){
        let size = Double(selectedSize)!
        
        if inputStringValidity(input: privatePriceStr){
            priceStr = privatePriceStr
        }
        
        if inputStringValidity(input: privateRessellPrice){
            ressellPrice = privateRessellPrice
        }
        
        if newInputDepositName == "Nouveau Dépot-Vente (optionnel)" || !inputStringValidity(input: newInputDepositName){
            newDepositName = nil
        } else {
            newDepositName = newInputDepositName
        }
        
        
        
        if newDepositName != nil{
            print("new deposit not nil")
            //MARK: Enter a new Deposit in database
            if !depositAlreadyExist(newDepositName!, deposits: deposits){
                let newDeposit = DataController().createAndSaveDeposit(name: newDepositName!,
                                                                       context: managedObjContext)
                DataController().addFastShoes2(shoes: shoes,
                                               size: size,
                                               priceStr: priceStr,
                                               ressellPrice: ressellPrice,
                                               deposit: newDeposit,
                                               context: managedObjContext)
                print("new deposit created")
            } else {
                
                //MARK: the deposit already exist
                let fastDeposit = getDepositByName(newDepositName!, deposits: deposits)
                
                DataController().addFastShoes2(shoes: shoes,
                                               size: size,
                                               priceStr: priceStr,
                                               ressellPrice: ressellPrice,
                                               deposit: fastDeposit,
                                               context: managedObjContext)
                
            }
            
            
            
            
            
            
            
        } else {
            //MARK: new Shoes without deposit
            DataController().addFastShoes2(shoes: shoes,
                                           size: size,
                                           priceStr: priceStr,
                                           ressellPrice: ressellPrice,
                                           deposit: nil,
                                           context: managedObjContext)
        }
        
        
        
        
    }
    
}

