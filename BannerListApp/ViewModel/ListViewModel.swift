//
//  ListViewModel.swift
//  BannerListApp
//
//  Created by apple on 24/11/21.
//

import Foundation
import UIKit
class ListViewModel: ObservableObject {
    
    @Published var bannerItemList = Array<BannerItemModel>()
    @Published var itemList = Array<ListItemModel>()

    init() {
        bannerItemList = getBannerData()
        itemList = getItemData()
    }
    
    func getBannerData() -> [BannerItemModel] {
        return [
            BannerItemModel(imageName: "1", title: ""),
            BannerItemModel(imageName: "2", title: ""),
            BannerItemModel(imageName: "3", title: ""),
            BannerItemModel(imageName: "4", title: ""),
            BannerItemModel(imageName: "5", title: "")
        ]
    }
    
    func getItemData() -> [ListItemModel] {
        return [
            ListItemModel(imageName: "5", title: "Trevon Silva"),
            ListItemModel(imageName: "4", title: "Reynaldo Hebert"),
            ListItemModel(imageName: "2", title: "Gerald York"),
            ListItemModel(imageName: "4", title: "Marlon Orozco"),
            ListItemModel(imageName: "5", title: "Cristal Walker"),
            ListItemModel(imageName: "2", title: "Konnor Orr"),
            ListItemModel(imageName: "1", title: "Sam Harrell"),
            ListItemModel(imageName: "2", title: "Sincere Bean"),
            ListItemModel(imageName: "5", title: "Sloane Kelley"),
            ListItemModel(imageName: "2", title: "Desmond Owens"),
            ListItemModel(imageName: "3", title: "Prince Keith"),
            ListItemModel(imageName: "1", title: "Emma Cobb")
        ]
    }
}
