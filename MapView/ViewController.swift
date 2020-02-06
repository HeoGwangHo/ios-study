//
//  ViewController.swift
//  7.Map
//
//  Created by macbook on 28/01/2020.
//  Copyright © 2020 Gwang-Ho Heo. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도를 최고로 설정
        locationManager.requestWhenInUseAuthorization() // 위치 데이터를 추적하기 위해 사용자에게 승인을 요구
        locationManager.startUpdatingLocation() // 위치 업데이트를 시작
        myMap.showsUserLocation = true // 위치 보기 값
    }

    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue) // 위도 값과 경도 값을 매개변수로 하여 CLLocationCoordnate2DMake함수를 호출하고, 리턴 값을 pLocation으로 받습니다.
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span) // 범위 값을 매개변수로 하여 MKCoordinateSpanMake함수를 호출하고, 리턴 값을 spanValue로 받습니다.
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue) // pLocation과 spanValue값을 매개변수로 하여 MKCoordinateRegionMake함수를 호출하고, 리턴 값을 pRegion으로 받습니다.
        myMap.setRegion(pRegion, animated: true) // pRegion값을 매개변수로 하여 myMap.setRegion함수를 호출합니다.
        return pLocation
    }
    
    // 특정 위도와 경도에 핀 설치하고 핀에 타이틀과 서브 타이틀의 문자열 표시
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    // 위치 정보에서 국가, 지역, 도로를 추출하여 레이블에 표시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last // 위치가 없데이트 되면 먼저 마지막 위치 값을 찾아냅니다.
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) // 마지막 위치의 위도와 경도 값을 가지고 앞에서 만든 goLocation 함수를 호출합니다. 이때 delta값은 지도의 크기를 정하는데, 값이 작을수록 확대되는 효과가 있습니다. delta를 0.01로 하였으니 1의 값보다 지도를 100배로 확대해서 보여줄 것입니다.
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address:String = country!
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재 위치"
            self.lblLocationInfo2.text = address
        })
        
        locationManager.stopUpdatingLocation()
    }
    
    // 세그먼트 컨트롤을 선택하였을 때 호출
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // 현재 위치
            self.lblLocationInfo1.text = ""
            self.lblLocationInfo2.text = ""
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 {
            // 폴리텍 대학
            setAnnotation(latitudeValue: 37.751853, longitudeValue: 128.8765740000004, delta: 1, title: "한국폴리텍대학 강릉캠퍼스", subtitle: "강원도 강릉시 남산초교길 121")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "한국폴리텍대학 강릉캠퍼스"
        } else if sender.selectedSegmentIndex == 2 {
            // 이지스퍼블리싱
            setAnnotation(latitudeValue: 37.556876, longitudeValue: 126.914066, delta: 0.1, title: "이지스퍼블리싱", subtitle: "서울시 마포구 잔다리로 109 이지스 빌딩")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "이지스퍼블리싱 출판사"
        }
    }
    
}

