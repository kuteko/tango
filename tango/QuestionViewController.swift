//
//  QuestionViewController.swift
//  tango
//
//  Created by 内山香 on 2016/06/08.
//  Copyright © 2016年 内山香. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel:UILabel!
    
    var isAnswered: Bool = false //回答したか・次の問題に行くか判定
    var wordArray:[AnyObject] = [] //ユーザーデフォルトからとる配列
    var shuffledWordArray:[AnyObject] = [] //シャッフルされた配列
    var nowNumber: Int = 0 //現在の回答数
    
    let savaData = NSUserDefaults.standardUserDefaults()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = ""
        // Do any additional setup after loading the view.
    }

    
    //viewが現れた時に呼ばれる
    override func viewWillAppear(animated: Bool) {
        wordArray = savaData.arrayForKey("WORD")!
        
        //問題をシャッフル
        shuffle()
        questionLabel.text = shuffledWordArray[nowNumber]["english"] as? String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //配列をランダムにシャッフル
    func shuffle(){
        while wordArray.count > 0 {
            let index = Int(rand()) % wordArray.count
            shuffledWordArray.append(wordArray[index])
            wordArray.removeAtIndex(index)
        }
    }
    
    
    @IBAction func nextButtonPushed () {
        
        //回答したか
        if isAnswered{
            //次の問題へ
            nowNumber += 1
            answerLabel.text=""
            
            //次の問題を表示するか
            if nowNumber < shuffledWordArray.count{
                //次の問題を表示
                questionLabel.text=shuffledWordArray[nowNumber]["english"] as? String
                //isAnsweredをfalseにする
                isAnswered = false
                //ボタンのタイトルを変更する
                nextButton.setTitle("答えを表示", forState: UIControlState.Normal)
            }
            else{
                //問題がなくなったのでFinishViewに画面遷移
                self.performSegueWithIdentifier("toFinishView", sender: nil)
            }
        }
        else{
            //答えを表示
            answerLabel.text=shuffledWordArray[nowNumber]["japanese"] as? String
            //isAnsweredをtrueにする
            isAnswered = true
            //ボタンのタイトルを変更する
            nextButton.setTitle("次へ", forState: UIControlState.Normal)
        }
    }

}








