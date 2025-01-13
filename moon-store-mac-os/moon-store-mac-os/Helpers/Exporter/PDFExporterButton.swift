//
//  PDFExporterButton.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/12/25.
//

import SwiftUI

private enum Constants {
    static let shareIcon: String = "square.and.arrow.up.circle"
    static let pdfExtension: String = ".pdf"
}

struct ExportPDFButton<Content: View>: View {
    private let fileName: String
    private let content: Content
    
    init(fileName: String,
         content: () -> Content) {
        self.fileName = fileName
        self.content = content()
    }
    
    var body: some View {
        Button {
            NSWorkspace.shared.selectFile(nil,
                                          inFileViewerRootedAtPath: renderPDF.path)
        } label: {
            labelView
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Label View
    
    private var labelView: some View {
        HStack {
            Image(systemName: Constants.shareIcon)
            
            Text(localized(.exportButton))
        }
    }
    
    // MARK: - Current Date
    
    private var currentDate: String {
        let date: Date = Date.now
        let formattedDate = date.formatted(date: .abbreviated, time: .omitted)
        return "\(formattedDate)"
    }
    
    // MARK: - Render PDF
    
    @MainActor
    var renderPDF: URL {
        let url: URL = .downloadsDirectory.appendingPathComponent(localized(.pathComponent),
                                                                  conformingTo: .pdf)
        let rendered = ImageRenderer(content: content)
        
        rendered.render { size, context in
            var box = CGRect(origin: .zero, size: size)
            
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil)
            else { return }
            
            pdf.beginPDFPage(nil)
            
            context(pdf)
            
            pdf.endPDFPage()
            pdf.closePDF()
        }
        return url
    }
}

// MARK: - Localized

extension ExportPDFButton {
    private enum LocalizedKey {
        case exportButton
        case pathComponent
    }
    
    private func localized(_ key: LocalizedKey) -> String {
        switch key {
            case .exportButton: "Exportar"
            case .pathComponent: "\(fileName)-\(currentDate)\(Constants.pdfExtension)"
        }
    }
}
