//
//  ContentView.swift
//  TinderLIkeSwipingCardsInSwiftUI
//
//  Created by ramil on 30.07.2020.
//

import SwiftUI
import CardStack

struct Cat: Identifiable {
    let id = UUID()
    let name: String
    let image: UIImage
    let distance: Int = { .random(in: 1..<20)}()
    
    static let mock: [Cat] = [
        Cat(name: "Kelvin", image: UIImage(named: "1")!),
        Cat(name: "Elvin", image: UIImage(named: "2")!),
        Cat(name: "Saimon", image: UIImage(named: "3")!),
        Cat(name: "Gennie", image: UIImage(named: "4")!)
    ]
}

struct CardView: View {
    let cat: Cat
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(uiImage: self.cat.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: geo.size.width)
                    .clipped()
                
                HStack {
                    Text(self.cat.name)
                    Spacer()
                    Text("\(self.cat.distance) m/km away")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }.padding()
            }.background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 4)
        }
    }
}

struct SwipingView: View {
    @State private var data: [Cat] = Cat.mock
    
    var body: some View {
        CardStack(direction: LeftRight.direction, data: data) { card, direction in
            print("You have swiped \(card.name) to \(direction)")
        } content: { cat, _, _ in
            CardView(cat: cat)
        }
        .padding()
        .scaledToFit()
        .frame(alignment: .center)
        .navigationBarTitle("CaTender", displayMode: .inline)
    }
}

struct ContentView: View {
    var body: some View {
        SwipingView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
