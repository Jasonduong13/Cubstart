//
//  ContentView.swift
//  newsfeedSkeleton
//
//  Created by Jordan Yee on 3/28/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @Environment(\.openURL) var openURL
    @StateObject var viewModel: ArticleViewModelImpl = ArticleViewModelImpl(service: ArticleServiceImpl())
    
    
    var body: some View {
        Group {
            
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error){
                    self.viewModel.getArticles()
                }
            case .success(let content):
                NavigationView {
                    List(content) { article in
                        ArticleView(article : article)
                            .onTapGesture {
                                load(url: article.url)
                            }
                    }
                    .navigationBarTitle("News")
                }
            }
        }
        .onAppear{
            self.viewModel.getArticles()
        }
    }
    func load(url: String?) {
        guard let url = url,
              let linkUrl = URL(string: url) else{
                  return
              }
        openURL(linkUrl)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
