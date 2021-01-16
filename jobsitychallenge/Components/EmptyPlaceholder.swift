//
//  EmptyPlaceholder.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 16/01/21.
//

import UIKit

class EmptyPlaceholder: UIView {
    
    //MARK: - UI Elements
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: Constants.xlargeFont, weight: .bold)
        return label
    }()
    
    //MARK: - Stacks
    
    lazy var mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(messageLabel)
        stackView.alignment = .center
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View SetUp
    
    private func config() {
        viewSetup()
        setConstraints()
    }
    
    private func viewSetup() {
        self.addSubview(mainStack)
    }
    
    //MARK: - Constraints
    
    private func setConstraints() {
        mainStack.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        messageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
