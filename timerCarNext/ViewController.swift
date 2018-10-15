//
//  ViewController.swift
//  timerCarNext
//
//  Created by user on 2018/10/15.
//  Copyright © 2018年 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 空のImageViewの配列を用意
    var carImageViewArray:[UIImageView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // アニメーションタイマー開始
        Timer.scheduledTimer(timeInterval: 1/60.0, target: self, selector: #selector(step), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 定期処理
    @objc func step() {
        
        for carImageView in carImageViewArray {
            // xを10右に進める
            carImageView.center.x += 5
            // 車のimageViewの幅
            let carWidth = carImageView.bounds.width
            
            // 車の中心位置が画面幅＋車の幅分移動すると画面から隠れる
            if carImageView.center.x > view.bounds.width + carWidth/2 {
                // 隠れたら不要なので削除
                carImageViewArray.remove(at: carImageViewArray.index(of: carImageView)!)
                carImageView.removeFromSuperview()
            }
        }
        
        // 画面に乗ってるViewの数を表示
//        print(self.view.subviews.count)
    }
    
    // どこでもいいからタッチイベント
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /* 新しい車を作る */

        // 画像の読みこみ
        var image = UIImage(named: "greenCar")!

        // 0-9のランダムな数を作って
        let random = Int(arc4random_uniform(10))
        
        let carImageView:UIImageView
        
        if random == 5 {
            // 5だったときだけ黒い車に変更
            image = image.withRenderingMode(.alwaysTemplate)
            carImageView = UIImageView(image: image)
            carImageView.tintColor = UIColor.black
        } else {
            // 5以外はそのままつかう
            carImageView  = UIImageView(image: image)
        }

        // 画面高さ内で適当なY座標を作る
        let yAxis = arc4random_uniform( UInt32(self.view.bounds.height) )
        
        // 初期位置に指定
        carImageView.frame.origin = CGPoint(x: Int(-carImageView.frame.width), y:Int(yAxis) )
        
        // 車リストに追加
        carImageViewArray.append(carImageView)
        
        // 最後に追加した要素を画面にも登場させる
        self.view.addSubview(carImageView)
    }
}

