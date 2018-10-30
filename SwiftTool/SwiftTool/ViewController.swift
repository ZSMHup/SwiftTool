//
//  ViewController.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/10/16.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        UITableView().chain
            .delegate(self)
            .dataSource(self)
            .register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
            .build
    }()
    
    private lazy var dataSource: [(title: String, controller: UIViewController.Type)] = {
        return [
            (title: "Network", controller: NetworkViewController.self),
            (title: "Download", controller: DownloadListViewController.self),
            (title: "Charts", controller: ChartsViewController.self)
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.textLabel?.text = dataSource[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = dataSource[indexPath.row].controller.init()
        navigationController?.pushViewController(vc, animated: true)
    }
}
