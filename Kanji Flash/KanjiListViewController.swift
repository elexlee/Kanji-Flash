//
//  KanjiListViewController.swift
//  Kanji Flash
//
//  Created by Elex Lee on 2/13/20.
//  Copyright © 2020 Elex Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class KanjiListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource = KanjiListDataSource()
    lazy var disposeBag = { return DisposeBag() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.bind(self.dataSource)
    }
    
    static func configureWith() -> KanjiListViewController {
        let vc = UIStoryboard.kanjiList.instantiate(from: KanjiListViewController.self)
        vc.title = "\(KanjiManager.shared.kanjiDictionaryCount()) Kanji"
        return vc
    }
    
    fileprivate func setupTableView() {
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource
    }
    
    fileprivate func bind(_ dataSource: KanjiListDataSource) {
//        dataSource.output.reloadRows
//            .drive(onNext: { () in
//                self.tableView.reloadData()
//            }).disposed(by: self.disposeBag)
//
//        dataSource.output.incrementCounter
//            .drive(onNext: { [weak self] () in
//                guard let strongSelf = self else { return }
//                strongSelf.counter += 1
//                strongSelf.counterLabel.text = String(strongSelf.counter)
//            }).disposed(by: self.disposeBag)
//
//        dataSource.output.character
//            .drive(onNext: { character in
//                self.kanjiLabel.text = character
//            }).disposed(by: self.disposeBag)
//
//        dataSource.output.english
//            .drive(onNext: { english in
//                self.englishLabel.text = english
//            }).disposed(by: self.disposeBag)
//
//        dataSource.output.finishedAllKanji
//            .drive(onNext: { () in
//                self.randomizeButton.setTitle("All Finished", for: .normal)
//            }).disposed(by: self.disposeBag)
    }
}
