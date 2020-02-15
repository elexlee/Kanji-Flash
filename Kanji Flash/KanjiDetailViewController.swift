//
//  KanjiDetailViewController.swift
//  Kanji Flash
//
//  Created by Elex Lee on 11/20/19.
//  Copyright © 2019 Elex Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class KanjiDetailViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var kanjiLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    private var dataSource = KanjiDetailDataSource()
    lazy var disposeBag = { return DisposeBag() }()
    
    private var counter = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.bindStyle()
        self.bind(self.dataSource)
    }
    
    static func configureWith() -> KanjiDetailViewController {
        let vc = UIStoryboard.main.instantiate(from: KanjiDetailViewController.self)
        return vc
    }
    
    fileprivate func setupTableView() {
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource
        self.tableView.isHidden = true
        self.tableView.separatorStyle = .none
    }
    
    fileprivate func bindStyle() {
        self.counterLabel.text = String(self.counter)
        self.englishLabel.isHidden = true
        self.showButton.layer.borderWidth = 1.0
        self.showButton.layer.cornerRadius = 7.0
        self.nextButton.layer.borderWidth = 1.0
        self.nextButton.layer.cornerRadius = 7.0
    }
    
    fileprivate func bind(_ dataSource: KanjiDetailDataSource) {
        self.showButton.rx.tap
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { () in
                self.tableView.isHidden = false
                self.englishLabel.isHidden = false
            }).disposed(by: self.disposeBag)
        
        self.nextButton.rx.tap.asObservable()
            .bind(to: self.dataSource.input.randomize)
            .disposed(by: self.disposeBag)
        
        self.nextButton.rx.tap
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { () in
                self.tableView.isHidden = true
                self.englishLabel.isHidden = true
            }).disposed(by: self.disposeBag)
        
        dataSource.output.reloadRows
            .drive(onNext: { () in
                self.tableView.reloadData()
            }).disposed(by: self.disposeBag)
        
        dataSource.output.incrementCounter
            .drive(onNext: { [weak self] () in
                guard let strongSelf = self else { return }
                strongSelf.counter += 1
                strongSelf.counterLabel.text = String(strongSelf.counter)
            }).disposed(by: self.disposeBag)
        
        dataSource.output.character
            .drive(onNext: { character in
                self.kanjiLabel.text = character
            }).disposed(by: self.disposeBag)
        
        dataSource.output.english
            .drive(onNext: { english in
                self.englishLabel.text = english
            }).disposed(by: self.disposeBag)
        
        dataSource.output.finishedAllKanji
            .drive(onNext: { () in
                self.nextButton.setTitle("All Finished", for: .normal)
            }).disposed(by: self.disposeBag)
    }
    
}
