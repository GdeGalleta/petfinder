//
//  ViewControllerErrorReportable.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 10/3/22.
//

import UIKit
import Combine

public protocol ViewControllerErrorReportable where Self: UIViewController {

    var baseViewModel: ViewModelErrorReportable { get }
    var cancellables: Set<AnyCancellable> { get set }
}

extension ViewControllerErrorReportable {

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "kAccept".localized, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    public func bindAlert() {
        self.baseViewModel.errorMessagePublisher
            .receive(on: RunLoop.main)
            .sink { errorMessage in
                guard let errorMessageValue = errorMessage, !errorMessageValue.isEmpty else { return }
                self.showAlert(errorMessageValue)
            }
            .store(in: &self.cancellables)
    }
}
