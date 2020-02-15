//
//  KanjiManager.swift
//  Kanji Flash
//
//  Created by Elex Lee on 11/21/19.
//  Copyright © 2019 Elex Lee. All rights reserved.
//

import Foundation

class KanjiManager {
    
    static let shared = KanjiManager()
    
    private var kanjiDictionary = [String:Kanji]()
    
    private var jlpt1List = [
        // MARK: 10
        "一", "二", "三", "四", "五", "六", "七", "八", "九", "十",
        // MARK: 20
        "安", "飲", "右", "雨", "駅", "円", "火", "花", "下", "何",
        // MARK: 30
        "会", "外", "学", "間", "気", "休", "魚", "金", "空", "月",
        // MARK: 40
        "見", "言", "古", "後", "午", "語", "校", "口", "行", "高",
        // MARK: 50
        "国", "今", "左", "山", "子", "耳", "時", "車", "社", "手",
        // MARK: 60
        "週", "出", "書", "女", "小", "少", "上", "食", "新", "人",
        // MARK: 70
        "水", "生", "西", "川", "千", "先", "前", "足", "多", "大",
        // MARK: 80
        "男", "中", "長", "天", "店", "電", "土", "東", "道", "読",
        // MARK: 90
        "南", "日", "入", "年", "買", "白", "半", "百", "父", "分",
        // MARK: 100
        "聞", "母", "北", "木", "本", "毎", "万", "名", "目", "友",
        // MARK: 103
        "来", "立", "話"
    ]
    
    init() {
        
    }
    
    func grabKanji(completion: @escaping () -> Void) {
        APIManager.shared.getKanji(kanji: jlpt1List, onSuccess: { json in
            let kanjiData = json["data"]
            for data in kanjiData {
                
                let slug = data.1["data"]["slug"].description
                
                let meanings = data.1["data"]["meanings"].array
                var description = ""
                for (i, m) in meanings!.enumerated() {
                    description += m["meaning"].description
                    if i != meanings!.count - 1 {
                        description += ", "
                    }
                }
                
                let readings = data.1["data"]["readings"].array
                var onyomi = ""
                var kunyomi = ""
                for (_, r) in readings!.enumerated() {
                    if r["type"].description == "onyomi" {
                        onyomi += r["reading"].description + ", "
                    }
                    
                    if r["type"].description == "kunyomi" {
                        kunyomi += r["reading"].description + ", "
                    }
                }

                self.kanjiDictionary[slug] = Kanji(character: slug,
                                                   english: description,
                                                   on: String(onyomi.dropLast(2)),
                                                   kun: String(kunyomi.dropLast(2)),
                                                   example: [("", "")])
            }
            completion()
        }) { e in
            print(e)
        }
    }
    
    func containsKanji(kanji: String) -> Bool {
        return kanjiDictionary[kanji] != nil
    }
    
    func randomKanji() -> Kanji {
        return kanjiDictionary.randomElement()!.value
    }
    
    func kanjiDictionaryCount() -> Int {
        return kanjiDictionary.count
    }
    
    func dictionary() -> [String:Kanji] {
        return kanjiDictionary
    }
    
    func dictKeyArray() -> [String] {
        return Array(kanjiDictionary.keys)
    }
    
    func dictValueArray() -> [Kanji] {
        return Array(kanjiDictionary.values)
    }
 }
