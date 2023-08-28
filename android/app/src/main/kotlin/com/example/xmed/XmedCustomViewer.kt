package com.example.xmed

import android.app.Activity
import android.os.Bundle
import com.namirial.android.namirialfeagui.pdf.PDFViewerActivity
import com.namirial.android.namirialfeagui.pdf.PDFViewerFragment
import com.namirial.android.namirialfeagui.pdf.menu.PdfMenuToolsVisibility

class XmedCustomViewer : PDFViewerActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
    }

    override fun startAction() {
        super.startAction()
    }

    override fun getPdfMenuToolsVisibility(): PdfMenuToolsVisibility {
        return super.getPdfMenuToolsVisibility()
    }

    override fun getSignatureFieldEnabled(field: PDFViewerFragment.SignatureField?): Boolean {
        return super.getSignatureFieldEnabled(field)
    }

    override fun isActionTerminated(): Boolean {
        return super.isActionTerminated()
    }

    override fun finish() {
        super.finish()
    }
}