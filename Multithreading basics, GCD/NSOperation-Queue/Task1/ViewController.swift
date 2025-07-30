//
//  ViewController.swift
//  Multithreading basics, GCD
//
//  Created by Bartosz Strzecha on 30/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private let operationTests = NSOperationQueueTests()
    
    private let mainQueueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Run on Main Queue", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let customQueueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Run on Custom Queue", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(mainQueueButton)
        view.addSubview(customQueueButton)
        
        mainQueueButton.addTarget(self, action: #selector(runMainQueueOperation), for: .touchUpInside)
        customQueueButton.addTarget(self, action: #selector(runCustomQueueOperation), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            mainQueueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainQueueButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            customQueueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customQueueButton.topAnchor.constraint(equalTo: mainQueueButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func runMainQueueOperation() {
        print("Running operation on MAIN queue")
        operationTests.runOperation(useMainQueue: true)
    }
    
    @objc private func runCustomQueueOperation() {
        print("Running operation on CUSTOM queue")
        operationTests.runOperation(useMainQueue: false)
    }
}
