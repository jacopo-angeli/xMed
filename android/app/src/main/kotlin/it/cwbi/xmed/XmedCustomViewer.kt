package it.cwbi.xmed

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import it.cwbi.xmed.models.SignatureField
import com.namirial.android.namirialfeagui.pdf.PDFViewerActivity
import com.namirial.android.namirialfeagui.pdf.PDFViewerFragment
import com.namirial.android.namirialfeagui.pdf.menu.PdfMenuToolsVisibility

class XmedCustomViewer : PDFViewerActivity() {

    companion object {
        const val KEY_SIGNATURE_FIELDS = "signatureFields"
        const val PARTIAL_SIGNING = "partialSigning"
    }

    private var signAreaVisible: Boolean = true
    private var includeBiometricData: Boolean = true
    private var signatureFields: ArrayList<SignatureField>? = null

    private var partialSigning: Boolean = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (savedInstanceState == null) {
            signatureFields =
                intent.getSerializableExtra(KEY_SIGNATURE_FIELDS) as ArrayList<SignatureField>?
        } else {
            signatureFields =
                savedInstanceState.getSerializable(KEY_SIGNATURE_FIELDS) as ArrayList<SignatureField>?
        }
        partialSigning = intent.getBooleanExtra(PARTIAL_SIGNING, false)
    }

    override fun onSaveInstanceState(outState: Bundle) {
        outState.putSerializable(KEY_SIGNATURE_FIELDS, signatureFields)
        super.onSaveInstanceState(outState)
    }

    override fun startAction() {
        signatureFields?.let {
            var signatureFields = arrayOfNulls<String>(it.size)
            val signatureFieldsIncludeBiometricData = BooleanArray(it.size)
            val signatureFieldsRequired = BooleanArray(it.size)
            it.forEachIndexed { index, signatureField ->
                signatureFields[index] = signatureField.id
                signatureFieldsIncludeBiometricData[index] = includeBiometricData
                signatureFieldsRequired[index] = signatureField.required
            }
            startWizard(
                signatureFields,
                signatureFieldsIncludeBiometricData,
                signatureFieldsRequired
            )
        } ?: super.startAction()
    }

    override fun getPdfMenuToolsVisibility(): PdfMenuToolsVisibility? {
        val section = PdfMenuToolsVisibility()
        section.document.signInformative = false
        section.document.viewInformative = false
        section.sign.area = signAreaVisible
        section.general.share = false
        section.document.flat = false
        return section
    }

    override fun getSignatureFieldEnabled(field: PDFViewerFragment.SignatureField?): Boolean {
        field?.let { field ->
            signatureFields?.let { signatureFields ->
                if (signatureFields.find { it.id == field.name } == null) {
                    return false
                }
            }
        }
        return super.getSignatureFieldEnabled(field)
    }

    override fun isActionTerminated(): Boolean {
        signatureFields?.let { signatureFields ->
            for (signatureField in signatureFields) {
                if (signatureField.required && signedSignatureFields?.find { it.name == signatureField.id } == null) {
                    return false
                }
            }
            return true
        }
        return super.isActionTerminated()
    }

    override fun finish() {
        val intent = Intent()
        intent.putExtra("pdfPath", pdfPath)

        signatureFields?.let { signatureFields ->
            val missingSignatures = ArrayList<String>();
            for (signatureField in signatureFields) {
                if (signatureField.required && signedSignatureFields?.find { it.name == signatureField.id } == null) {
                    //logInternal("Campo non trovato $signatureField")
                    missingSignatures.add(signatureField.id);
                }
            }

            if (missingSignatures.size > 0) {
                intent.putExtra("missingSignatures", missingSignatures.size.toString())
            } else if (missingSignatures.size == 0 && emptySignatureFields!!.size > 0 && partialSigning) {
                setResult(STATUS_INTERMEDIATE, intent)
                super.finish()
            }

            if (intent.hasExtra("missingSignatures")) setResult(Activity.RESULT_CANCELED, intent)
            else setResult(Activity.RESULT_OK, intent)

        } ?: if (emptySignatureFields!!.size > 0) {
            intent.putExtra("emptySignatures", emptySignatureFields!!.size)
            setResult(Activity.RESULT_CANCELED, intent)
        }
        super.finish()
    }
}