//
//  HomePageView.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/4/23.
//


import SwiftUI

@MainActor
struct HomePageView: View {
    @State private var offset: CGFloat = 200.0
    @State private var isSideBarOpened = false
    @State private var toPartyDetail = false
    @State private var toProfile = false //to profile
    @State var showMenu = false
    @State var search = ""
    @Namespace private var animation
   //Detail view Properties
    @State private var showDetailView: Bool = false
    @State private var SelectedParty: Party?
    @State private var items: [Party] = []
    //@State private var itemId: [String] = []
    @EnvironmentObject private var viewModel : AuthViewModel
    
    var body: some View {
        ZStack{
            lGradient()
            VStack(spacing: 15){
                HStack(spacing: 15){
                    
                    Button(action: {
                        withAnimation(.easeIn){showMenu.toggle()}
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .frame(width: 20, height: 15)
                    })
                    Spacer()
                    Button(action: {withAnimation(.easeIn){toProfile.toggle()}}, label: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width:25, height: 25)
                            .padding(.trailing, 5)
                    })
                }
                .padding([.horizontal,.top])
                
                Divider()
                HStack(spacing: 15){
                    TextField("Search", text: $search)
                        .foregroundColor(.black)
                    if search != ""{
                        Button(action: {
                            
                        }, label: {
                            Image(systemName:"magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.black)
                        })
                        .animation(Animation.easeInOut(duration: 1.0), value: offset)
                    }
                } // search
                .padding(.horizontal)
                //.padding(.top,0)
                Divider()
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 35){
                        ForEach(sampleParty){ party in //sampleParty
                            PartyCardView(party)
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                                        SelectedParty = party
                                        showDetailView = true
                                    }
                                }
                        }
                        /*ForEach(items) { item in //party from db
                            PartyCardView(item)
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                                        SelectedParty = item
                                        showDetailView = true
                                    }
                                }
                            }
                        }
                        .onAppear {
                            viewModel.fetchItems()
                        }*/
                    }.padding(.horizontal, 15)
                    .padding(.vertical, 20)
                }
                .coordinateSpace(name: "SCROLLVIEW")
                Spacer()
            } // Top_bar
            .overlay{
                if let SelectedParty, showDetailView {
                    DetailView(show: $showDetailView,animation: animation, party: SelectedParty)
                }
            }
            //Menu
            HStack{
                menuView()
                    .offset(x: showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                Spacer(minLength: 0)
            } // Slide menu left
            .background(Color.black.opacity(showMenu ? 0.5: 0)).ignoresSafeArea()
            .onTapGesture(perform: {withAnimation(.easeIn){showMenu.toggle()}})
            
            //Profile
            HStack{
                ProfileView()
                    .offset(x: toProfile ? 175 : -UIScreen.main.bounds.width / -1)
                Spacer(minLength: 0)
            } // Slide menu right
            .background(Color.black.opacity(toProfile ? 0.5: 0)).ignoresSafeArea()
            .onTapGesture(perform: {withAnimation(.easeIn){toProfile.toggle()}})
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .accentColor(.black)
    }
    
    @ViewBuilder
    func PartyCardView(_ party: Party) -> some View {
        GeometryReader{
            let size = $0.size
            let rect = $0.frame(in: .named("SCROLLVIEW"))
        
            HStack(spacing: -25){ // party detain card
                VStack(alignment: .leading, spacing: 6){ //party image
                    Text(party.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("Hosted by \(party.host)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    RatingView(rating: party.rating)
                        .padding(.top, 10)
                        Spacer(minLength: 10)
                    HStack(spacing: 4){
                        Text("\(party.attendees)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                        Text("Attendees")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer(minLength: 0)
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(20)
                .frame(width: size.width / 2, height: size.height * 0.8)
                .background{RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.8), radius: 8, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.8), radius: 8, x: -5, y: -5)
                }
                .zIndex(1)
                
                ZStack{
                        Image(party.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width / 2, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        
                            //.matchedGeometryEffect(id: party.id, in: animation)
                        
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                   // }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: size.width)
            .rotation3DEffect(.init(degrees: convertOffsetToRotation(rect)), axis: (x: 1, y: 0, z:0), anchor: .bottom, anchorZ: 1, perspective: 0.8)
        }.frame(height: 220)
    }
    func convertOffsetToRotation(_ rect: CGRect) -> CGFloat{
        let cardHeight = rect.height + 20
        let minY = rect.minY - 20
        let progress = minY < 0 ? (minY / cardHeight) : 0
        let constrainedProgress = min(-progress, 1.0)
        return constrainedProgress * 90
    }
    func calculateWidth() ->CGFloat{
        let screen = UIScreen.main.bounds.width - 30
        
        let width = screen - (2 * 30)
        return width
    }
}

struct lGradient: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.gray, .purple]),
                       startPoint:.top,
                       endPoint:.bottom)
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

