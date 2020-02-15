//
//  KanjiListDataSource.swift
//  Kanji Flash
//
//  Created by Elex Lee on 2/13/20.
//  Copyright © 2020 Elex Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class KanjiListDataSource: NSObject {
    
    let input: Input
    let output: Output
    
    struct Input {
    }
    
    struct Output {
    }
    
    var disposeBag: DisposeBag?
    
    override init() {
        let bag = DisposeBag()
        
        self.input = Input()
        self.output = Output()
        
        super.init()
                
        self.disposeBag = bag
    }
}

extension KanjiListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.kanjiData.data.count
        return KanjiManager.shared.kanjiDictionaryCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "KanjiListCell") as? KanjiListCell {
            let kanji = KanjiManager.shared.dictValueArray()[indexPath.row]
            cell.configureWith(kanji: kanji)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165.0
    }
}

extension KanjiListDataSource: UITableViewDelegate {
    
}

