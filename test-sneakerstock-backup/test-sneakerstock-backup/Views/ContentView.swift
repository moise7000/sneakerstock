 //
//  ContentView.swift
//  26123
//
//  Created by ewan decima on 26/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.jour, order: .reverse)]) var shoes : FetchedResults<Shoes>
    @State private var showingAddView = false
    @State private var query = ""
    @State private var image: UIImage?
    
    
    var body: some View {
        Section{
            NavigationStack{
                VStack(alignment: .leading){
                    Text("\(Int(totalPrice())) €")
                        .foregroundColor(.red)
                        .padding(.horizontal)
                    List {
                        ForEach(shoes) {shoes in
                             NavigationLink(destination:  InfoShoesView(shoes:shoes)) {
                                HStack{
                                    VStack(alignment: .leading,spacing: 6) {
                                        Text(shoes.brand!)
                                            .bold()
                                        
                                        Text(shoes.name! + " " + String(shoes.size) + " us").foregroundColor(.gray)
                                        
                                    }
                                    //Spacer()
                                    
                                    Spacer()
                                    Text(shoes.priceStr! + " €" ).foregroundColor(.black)
                                    
                                }
                            }
                        }
                        .onDelete(perform: deleteShoes)
                    }
                    .listStyle(.plain)
                    
                }
                .searchable(text: $query,  placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Shoes Name")
                .onChange(of:  query){ newValue in shoes.nsPredicate = searchPredicate(query: newValue)}
                .navigationTitle("myStock")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddView.toggle()
                        } label :{
                            Label("Add", systemImage: "plus.circle")
                        }
                    }
                    //ToolbarItem(placement: .navigationBarLeading){
                    //   EditButton()
                    //}
                }
                .sheet(isPresented: $showingAddView) {
                    AddShoesView()
                }
                
            }
            .navigationViewStyle(.stack)
        }
        
    }
    
    
  

    
    
    private func searchPredicate(query: String) -> NSPredicate? {
      if query == "" { return nil }
        return NSPredicate(format: "%K BEGINSWITH[cd] %@",
        #keyPath(Shoes.name), query)
      }
    
    
    
    
    
    private func deleteShoes(offsets: IndexSet) {
        withAnimation {
            offsets.map { shoes[$0] }
                .forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
        
    }
    
    
    private func totalPrice() -> Double {
            var prices: Double = 0
            for item in shoes{
                prices += Double(item.priceStr!)!
            }
            
            return prices
        }
        
        
    }


    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

