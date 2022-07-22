import UIKit
import DropDown

final class DropDownMenu: NiblessView {
    
    // MARK: - Properties
    
    var callback: (() -> Void)?
    private var hierarchyNotReady = true
    
    // MARK: - Outlets
    
    let dropDownContainer = UIView()
    
    let dropDownMenuButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 2.0
        return button
    }()

    lazy var dropDownItem: DropDown = {
        let dropDown = DropDown()
        dropDown.anchorView = dropDownContainer
        dropDown.textFont = UIFont.systemFont(ofSize: 14)
        dropDown.direction = .bottom
        dropDown.cornerRadius = 6
        dropDown.shadowOpacity = 0.3
        dropDown.shadowRadius = 2
        return dropDown
    }()
    
    let dropDownIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic_drop_down")
        return image
    }()
    
    func setContent(title: String, dataSource: [String]) {
        dropDownMenuButton.setTitle(title, for: .normal)
        dropDownItem.dataSource = dataSource
    }
}

extension DropDownMenu: RootView {
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else { return }
        configureView()
        hierarchyNotReady = false
    }

    func constructHierarchy() {
        addSubview(dropDownMenuButton)
        addSubview(dropDownItem)
        addSubview(dropDownIcon)
        
        addSubview(dropDownContainer)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            dropDownMenuButton.topAnchor.constraint(equalTo: topAnchor),
            dropDownMenuButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            dropDownMenuButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            dropDownMenuButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            dropDownIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            dropDownIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            dropDownContainer.topAnchor.constraint(equalTo: dropDownMenuButton.bottomAnchor),
            dropDownContainer.rightAnchor.constraint(equalTo: rightAnchor),
            dropDownContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            dropDownContainer.widthAnchor.constraint(equalToConstant: bounds.width * 0.8)
        ])
    }

    func wireActions() {
        dropDownMenuButton.addTarget(self, action: #selector(didTapMenu), for: .touchUpInside)
    }
    
    func configureContent() {
        backgroundColor = .clear
    }
}

extension DropDownMenu {
    func showDropDown() {
        dropDownItem.show()
    }
    
    @objc private func didTapMenu() {
        callback?()
    }
}
