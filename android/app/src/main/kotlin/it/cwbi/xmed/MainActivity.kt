package it.cwbi.xmed

import android.content.Intent
import it.cwbi.xmed.models.SignatureField
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

const val SETUP_CHANNEL = "cwbi/setup"
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
        setupChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SETUP_CHANNEL)
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
            if (call.method == "startWizard") {
                val arguments = call.arguments() as HashMap<String, Object>?

                val filePath = arguments?.get("pdfFile") as String
                val signatureFields = arguments?.get("signatureFields") as List<String>
                val partialSigning = arguments?.get("partialSigning") as Boolean

                // startWizard(filePath, signatureFields);
                startPreview(filePath, signatureFields.toTypedArray(), partialSigning);
            }
        }

        // license channel implementation
        licenseChannel.setMethodCallHandler { call, result ->
            if (call.method == "requireLicense") {
                val arguments = call.arguments() as HashMap<String, String>?

                val username = arguments?.get("username") as String
                val mailAddress = arguments?.get("mailAddress") as String
                val licenseFile = arguments?.get("licenseFile") as String

                requireLicense(username, mailAddress, licenseFile, result);
            }

            if (call.method == "getLicenseData") {
                getLicenseData()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == SIGN_PDF_REQUEST || requestCode == PREVIEW_REQUEST_CODE) {
            val _data = LinkedHashMap<String, String?>()

            val pdfPath: String? = data?.getStringExtra("pdfPath")
            _data["pdfPath"] = pdfPath

            when (resultCode) {
                RESULT_OK -> {
                    _data["status"] = "SIGNED"
                }
                STATUS_INTERMEDIATE -> {
                    val emptySignatures: String? = data?.getStringExtra("emptySignatures")
                    val missingSignatures: String? = data?.getStringExtra("missingSignatures")

                    _data["status"] = "INTERMEDIATE"
                    _data["emptySignatures"] = emptySignatures
                    _data["missingSignatures"] = missingSignatures
                }
                else -> {
                    val emptySignatures: String? = data?.getStringExtra("emptySignatures")
                    val missingSignatures: String? = data?.getStringExtra("missingSignatures")

                    _data["status"] = "CANCELLED"
                    _data["emptySignatures"] = emptySignatures
                    _data["missingSignatures"] = missingSignatures
                }
            }

            // Invoco il metodo completeWizard di Flutter con tutti i dati recuperati durante l' attività
            viewerChannel.invokeMethod("completeWizard", _data)
        }
    }

    // Recupera i dati della licenza usando i channel di flutter
    private fun getLicenseData(){
        val license = FeaLicense.getInstance()

        license.getLicenseData { ld ->
            licenseChannel.invokeMethod("retrieveLicense", ld.toJsonString());
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
                var _outputSignatureField : SignatureField =  SignatureField()
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
        var jsonLicense: String;

        if (licenseData.isDataValid) { //check if all the license data are correct
            license.requireLicense(licenseData) { licenseTaskEndStatus ->
                //LISTENT TO END LICENSE REQUIREMENT EVENT
                when (licenseTaskEndStatus) {
                    LicenseTaskEndStatus.OK,
                    LicenseTaskEndStatus.LICENSE_RECOVERED -> {
                        val data = HashMap<String, String>()
                        license.getLicenseData { ld ->
                            print(ld.isDemo)
                            result.success(ld.toJsonString());
                            //licenseChannel.invokeMethod("requiredLicense", ld.toJsonString());
                        }
                    }
                    LicenseTaskEndStatus.LICENSE_FROZEN,
                    LicenseTaskEndStatus.LICENSE_EXPIRED -> {
                        // show a message to the user
                        var errMesssage: String? = licenseTaskEndStatus.message
                        result.success("expired");
                        //licenseChannel.invokeMethod("requiredLicense", "expired");
                    }
                    LicenseTaskEndStatus.ERROR_CERTIFICATE_INVALID -> {
                        // show a message to the user
                        var errMesssage: String? = licenseTaskEndStatus.message
                        //YOUR AFGCLIC IS CORRUPTED OR SIGNING CERTIFICATE IS EXPIRED
                        //please contact our sales to get an updated AFGCLIC license file to
                        //use with your app
                        result.success("invalid");
                        //licenseChannel.invokeMethod("requiredLicense", "invalid");
                    }
                    else -> {
                        //THERE IS SOMETHING WRONG WITH YOUR LICENSE
                        var errMesssage: String? = licenseTaskEndStatus.message
                        result.success("error");
                        //licenseChannel.invokeMethod("requiredLicense", "error");
                    }
                }

            }
        } else if (!licenseData.hasValidCertificate()) {
            result.success("wrong params");
            //licenseChannel.invokeMethod("requiredLicense", "wrong params");
        } else {
            result.success("invalid certificate");
            //licenseChannel.invokeMethod("requiredLicense", "invalid certificate");
        }
    }


}
