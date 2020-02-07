//
//  ViewController.swift
//  8.PageControl
//
//  Created by macbook on 29/01/2020.
//  Copyright © 2020 Gwang-Ho Heo. All rights reserved.
//

import UIKit

var images = ["01.png", "02.png", "03.png", "04.png", "05.png", "06.png"]

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pageControl.numberOfPages = images.count // numberOfPages: 페이지 컨트롤의 전체 페이지 수
        pageControl.currentPage = 0 // currenPage: 현재 페이지
        pageControl.pageIndicatorTintColor = UIColor.green // pageIndicatorTintColor: 페이지 컨트롤의 페이지 표시하는 부분의 색상
        pageControl.currentPageIndicatorTintColor = UIColor.red // currentPageIndicatorTintColor: 페이지 컨트롤의 현재 페이지를 표시하는 색상
        imgView.image = UIImage(named: images[0])
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
    
}

