//
//  RickAndMortyVC.swift
//  RickAndMorty
//
//  Created by Fatih Emre Sarman on 29.02.2024.
//

import UIKit
import SnapKit

protocol RickAndMortyOutput{
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Result])
}


final class RickAndMortyVC: UIViewController {
    
    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private lazy var results: [Result] = []
    
    lazy var viewModel: IRickAndMortyVM = RickAndMortyVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
    
    private func configure(){
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        
        drawDesign()
        makeLabel()
        makeIndicator()
        makeTableView()
    }
    
    private func drawDesign(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickAndMortyTVC.self, forCellReuseIdentifier: RickAndMortyTVC.Identifier.custom.rawValue)
        tableView.rowHeight = 150
        
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.labelTitle.font = .boldSystemFont(ofSize: 25)
            self.labelTitle.text = "Rick and Morty"
            self.indicator.color = .brown
        }
        indicator.startAnimating()
    }
}

extension RickAndMortyVC: RickAndMortyOutput {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(values: [Result]) {
        results = values
        tableView.reloadData()
    }
    
    
}

extension RickAndMortyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RickAndMortyTVC.Identifier.custom.rawValue, for: indexPath) as! RickAndMortyTVC
        
        cell.saveModel(model: results[indexPath.row])
        
        return cell
    }
    
    
}

extension RickAndMortyVC {
    private func makeTableView(){
        tableView.snp.makeConstraints {(make) in
            make.top.equalTo(labelTitle.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.right.equalTo(labelTitle)
            
        }
    }
    private func makeLabel(){
        labelTitle.snp.makeConstraints { (make) in
            
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    private func makeIndicator(){
        indicator.snp.makeConstraints { (make) in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
    }
}
