//
//  ViewController.swift
//  fruit
//
//  Created by k on 헤이세이 30. 10. 24..
//  Copyright © 헤이세이 30년 ksh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var myTable: UITableView!
    
    // 데이터 클래스 객체 배열
    var myFruitData = [FruitData]()
    var dName = ""
    var dColor = ""
    var dCost = ""
    
    
    // 현재의 tag를 저장
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.delegate = self
        myTable.dataSource = self
        
        if let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml"){
            // 파싱 시작
            if let myParser = XMLParser(contentsOf: path){
                // delegate를 ViewController와 연결
                myParser.delegate = self
                
                if myParser.parse() {
                    print("파서 성공")
                    for i in 0 ..< myFruitData.count {
                        print(myFruitData[i].name)
                    }
                    // for data in myFruitData{
                    // }
                    //                    print(myFruitData[0].name)
                    //                    print(myFruitData[0].color)
                    //                    print(myFruitData[0].cost)
                } else {
                    print("파서 실패")
                }
            } else {
                print("파싱 오류 발생")
            }
            
        } else {
            print("xml file not found")
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
    }
    // 2. tag 다음에 문자열을 만나면 실행
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //공백제거
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        //공백체크후 데이터 뽑기
        if !data.isEmpty {
            switch currentElement {
            case "name" : dName = data
            case "color" : dColor = data
            case "cost" : dCost = data
            default : break
            }
        }
    }
    
    // 3. tag가 끝날때 실행(/tag)
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let myItem = FruitData()
            myItem.name = dName
            myItem.color = dColor
            myItem.cost = dCost
            myFruitData.append(myItem)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFruitData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        cell.textLabel?.text = myFruitData[indexPath.row].name
        cell.detailTextLabel?.text = myFruitData[indexPath.row].color
        
        
        
        //let lName = cell.viewWithTag(1) as! UILabel
        //let lColor = cell.viewWithTag(2) as! UILabel
        //let lCost = cell.viewWithTag(3) as! UILabel
        
        //lName.text = myFruitData[indexPath.row].name
        //lColor.text = myFruitData[indexPath.row].color
        //lCost.text = myFruitData[indexPath.row].cost
        
        return cell
    }
    
    
    

}

