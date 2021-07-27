//
//  MainTabView.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 25/07/21.
//

import SwiftUI

struct MainTabView: View {
    
    @State var tabSelection: TabScreen = .home
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection){
                
                /*let usecase = Injection.init().provideGenre()
                let discoverUsecase = DiscoverInjection.init().provideDiscover()
                let presenter = GenrePresenter(usecase: usecase, discoverUsecase: discoverUsecase)
                
                MainView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Home")
                    }
                    .tag(TabScreen.home)
                    .environmentObject(presenter)
                
                let favoriteUsecase =  FavoriteInjection.init().provideFavorite()
                FavoriteView(presenter: FavoritePresenter(usecase: favoriteUsecase)).tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }.tag(TabScreen.fav)*/
                
                Color.pink.tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("About")
                }.tag(TabScreen.about)
            }
            .navigationBarTitle(tabSelection.title)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

enum TabScreen {
    case home
    case fav
    case about
    
    var title: String {
        switch self {
        case .home:
        return "Movies"
        case .fav:
            return "Favorites"
        case .about:
            return "About"
        }
    }
}
