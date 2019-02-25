//
//  SettingViewController.swift
//  SwiftWunderlist
//
//  Created by Naoki Arakawa on 2019/02/24.
//  Copyright © 2019 Naoki Arakawa. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var backImageView: UIImageView!

    
    @IBOutlet weak var sv: UIScrollView!
    
    //スクロールの設定を行う上で必須
    var vc = UIView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        vc.frame = CGRect(x: 0, y: 0, width: 800, height: 80)
        
        for i in 0 ..< 10 {
            
            let button : UIButton = UIButton()
            button.tag = i
            button.frame = CGRect(x: (i*80), y: 0, width: 80, height: 80)
            
            //このiはint型で、最終的には画像の名前が入る
            //namedで画像ファイルの名前を指定している
            let buttonImage : UIImage = UIImage(named: String(i))!
            
            //このイメージをボタンに貼り付けていく
            button.setImage (buttonImage, for: .normal)
            
            //ボタンを押したときに何をするのかという１行である
            //押して話したときにメソッドが呼ばれる
            button.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
            vc.addSubview(button)
            
          
            
            
        }
        
        //スクロールビューに貼り付ける
        sv.addSubview(vc)
        
        //貼り付けるもののサイズ
        //boundsは全体という意味
        sv.contentSize = vc.bounds.size
        
        
    }
    
    
    //タグがsenderの中に入ってくるイメージ
    @objc func selectImage(sender: UIButton){
        
        //画像をUIImageViewに反映する
        backImageView.image = UIImage(named: String(sender.tag))
        
        //Buttonのタグ情報をアプリ内で保存する
        //先ほどタグをもらった、タグをviewControllerでとる
        UserDefaults.standard.set(String(sender.tag), forKey: "image")
    
        
    }
    
    //元の画面に戻る
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    

   
}
