//
//  ViewController.swift
//  PickerView
//
//  Created by macbook on 24/01/2020.
//  Copyright © 2020 Gwang-Ho Heo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let MAX_ARRAY_NUM:Int = 10 // 이미지 파일명을 저장할 배열의 크기
    let PICKER_VIEW_COLUMN:Int = 2 // 피커 뷰 열의 개수
    let PICKER_VIEW_HEIGHT:CGFloat = 80 
    var imageArray = [UIImage?]()
    var imageFileName:[String] = ["1.jpeg", "2.jpeg", "3.jpeg", "4.jpeg", "5.jpeg", "6.jpeg", "7.jpeg", "8.jpeg", "9.jpeg", "10.jpeg"]
    
    @IBOutlet var pickerImage: UIPickerView!
    @IBOutlet var lblImageFileName: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // i값을 0부터 MAX_ARRAY_NUM(10)보다 작을 때까지 반복
        for i in 0 ..< MAX_ARRAY_NUM {
            let image = UIImage(named: imageFileName[i]) // 각 파일명에 해당하는 이미지를 생성
            imageArray.append(image) // 생성된 이미지를 imageArray에 추가
        }
        
        lblImageFileName.text = imageFileName[0] // 뷰가 로드되었을 때 첫 번째 파일명 출력
        imageView.image = imageArray[0] // 뷰가 로드되었을 때 첫 번째 이미지 출력
    }

    // 피커 뷰의 컴포넌트 수 설정
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    // 피커 뷰의 높이 설정
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    // 피커 뷰의 개수 설정
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    
    // 피커 뷰의 각 Row의 view설정
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image:imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150) // 이미지 뷰의 프레임 크기 설정
        
        return imageView
    }
    
    // 피커 뷰가 선택되었을 때 실행
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 0번 째 컴포넌트가 선택됬을 때
        if (component == 0){
            lblImageFileName.text = imageFileName[row] // 파일명 출력
        } else if (component == 1) { // 1번 째 컴포넌트가 선택됬을 때
            imageView.image = imageArray[row] // 이미지 변경
        }
    }

}
