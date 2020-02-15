//
//  KanjiHomeViewController.swift
//  Kanji Flash
//
//  Created by Elex Lee on 2/14/20.
//  Copyright © 2020 Elex Lee. All rights reserved.
//

import UIKit

class KanjiHomeViewController: UIViewController {
    
    @IBOutlet weak var kanjiListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func configureWith() -> KanjiHomeViewController {
        let vc = UIStoryboard.main.instantiate(from: KanjiHomeViewController.self)
        return vc
    }
    
    @IBAction func kanjiListButtonTapped(_ sender: UIButton) {
        let vc = KanjiListViewController.configureWith()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func kanjiTestButtonTapped(_ sender: UIButton) {
        let vc = KanjiDetailViewController.configureWith()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
