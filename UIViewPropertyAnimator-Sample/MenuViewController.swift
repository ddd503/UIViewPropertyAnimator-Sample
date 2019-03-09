//
//  MenuViewController.swift
//  UIViewPropertyAnimator-Sample
//
//  Created by kawaharadai on 2019/03/09.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

enum AnimationType: String, CaseIterable {
    case move = "単純な移動"
    case bezierCurve = "ベジェ曲線移動"
    case spring = "バネのような移動"
    case reversed = "移動中の逆再生"
    case slider = "スライダーで移動状態を調節"
    case add = "アニメーションをさらに追加"
    case addDelay = "遅延実行するアニメーションを追加"
}

final class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }

}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AnimationType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = AnimationType.allCases[indexPath.row].rawValue
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animationVC = AnimationViewController.make(type: AnimationType.allCases[indexPath.row])
        navigationController?.pushViewController(animationVC, animated: true)
    }
}
