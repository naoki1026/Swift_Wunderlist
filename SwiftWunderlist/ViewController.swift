//
//  ViewController.swift
//  SwiftWunderlist
//
//  Created by Naoki Arakawa on 2019/02/24.
//  Copyright © 2019 Naoki Arakawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    //ToDoのタイトルが入る配列を作る
    var titleArray = [String]()
    
    //ラベルを宣言する
    var label : UILabel = UILabel()
    
    //選択されたセルの番号を入れる変数を作る
    //選択された番号を次の番号に渡す
    var count : Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        //これはTableViewに関するデリゲートメソッドを使用する上で必要
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        
        //多分テキストを角丸にする
        backView.layer.cornerRadius = 2.0
        
        //テーブルビューは分けないということを定義
        tableView.separatorStyle = .none
        
        
        
    }
    
    //アプリ内に保存されているデータを取ってくる
    override func viewWillAppear(_ animated: Bool) {
        
        //タイトルを取り出す
        if UserDefaults.standard.object(forKey: "array") != nil {
            
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
            
            
        }
        
        //画像を取り出す
        if UserDefaults.standard.object(forKey: "image") != nil {
            
            //ここに画像の名前が入っている
            let numberString = UserDefaults.standard.string(forKey: "image")
            
            //画像のファイル名がここで出される
            backImageView.image = UIImage(named: numberString! + ".jpeg")
        
        }
        
        //ここでテーブルを読み込んでいる
        tableView.reloadData()
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //配列の中に文字を入れる
        titleArray.append(textField.text!)
        
        //配列をアプリ内に保存する
        UserDefaults.standard.set(titleArray, forKey: "array")
        
        //アプリ内に保存されている現状の配列が空ではない場合は、titleArrayの中に値を入れてくださいということを行なっている
        if UserDefaults.standard.object(forKey: "array") != nil {
            
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
            
            //テキストフィールドを空にする
            textField.text = ""
            
            //テーブルビューをリロードする
            tableView.reloadData()
        }
        
        //キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
        
    }
    
    //セルの高さを定義する
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 91
    }
    
    //セクションの数を定義する
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    
    }
    
    //storyboardのセルをタップすると、Identifierと表示されるので、そこにCellと入力する
    //書き方はこれしかないため、こういうものだと理解する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //セルの角を丸くする
        cell.layer.cornerRadius = 10.0
        
        //つないでいく
        label = cell.contentView.viewWithTag(1) as! UILabel
        label.text = titleArray[indexPath.row]
        
        return cell
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count
        
    }
    
    //セルがタップされたときに発動するメソッド
    //初めから用意されているデリゲートメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //値を渡しながら、タップされたときの番号がこの中に入る
        //Int型にキャストしている
        count = Int(indexPath.row)
        
        //画面遷移を行う
     performSegue(withIdentifier: "next", sender: nil)
        
        
    }
    
    //prepareと入力したら検索結果の候補として表示される
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //もしセグエのIdentifierがnextであれば、nextViewControllerを変数に置き換える
        //書き方としてこういう書き方である
        if segue.identifier == "next" {
            let nextVc : NextViewController = segue.destination as! NextViewController
            
            //nextVcのselectedNumberの中にcountを入れる
            nextVc.selectedNumber = count
        }
        
        
    }
    

    //セルの編集について、消去された場合の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //tableViewの編集の際の書き方になる
        if editingStyle == .delete{
            
            //titleArrayの選択された際の番号の配列に入っている文字を消去する
            titleArray.remove(at: indexPath.row)
            
            //このままではバックグランドに戻ったときにデータが更新されずに消えてしまう
            //配列をアプリ内に保存する
            UserDefaults.standard.set(titleArray, forKey: "array")
            tableView.reloadData()
            
            //追加だった場合は何もしない
        } else if editingStyle == .insert {
            
            
        }
        
    }
    

}
