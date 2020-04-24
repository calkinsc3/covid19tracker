//
//  BarView.swift
//  covid19tracker
//
//  Created by William Calkins on 4/21/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI



struct BarGraphView: View {
    
    @Binding var bindedBarValues : [[CGFloat]]
    @Binding var bindedBarAverageValues : [CGFloat]
    
    @State var pickerSelection = 0
    @State var barValues: [[CGFloat]] = [
        [5,150,50,100,200,110,30,170,50],
        [200,110,30,170,50, 100,100,100,200],
        [10,20,50,100,120,90,180,200,40]
    ]
    
    var body: some View {
        ZStack {
            Color("PrimaryBackground").edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Daily Increases")
                    .font(.title)
                Picker(selection: $pickerSelection, label: Text("Stats")) {
                    Text("Positive").tag(0)
                    Text("Hospitalized").tag(1)
                    Text("Death").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 10)
                
                HStack(alignment: .center, spacing: 10) {
                    ForEach(self.barValues[self.pickerSelection], id:\.self) { data in
                        BarView(value: data, cornerRadius: CGFloat(integerLiteral: (10 * self.pickerSelection)), barHeight: 200)
                    }
                }
                .padding(.top, 24)
                .animation(.default)
            }
        }
    }
}

struct BarView: View {
    
    var value: CGFloat
    var cornerRadius: CGFloat
    var barHeight: CGFloat
    
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 30, height: 200)
                    .foregroundColor(Color("BarBackground"))
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 30, height: value)
                    .foregroundColor(Color("BarForeground"))
                
            }
            .padding(.bottom, 8)
        }
    }
}

//struct BarView_Previews: PreviewProvider {
//
//    let barData : [[CGFloat]] = [[5.0,150.0,50.0,100.0,200.0,110.0,30.0,170.0,50.0],
//    [200.0,110.0,30.0,170.0,50.0, 100.0,100.0,100.0,200.0],
//    [10.0,20.0,50.0,100.0,120.0,90.0,180.0,200.0,40.0]]
//
//    static var previews: some View {
//        Group {
//
//            BarGraphView(bindedBarValues: barData)
//
//                BarView(value: 45, cornerRadius: 4, barHeight: 200)
//        }
//
//    }
//}
