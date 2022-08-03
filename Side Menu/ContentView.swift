//
//  ContentView.swift
//  Side Menu
//
//  Created by Tanvir Rahman on 31.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State var showMenu = false

    var body: some View {
        let drag = DragGesture()
                    .onEnded {
                        if $0.translation.width < -100 {
                            withAnimation {
                                self.showMenu = false
                            }
                        }
                    }
        VStack{
            HStack{
                Spacer()
            Button{
                withAnimation{
                    self.showMenu.toggle()
                }
            }label: {
                Image(systemName: "sidebar.right")
            }

            }.padding(.horizontal)
        
            GeometryReader { geometry in

            ZStack(alignment: .leading) {
                            mainView(showMenu: self.$showMenu)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                                  .disabled(self.showMenu ? true : false)

                            if self.showMenu {
                             
                                menuView(showMenu: $showMenu)
                                    .frame(width: geometry.size.width/2, height: geometry.size.height)
                                    .transition(.move(edge: .leading))
                            }
            }.gesture(drag)
        }

        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct mainView: View {
    @Binding var showMenu: Bool

    var body: some View {
        ZStack{
            Color.gray.opacity(0.3)
            Button(action: {
            print("Open the side menu")
            withAnimation {
                self.showMenu.toggle()
            }

        }) {
            if !showMenu {
                withAnimation(.easeIn){
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 200, alignment: .center)
                .rotation3DEffect(.degrees(150.0), axis: (x: 0, y: 50, 0))
                }
            }else {
                withAnimation(.easeInOut){
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 200, height: 200, alignment: .center)
                }
            }
        }
        }.ignoresSafeArea()
        
    }
}


struct menuView: View {
    @Binding var showMenu: Bool
    var body: some View {
        VStack(alignment: .center) {
          
            HStack{
                Spacer()
                Button{
                    withAnimation{
                        showMenu = false
                        
                    }
                }label:{
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.secondary)
                    
                }
            }
            Spacer()
            VStack{
                
                HStack {
                    Button{
                        
                    }label: {
                        
                        menuViewButtonsDesign(buttonName: "Ratings", imageSystemName: "star.leadinghalf.filled")
                        
                    }
                    Spacer()
                   }
                   .padding(.top, 30)
                
                
                   HStack {
                        Button{
                            
                        }label: {
                            menuViewButtonsDesign(buttonName: "Activity Log", imageSystemName: "doc.text.magnifyingglass")
                        }
                        
                        Spacer()
                    }
                     .padding(.top, 10)
                   HStack {
                        Button{
                            
                        }label: {
                            menuViewButtonsDesign(buttonName: "FAQ", imageSystemName: "person.crop.circle.badge.questionmark")
                        }
                        
                        Spacer()
                    }
                     .padding(.top, 10)
                    HStack {
                        Button{
                            
                        }label: {
                            
                            menuViewButtonsDesign(buttonName: "Support", imageSystemName: "rectangle.3.group.bubble.left")
                            
                        }
                        Spacer()
                    }
                        .padding(.top, 10)
                
            }
            Spacer()
            HStack{
                Button{
                    
                }label: {
                    RoundedRectangle(cornerRadius: 5)
                        .shadow(color: .black.opacity(0.4), radius: 3)
                        .foregroundColor(Color(red: 1.089, green: 0.045, blue: 0.112))
                        .frame( height: 50, alignment: .center)
                        .overlay(
                            HStack{
                                Text("LogOut")
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName:  "power.circle")
                                    .foregroundColor(.white)
                            }.padding(.horizontal)
                        )
                }
            }.padding(.bottom, 30)
      }.padding()
        .frame(maxWidth: .infinity, alignment: .trailing)
        .background(.white)
       .edgesIgnoringSafeArea(.all)
    }
}



struct menuViewButtonsDesign: View {
    var buttonName: String
    var imageSystemName: String
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .shadow(color: .black.opacity(0.4), radius: 3)
            .foregroundColor(Color(red: -0.349, green: 0.751, blue: 0.601))
            .frame( height: 50, alignment: .center)
            .overlay(
                HStack{
                    Image(systemName: imageSystemName)
                        .foregroundColor(.white)
                        .imageScale(.large)
                   
                    Text(buttonName)
                        .foregroundColor(.white)
                        .font(.headline)
                }
            )
    }
}
