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
        // Rende i signature field d'uscita serializzabili
        outState.putSerializable(KEY_SIGNATURE_FIELDS, signatureFields)
        super.onSaveInstanceState(outState)
    }

    override fun startAction() {
        // Prima di avviare il wizard salvo i campi firma passati all'avvio dell' attività
        // per tracciarne il loro stato e valutare al termine dell' attività se si sia
        // conclusa con successo  meno
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
        // Personalizzazione menù laterale sinistro
        val section = PdfMenuToolsVisibility()
        section.document.signInformative = false
        section.document.viewInformative = false
        section.sign.area = signAreaVisible
        section.general.share = false
        section.document.flat = false
        return section
    }


    // Personalizzazione : tap nel field consentito o meno
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


    // define is Start Action is terminated and if the End Acton FAB must be show
    // Termino l'activity solo quando tutti i campi firma sono pieni
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
            // Recupero i campi firma non valorizzati
            for (signatureField in signatureFields) {
                if (signatureField.required && signedSignatureFields?.find { it.name == signatureField.id } == null) {
                    missingSignatures.add(signatureField.id);
                }
            }

            // ? L'attività finisce solo quando tutti i campi firma sono stati valorizzati
            if (missingSignatures.size > 0) {
                intent.putExtra("missingSignatures", missingSignatures.size.toString())
            } else if (missingSignatures.size == 0 && emptySignatureFields!!.size > 0 && partialSigning) {
                setResult(STATUS_INTERMEDIATE, intent)
                super.finish()
            }

            // Almeno un campo firma vuoto => Attività cancellata
            // Campi firma tutti valorizzati => Attività terminata con successo
            if (intent.hasExtra("missingSignatures")) setResult(Activity.RESULT_CANCELED, intent)
            else setResult(Activity.RESULT_OK, intent)

        } ?: if (emptySignatureFields!!.size > 0) {
            // Campi firma vuoti da valorizzare
            intent.putExtra("emptySignatures", emptySignatureFields!!.size)
            setResult(Activity.RESULT_CANCELED, intent)
        }
        super.finish()
    }
}