//
//  ViewController.swift
//  Calculator
//
//  Created by 鈴木賢也 on 2015/05/03.
//  Copyright (c) 2015年 鈴木賢也. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myLabel: UILabel = UILabel(frame: CGRectMake(CGFloat(Constants().valLabelPosition.x),CGFloat(Constants().valLabelPosition.y),CGFloat(Constants().horizontalLength-10),CGFloat(Constants().verticalButtonlength)))
    
    var targetVal = 0
    //var calcVal = 0
    
    //ほんとはこいつenum的なものに持つべきてかグローバル変数とか基本持ちたくない
    var previousOperand = ""
    
    var previousTapIsOperand = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.blackColor()
        
        myLabel.textAlignment = NSTextAlignment.Right
        myLabel.text = "0"
        myLabel.textColor = UIColor.whiteColor()
        myLabel.font = UIFont.systemFontOfSize(CGFloat(Constants().labelFontSize))
        
        self.view.addSubview(myLabel)
        
        //ボタン1行目
        let buttenC = makebutton("C", x: CGFloat(Constants().startPosition.x), y: CGFloat(Constants().startPosition.y))
        let buttenReverse = makebutton("+/-", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength), y: CGFloat(Constants().startPosition.y))
        let buttenPercent = makebutton("%", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength*2), y: CGFloat(Constants().startPosition.y))
        let buttenDevide = makebutton("÷", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength*3), y: CGFloat(Constants().startPosition.y))
        
        self.view.addSubview(buttenC)
        self.view.addSubview(buttenReverse)
        self.view.addSubview(buttenPercent)
        self.view.addSubview(buttenDevide)
        
        
        //ボタン2行目
        let butten7 = makebutton("7", x: CGFloat(Constants().startPosition.x), y: CGFloat(Constants().startPosition.y+Constants().horizontalButtonlength+Constants().buttonBorderWidth))
        let butten8 = makebutton("8", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength),
                                      y: CGFloat(Constants().startPosition.y+Constants().horizontalButtonlength+Constants().buttonBorderWidth))
        let butten9 = makebutton("9", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength*2),
                                      y: CGFloat(Constants().startPosition.y+Constants().horizontalButtonlength+Constants().buttonBorderWidth))
        let buttenmuliply = makebutton("×", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength*3),
                                            y: CGFloat(Constants().startPosition.y+Constants().horizontalButtonlength+Constants().buttonBorderWidth))
        
        self.view.addSubview(butten7)
        self.view.addSubview(butten8)
        self.view.addSubview(butten9)
        self.view.addSubview(buttenmuliply)
        
        
        //ボタン3行目
        let butten4 = makebutton("4", x: CGFloat(Constants().startPosition.x), y: CGFloat(Constants().startPosition.y+(Constants().horizontalButtonlength+Constants().buttonBorderWidth)*2))
        let butten5 = makebutton("5", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength),
                                      y: CGFloat(Constants().startPosition.y+(Constants().horizontalButtonlength+Constants().buttonBorderWidth)*2))
        let butten6 = makebutton("6", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength*2),
                                      y: CGFloat(Constants().startPosition.y+(Constants().horizontalButtonlength+Constants().buttonBorderWidth)*2))
        let buttenminus = makebutton("-", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength*3),
                                          y: CGFloat(Constants().startPosition.y+(Constants().horizontalButtonlength+Constants().buttonBorderWidth)*2))
        
        self.view.addSubview(butten4)
        self.view.addSubview(butten5)
        self.view.addSubview(butten6)
        self.view.addSubview(buttenminus)
        
        
        //ボタン4行目
        let butten1 = makebutton("1", x: CGFloat(Constants().startPosition.x), y: CGFloat(Constants().startPosition.y+(Constants().horizontalButtonlength+Constants().buttonBorderWidth)*3))
        let butten2 = makebutton("2", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength),
                                      y: CGFloat(Constants().startPosition.y+(Constants().horizontalButtonlength+Constants().buttonBorderWidth)*3))
        let butten3 = makebutton("3", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength*2),
                                      y: CGFloat(Constants().startPosition.y+(Constants().horizontalButtonlength+Constants().buttonBorderWidth)*3))
        let buttenPlus = makebutton("+", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength*3),
                                      y: CGFloat(Constants().startPosition.y+(Constants().horizontalButtonlength+Constants().buttonBorderWidth)*3))
        
        self.view.addSubview(butten1)
        self.view.addSubview(butten2)
        self.view.addSubview(butten3)
        self.view.addSubview(buttenPlus)
        
        
        //ボタン5行目
        let butten0 = makebutton("0", x: CGFloat(Constants().startPosition.x), y: CGFloat(Constants().startPosition.y+(Constants().horizontalButtonlength+Constants().buttonBorderWidth)*4))
        let buttenDot = makebutton(".", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength*2),
                                        y: CGFloat(Constants().startPosition.y+(Constants().horizontalButtonlength+Constants().buttonBorderWidth)*4))
        let buttenEqual = makebutton("=", x: CGFloat(Constants().startPosition.x+Constants().horizontalButtonlength*3),
                                          y: CGFloat(Constants().startPosition.y+(Constants().horizontalButtonlength+Constants().buttonBorderWidth)*4))
        
        self.view.addSubview(butten0)
        self.view.addSubview(buttenDot)
        self.view.addSubview(buttenEqual)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //ToDo
    //直前オペランドの内容を持つ、計算対象数値をグローバルに持つ、直前の入力が数値/オペランドのbool
    //オペランド→オペランドのケースって変換でいいよね
    func tapped(button :UIButton){
        var text = button.titleLabel?.text
        //var num = text?.toInt()
        var calcVal = myLabel.text?.toInt()
        
        if(text == "C"){
            myLabel.text = "0"
            previousTapIsOperand = true
            previousOperand = ""
            targetVal = 0
        }else if(text == "+/-"){
            calcVal = calcVal! * -1
            myLabel.text = calcVal?.description
            previousTapIsOperand = true
        }else if(text == "%"){
            //余りの処理
            previousOperand = text!
            previousTapIsOperand = true
        }else if(text == "÷" || text == "×" || text == "-" || text == "+" || text == "="){
            //オペランド入力時の処理、計算対象数値をグローバル変数に格納
            previousTapIsOperand = true
            
           switch previousOperand{
           case "÷": targetVal = targetVal / calcVal!
           case "×": targetVal = targetVal * calcVal!
           case "-": targetVal = targetVal - calcVal!
           case "+": targetVal = targetVal + calcVal!
           case "" : targetVal = calcVal!
           default: break
           }
            previousOperand = text!
            myLabel.text? =  targetVal.description
        }else{
            //IF文で直前の入力が数値かどうかのboolで数値じゃなければ全クリア
            if(previousTapIsOperand){
                myLabel.text? =  text!
            }else{
                myLabel.text? +=  text!
            }
            previousTapIsOperand = false
        }
    }
    
    func makebutton(text:String,x:CGFloat,y:CGFloat) ->UIButton{
        let button = UIButton()
        
        //表示されるテキスト
        button.setTitle(text, forState: .Normal)
        
        //サイズ
        if(text == "0"){
            button.frame = CGRectMake(x, y, CGFloat(Constants().horizontalButtonlength*2),
                CGFloat(Constants().verticalButtonlength))
        }else{
            button.frame = CGRectMake(x, y, CGFloat(Constants().horizontalButtonlength),
                CGFloat(Constants().verticalButtonlength))
        }
        
        //背景色,文字色
        if(text == "C" || text == "+/-" || text == "%"){
            button.backgroundColor = UIColor.grayColor()
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }else if(text == "÷" || text == "×" || text == "-" || text == "+" || text == "="){
            button.backgroundColor = UIColor.orangeColor()
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        }else if(text == "." || text == "0" || text == "1" || text == "2" || text == "3" || text == "4" || text == "5" || text == "6" || text == "7" || text == "8" || text == "9"){
            button.backgroundColor = UIColor.whiteColor()
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        
        
        //ボーダー幅
        button.layer.borderWidth = CGFloat(Constants().buttonBorderWidth)
        
        
        //ボタンをタップした時に実行するメソッドを指定
        button.addTarget(self, action: "tapped:", forControlEvents:.TouchUpInside)
        
        return button;
    }

}

