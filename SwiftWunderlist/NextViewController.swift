//
//  NextViewController.swift
//  SwiftWunderlist
//
//  Created by Naoki Arakawa on 2019/02/24.
//  Copyright © 2019 Naoki Arakawa. All rights reserved.
//

import UIKit

class NextViewController: UIViewController, UITextViewDelegate, UIDocumentInteractionControllerDelegate {
    
    lazy private var  documentInterattionController = UIDocumentInteractionController()
    
    var selectedNumber = 0
    
    
    @IBOutlet weak var textView: UITextView!
    
    //スクリーンショットを入れるためのUIImage型の変数が必要である
    var screenShotImage : UIImage = UIImage()
    
    //取り出す用の配列
    var titleArray : Array = [String]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
    }
    
    //ここは決まりごと
    //ライフサイクルとグーグルで検索すると詳細を確認できる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //titleArrayをアプリ内から取り出す
        if UserDefaults.standard.object(forKey: "array") != nil {
            
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
            
             //textViewにselectedNumber分の番号を渡す
            textView.text = titleArray[selectedNumber]
        }
        
        
    }
    
    //タッチしてキーボードを閉じる
    //UIKitの中に入っているメソッドであるためすぐに記述することができる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textView.isFirstResponder {
            
            textView.resignFirstResponder()
        }
    }
    
    //スクリーンショット
    func takeScreenShot(){
        
        // キャプチャしたい枠を決める
        let rect = CGRect(x: textView.frame.origin.x, y: textView.frame.origin.y, width: textView.frame.width, height: textView.frame.height)
        
        
        //描画している
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        textView.drawHierarchy(in: rect, afterScreenUpdates: true)
        
        //変数の中に画像を入れている
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
    }
    
    
    
    @IBAction func shareLine(_ sender: Any) {
    
   //スクリーンショットを撮るというメソッドを発動
   takeScreenShot()
        
    //これによりラインに投稿するという処理を遅らせている
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            
            
            let pastBoard: UIPasteboard = UIPasteboard.general
            pastBoard.setData(self.screenShotImage.jpegData(compressionQuality: 0.75)!, forPasteboardType: "public.png")
            
            
            
            let lineUrlString: String = String(format: "line://msg/image/%@", pastBoard.name as CVarArg)
            
            
            
            UIApplication.shared.open(NSURL(string: lineUrlString)! as URL)
            
            
            
        }
        
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
