//
//  KanjiListCell.swift
//  Kanji Flash
//
//  Created by Elex Lee on 2/13/20.
//  Copyright © 2020 Elex Lee. All rights reserved.
//

import UIKit

class KanjiListCell: UITableViewCell {
    
    @IBOutlet private weak var numberKanjiLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var onyomiLabel: UILabel!
    @IBOutlet private weak var kunyomiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureWith(kanji: Kanji) {
        numberKanjiLabel.text = kanji.character
        descriptionLabel.text = kanji.english
        onyomiLabel.text = "Onyomi  -  \(kanji.on)"
        kunyomiLabel.text = "Kunyomi  -  \(kanji.kun)"
    }
}
