package com.example.xmed

import android.content.Intent
import android.os.Environment
import com.example.xmed.models.SignatureField
import com.namirial.android.license.LicenseTaskEndStatus
import com.namirial.android.license.RequireLicenseData
import com.namirial.android.namirialfea.license.FeaLicense
import com.namirial.android.namirialfeagui.pdf.PDFUtils
import com.namirial.android.namirialfeagui.pdf.PDFViewerActivity
import com.namirial.android.namirialfeagui.pdf.Wizard
import com.namirial.android.namirialfeagui.pdf.Wizard.WizardPDF
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

const val VIEWER_CHANNEL = "cwbi/viewer"
const val LICENSE_CHANNEL = "cwbi/license"

// ? Forniti da Namirial ???
const val PREVIEW_REQUEST_CODE: Int = 103
const val SIGN_PDF_REQUEST: Int = 103
const val STATUS_INTERMEDIATE: Int = 103

class MainActivity: FlutterActivity() {
    // Dichiarazione dei channels utilizzati
    private lateinit var setupChannel : MethodChannel
    private lateinit var viewerChannel : MethodChannel
    private lateinit var licenseChannel : MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        PDFUtils.activateSDK("", "", "");

        // istanzializzazione dei channels
        // setupChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SETUP_CHANNEL)
        viewerChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, VIEWER_CHANNEL)
        licenseChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, LICENSE_CHANNEL)

        // setup channel implementation
        // ? Quando viene chiamato
        setupChannel.setMethodCallHandler { call, result ->

            // metodo activateSDK per attivazione dell'SDK
            if(call.method == "activateSDK"){

                // recupero dei parametri della chiamata
                val arguments = call.arguments() as HashMap<String, String>?
                val company = arguments?.get("company") as String
                val mail = arguments?.get("mail") as String
                val serial = arguments?.get("serial") as String

                // Attivazione SDK
                val activation = PDFUtils.activateSDK(company, mail, serial)

                // Return del risultato
                result.success(activation)
            }
        }


        // viewer channel implementation
        viewerChannel.setMethodCallHandler { call, result ->
            if(call.method == "StartWizard"){
                // recupero dei parametri della chiamata
                val arguments = call.arguments() as HashMap<String, String>?
                val filePath = arguments?.get("pdfFile") as String
                val signatureFields = arguments?.get("signatureFields") as List<String>
                val partialSigning = arguments?.get("partialSigning") as Boolean

                // Apro preview del pdf
                startPreview(filePath, signatureFields.toTypedArray(), partialSigning);
            }
        }
    }

    // Avvia la preview con i campi di firma selezionati
    private fun startPreview(filename: String, inputSignatureFieldsList: Array<String>, partialSigning: Boolean){
        // Da doc.namirial.com
        val intent = Intent(activity, XmedCustomViewer::class.java)
        intent.putExtra(PDFViewerActivity.KEY_PDF, filename)

        // Aggiunta dei signature fields
        if(inputSignatureFieldsList.isNotEmpty()){
            // Creazione della ista di Signature Fields da passare al wizard di namirial
            val __outputSignatureFieldsList = ArrayList<SignatureField>()

            // Valorizzazione della lista di Signature Fields
            for(inputSignatureField in inputSignatureFieldsList){
                var _outputSignatureField :SignatureField =  SignatureField()
                _outputSignatureField.id = inputSignatureField
                _outputSignatureField.required = true
                __outputSignatureFieldsList.add(_outputSignatureField)
            }
        }

        // Avvio attività di firma(preview)
        startActivityForResult(intent, PREVIEW_REQUEST_CODE)
    }

    // Avvia il wizard di firma con i campi firma passati per parametri
    private fun startWizard(filename: String, signatureFields: List<String>){
        // Creazioene del wizard di firma
        val wizard : Wizard = Wizard()

        // Configurazione del wizard
        wizard.wizardConfiguration = Wizard.WizardConfiguration()

        // Creazione del wizard specifico per file pdf
        val wizardPDF : WizardPDF = Wizard.WizardPDF(filename, "")

        // Settings per i campi firma

        if(signatureFields == null){
            // Nessun campo firma
            wizardPDF.isHandleSignatureFields = true
            wizardPDF.isIncludeBiometricData = true
        }else{
            // Aggiungo i campi firma al wizardPdf
            signatureFields!!.forEach { signatureField ->
                wizardPDF.addSignatureField(
                        Wizard.WizardSignatureField(signatureField,
                                true,
                                true)) }
        }

        // Aggiunta del wizard specifico al wizard padre
        wizard.addWizardPDF(wizardPDF)

        // Avvio del programma
        wizard.startWizard(this@MainActivity, SIGN_PDF_REQUEST)
    }

    // Funzione per richiedere la licenza
    private fun requireLicense(
            username : String,
            mailAddress : String,
            licenseFile :String,
            result: MethodChannel.Result
    ){
        val license = FeaLicense.getInstance()
        val licenseData = RequireLicenseData()

        licenseData.userName = username
        licenseData.userMailAddress = mailAddress

        licenseData.setPromoCodeFromLicenseFile(path = licenseFile)
        var jsonLicense : String

        if(licenseData.isDataValid){
            license.requireLicense(licenseData){licenseTaskEndStatus ->
                when(licenseTaskEndStatus){
                    LicenseTaskEndStatus.OK,
                        LicenseTaskEndStatus.LICENSE_RECOVERED->{
                            val data = HashMap<String, String>()
                        license.getLicenseData{ licenseData ->
                            print(licenseData.isDemo)
                            result.success(licenseData.toJsonString());
                        }
                        }
                }
            }
        }
    }


}
