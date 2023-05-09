//
//  ViewController.swift
//  FirstPipelineUIkitCombine
//
//  Created by sss on 09.05.2023.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var viewModel = FirstPipelineViewModel()
    let label = UILabel()
    let textField = UITextField()
    
    var anyCanceballe: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.frame = CGRect(x: 250, y: 100, width: 100, height: 50)
        textField.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        textField.placeholder = "Your name"
        
        view.addSubview(label)
        view.addSubview(textField)
        
        textField.delegate = self
        
        viewModel.$validation
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: label)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel.name = string
        return true
    }
}


class FirstPipelineViewModel: ObservableObject {
    @Published var name = ""
    @Published var validation: String? = ""
    
    init() {
        $name
            .map {$0.isEmpty ? "💔": "❤️‍🔥"}
            .assign(to: &$validation)
    }
}
