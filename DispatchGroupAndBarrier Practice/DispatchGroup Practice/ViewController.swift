//
//  ViewController.swift
//  DispatchGroup Practice
//
//  Created by Oleg on 17.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let goButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Menu"
        
        setGoButton()

    }

    private func setGoButton() {
        goButton.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        self.goButton.center = self.view.center
        goButton.setTitle("Show Image", for: .normal)
        goButton.setTitleColor(.white,for: .normal)
        goButton.backgroundColor = .red
        goButton.layer.cornerRadius = 15
        goButton.addTarget(self, action: #selector(to2VC), for: .touchUpInside)
        self.view.addSubview(goButton)
    }

    @objc func to2VC() {
        let secondVC = SecondViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}

