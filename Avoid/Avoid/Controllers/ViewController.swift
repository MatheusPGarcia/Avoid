//
//  ViewController.swift
//  Avoid
//
//  Created by Matheus Garcia on 05/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import BarcodeScanner

class ViewController: UIViewController {

    @IBOutlet weak var responseLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func scanWasPressed(_ sender: UIButton) {
        let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        present(viewController, animated: true, completion: nil)
    }

    private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        return viewController
    }
}

// MARK: - BarcodeScannerCodeDelegate

extension ViewController: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {

        let checker = ProductHandler()
        checker.verifyProduct(barcode: code) { (result) in

            controller.dismiss(animated: true, completion: nil)

            let mainView = UIStoryboard(name: "Main", bundle: nil)
            let identifier = "FeedbackViewController"

            guard let destination = mainView.instantiateViewController(withIdentifier: identifier) as? FeedbackViewController else {
                print("Error loading feedbackViewController")
                return
            }

            destination.product = result

            let navController = UINavigationController(rootViewController: destination)

            self.navigationController?.present(navController, animated: true, completion: nil)
        }

        responseLabel.text = code
    }
}

// MARK: - BarcodeScannerErrorDelegate

extension ViewController: BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
}

// MARK: - BarcodeScannerDismissalDelegate

extension ViewController: BarcodeScannerDismissalDelegate {
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
