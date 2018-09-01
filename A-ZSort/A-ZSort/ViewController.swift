//
//  ViewController.swift
//  A-ZSort
//
//  Created by 朴子hp on 2018/9/1.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

import UIKit

let kScreenW  = UIScreen.main.bounds.width
let kScreenH  = UIScreen.main.bounds.height

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    // 排序后分组数据
    private var objectsArray : [[SortObjectModel]]?
    // 头部标题keys
    private var keysArray:[String]?
    
    var tabView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabView()
    }
    
    //MARK: 建立主要视图
    func setUpTabView() -> Void {
        tabView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH), style: .plain)
        tabView?.tableFooterView = UIView.init()
        tabView?.dataSource = self
        tabView?.delegate = self
        self.view.addSubview(tabView!)
        
        //测试数据
        let testArray = ["赵无极","钱","孙","李","里","周","吴","郑","王","秦","亲","还","好","赵","钱","孙","李","里","周","吴","郑","王","秦","亲","还","好","赵","钱","孙","李","里","周","吴","郑","王","秦","亲","还","好"]
        
        //基于 UILocalizedIndexedCollation 调用其方法
        UILocalizedIndexedCollation.getCurrentKeysAndObjectsData(needSortArray: testArray as NSArray) { (dataArray,titleArray) in
            self.objectsArray = dataArray
            self.keysArray    = titleArray
            self.tabView?.reloadData()
        }
    }
    
    //MARK: tabView数据源及代理相关
    func numberOfSections(in tableView: UITableView) -> Int {
        return keysArray!.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray![section].count
    }
    
    //MARK: 这是Setion标题 以及右侧索引数组设置
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keysArray?[section]
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keysArray
    }
    
    //MARK: 设置表头的高度。如果使用自定义表头，该方法必须要实现，否则自定义表头无法执行，也不会报错
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tabView?.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = objectsArray![indexPath.section][indexPath.row ].objValue
        cell?.selectionStyle = .blue
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

