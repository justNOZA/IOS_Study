import UIKit
import PDFKit

@IBOutlet weak var policyPdfView: PDFView!
let pdfURL = Bundle.main.url(forResource: "manual", withExtension: "pdf")!

override func viewDidLoad() {
    super.viewDidLoad()
    showPDF()
}

func showPDF(){
    if let document = PDFDocument(url: pdfURL) {
        pdfView.document = document
    }
    pdfView.autoScales = true
}
