//
//  SpeechTextViewController.swift
//  HEAhmedAlSuwaidi
//
//  Created by Tanura Vittil on 12/3/17.
//  Copyright © 2017 Electronic Village. All rights reserved.
//

import UIKit
import Speech

class SpeechTextViewController: AAViewController,SFSpeechRecognizerDelegate{
    
    @IBOutlet weak var SpeechText: UILabel!
    @IBOutlet weak var MicButton: UIButton!
    @IBOutlet weak var SpeechSearchButton: UIButton!
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer : SFSpeechRecognizer? = SFSpeechRecognizer()
    //var request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask? = nil
    
    let searchService = AASearchService()
    var articlesArray: [AAArticleModel]?
    
    
    @IBAction func MicButtonClicked(_ sender: UIButton) {
         self.recordAndRecognizeSpeech()
    }
    @IBAction func SpeechSearchButtonClicked(_ sender: Any) {
        //print(SpeechText.text)
        
        showLoaderOnView(self.view)
        //print (SpeechText.text)
        //to be changed to todays date or default date on calender
        if (SpeechText.text == nil)
        {
            //eventdatestring = "1975-12-01"
        }
        
        searchService.getSearchResult(SpeechText.text) { (articles, error) in
            self.articlesArray = articles
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                self.performSegue(withIdentifier: "speechtext", sender: nil)
                //self.tableView.reloadData()
            }
        }
    }
    
    func recordAndRecognizeSpeech()
    {
        let locale = NSLocale.autoupdatingCurrent
        let code = locale.languageCode!
        let language = locale.localizedString(forLanguageCode: code)!
        print ("device locale is ")
        print("\(language)")
        
        
        //guard let node  = audioEngine.inputNode else { return }
        let node  = audioEngine.inputNode
        
        let recordingFormat = node.outputFormat(forBus: 0)
        self.audioEngine.stop()
        node.removeTap(onBus: 0)
        var request = SFSpeechAudioBufferRecognitionRequest()
        //Note : SFSpeechAudioBufferRecognitionRequest cannot be reused.
        //self.request = nil
        self.recognitionTask = nil
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in request.append(buffer)
            
        }
        audioEngine.prepare()
        do{
            try audioEngine.start()
        } catch {
            print("tan1")
            return print(error)
        }
        
        guard let myRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ar-SA")) else {
            //A recognizer is not supported for the current locale
            print("tan2")
            
            return
        }
        
        print ("speech recognizer locale is ")
        print (myRecognizer.locale)
        
        if !myRecognizer.isAvailable {
            //The recognizer is not available right now
            print("tan3")
            return
        }
        
        self.SpeechText.text = "Click Mic and Speak"
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result,error in
            print (" tan4")
            if let result = result {
                print ("tan5")
                let bestString = result.bestTranscription.formattedString
                self.SpeechText.text = bestString
            } else if let error = error {
                print ("tan6")
                print (error)
            }
        })
        
        print (" done audio")
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let dashboard = segue.destination as? AADashboardViewController
        
        dashboard?.isSearchBased = true
        dashboard?.searchString = self.SpeechText.text
        dashboard?.articlesArray=self.articlesArray
        print("\(segue.destination)")
        
    }
   

}
