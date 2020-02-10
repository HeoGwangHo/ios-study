//
//  ViewController.swift
//  3.DatePicker
//
//  Created by macbook on 24/01/2020.
//  Copyright © 2020 Gwang-Ho Heo. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    // 타이머가 구동되면 실행할 함수
    let timeSelector: Selector = #selector(DateViewController.updateTime)
    let interval: Double = 1.0 // 타이머 간격 1초
    
    @IBOutlet var lblCurrentTime: UILabel! // 현재시간 아웃렛 변수
    @IBOutlet var lblPickerTime: UILabel! // 선택시간 아웃렛 변수
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 타이머 설정 순서대로 타이머 간격, 동작될 view, 실행할 함수, 사용자 정보, 반복여부
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter() // DateFormatter 클래스 상수 선언
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE" // 시간을 표시할 속성 설정
        lblPickerTime.text = "선택시간: " + formatter.string(from: datePickerView.date) // 문자열로 변환하여 출력
    }
    
    // 타이머가 구동된 후 실행할 함수
    @objc func updateTime() {
        let date = NSDate() // 현재 시간을 가져옴
        
        let formatter = DateFormatter() // 클래스 상수 선언
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시간: " + formatter.string(from: date as Date)
    }
    
}

