//
//  GridView.swift
//  Memorize_1
//
//  Created by xcode on 16.01.2021.
//  Copyright © 2021 test. All rights reserved.
//

import SwiftUI

struct GridView<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    init(items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)
        return Group {
            if index != nil {
                viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index!))
            }
        }
    }
    
}