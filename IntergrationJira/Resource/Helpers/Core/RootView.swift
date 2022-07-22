import Foundation

protocol RootView: AnyObject {
    
    func configureView()
    
    func constructHierarchy()
    
    func activateConstraints()
    
    func wireActions()
    
    func configureAppearance()
    
    func configureContent()
    
    func setupBindings()
    
}

extension RootView {
    
    func configureView() {
        constructHierarchy()
        activateConstraints()
        wireActions()
        configureAppearance()
        configureContent()
        setupBindings()
    }
    
    func setupBindings() {}
    
    func wireActions() {}
    
    func configureAppearance() {}
    
    func configureContent() {}
}
