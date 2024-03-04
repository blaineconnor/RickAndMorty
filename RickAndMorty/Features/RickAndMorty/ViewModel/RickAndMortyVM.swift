//
//  RickAndMortyVM.swift
//  RickAndMorty
//
//  Created by Fatih Emre Sarman on 1.03.2024.
//

import Foundation

protocol IRickAndMortyVM {
    func fetchItems()
    func changeLoading()
    
    var rickAndMortyChars: [Result] {get set}
    var rickAndMortyService: IRickAndMortyService {get}
    var rickAndMortyOutput: RickAndMortyOutput? {get}
    
    func setDelegate(output: RickAndMortyOutput)
}


final class RickAndMortyVM: IRickAndMortyVM {
    var rickAndMortyOutput: RickAndMortyOutput?
    
    func setDelegate(output: RickAndMortyOutput) {
        rickAndMortyOutput = output
    }
    
   
    var rickAndMortyChars: [Result] = []
    
    
    private var isLoading = false;
    
    let rickAndMortyService: IRickAndMortyService
    
    init() {
        rickAndMortyService = RickAndMortyService()
    }
    
    func fetchItems() {
        changeLoading()
        rickAndMortyService.fetchAllDatas{ [weak self] (response) in
            self?.changeLoading()
            self?.rickAndMortyChars = response ?? []
            self?.rickAndMortyOutput?.saveDatas(values: self?.rickAndMortyChars ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickAndMortyOutput?.changeLoading(isLoad: isLoading)
    }
      
}
