//
//  RickAndMortyTVC.swift
//  RickAndMorty
//
//  Created by Fatih Emre Sarman on 1.03.2024.
//

import UIKit
import AlamofireImage
import SwiftUI

class RickAndMortyTVC: UITableViewCell {
    
    private let customImg: UIImageView = UIImageView()
    private let title: UILabel = UILabel()
    private let customDescription: UILabel = UILabel()
    
    private let randomImg: String = "https://picsum.photos/200/300"
    
    enum Identifier: String {
        case custom = "BlaineConnor"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(customImg)
        addSubview(title)
        addSubview(customDescription)
        title.font = .boldSystemFont(ofSize: 18)
        self.backgroundColor = .clear
        
        customDescription.font = .italicSystemFont(ofSize: 14)
        
        customImg.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(-240)
            make.trailing.equalToSuperview()
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(customImg.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().offset(16)
        }
        
        customDescription.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(16)
            make.trailing.leading.equalTo(title)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        customImg.contentMode = .scaleAspectFit
    }
    
    
    func saveModel(model: Result) {
        title.text = model.name
        customDescription.text = model.status
        customImg.af.setImage(withURL: URL(string: model.image ?? randomImg) ?? URL(string: randomImg)!)
    }
    
}



struct MortyViewController_Previews: PreviewProvider {
    static var previews: some View {
        RickViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}
