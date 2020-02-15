//
//  KanjiDetailDataSource.swift
//  Kanji Flash
//
//  Created by Elex Lee on 11/20/19.
//  Copyright © 2019 Elex Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct KanjiDetailModel {

    var data: [String] = []
    
    init(_ kanji: Kanji) {
        data.append(kanji.on)
        data.append(kanji.kun)
        for example in kanji.example {
            data.append(example.0 + " : " + example.1)
        }
    }
}

class KanjiDetailDataSource: NSObject {
    
    let input: Input
    let output: Output
    
    struct Input {
        let randomize: AnyObserver<Void>
    }
    
    struct Output {
        let reloadRows: Driver<Void>
        let incrementCounter: Driver<Void>
        let character: Driver<String>
        let english: Driver<String>
        let finishedAllKanji: Driver<Void>
    }
    
    var disposeBag: DisposeBag?
    let showSubject = PublishSubject<Void>()
    let randomizeSubject = PublishSubject<Void>()
    let reloadRowsSubject = PublishSubject<Void>()
    let incrementCounterSubject = PublishSubject<Void>()
    let characterSubject = BehaviorSubject<String>(value: "")
    let englishSubject = BehaviorSubject<String>(value: "")
    let finishedAllKanjiSubject = PublishSubject<Void>()
    
    var kanjiData = KanjiDetailModel(Kanji(character: "", english: "", on: "", kun: "", example: []))
    var previousKanji = [Kanji]()
    
    override init() {
        let bag = DisposeBag()
        
        let reloadRowsDriver = reloadRowsSubject
            .withLatestFrom(reloadRowsSubject)
            .asDriver(onErrorJustReturn: ())
        
        let incrementCounterDriver = incrementCounterSubject
            .withLatestFrom(incrementCounterSubject)
            .asDriver(onErrorJustReturn: ())
        
        let characterDriver = characterSubject
            .withLatestFrom(characterSubject)
            .asDriver(onErrorJustReturn: "")
        
        let englishDriver = englishSubject
            .withLatestFrom(englishSubject)
            .asDriver(onErrorJustReturn: "")
        
        let finishedAllKanjiDriver = finishedAllKanjiSubject
            .withLatestFrom(finishedAllKanjiSubject)
            .asDriver(onErrorJustReturn: ())
        
        self.input = Input(randomize: randomizeSubject.asObserver())
        self.output = Output(reloadRows: reloadRowsDriver,
                             incrementCounter: incrementCounterDriver,
                             character: characterDriver,
                             english: englishDriver,
                             finishedAllKanji: finishedAllKanjiDriver)
        
        super.init()
        
        self.randomizeSubject
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] () in
                self?.newKanji()
            }).disposed(by: bag)
        
        self.newKanji()
        
        self.disposeBag = bag
    }
    
    private func newKanji() {
        if previousKanji.count == KanjiManager.shared.kanjiDictionaryCount() { return }
        
        let randomKanji = KanjiManager.shared.randomKanji()
        
        if previousKanji.contains(where: { $0.character == randomKanji.character }) {
            self.newKanji()
        } else {
            self.kanjiData = KanjiDetailModel(randomKanji)
            self.previousKanji.append(randomKanji)
            self.incrementCounterSubject.onNext(())
            self.characterSubject.onNext(randomKanji.character)
            self.englishSubject.onNext(randomKanji.english)
            self.reloadRowsSubject.onNext(())
            if previousKanji.count == KanjiManager.shared.kanjiDictionaryCount() {
                self.finishedAllKanjiSubject.onNext(())
            }
        }
    }
}

extension KanjiDetailDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.kanjiData.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "KanjiDetailCell") as? KanjiDetailCell {
            cell.descriptionLabel.text = self.kanjiData.data[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

extension KanjiDetailDataSource: UITableViewDelegate {
    
}


