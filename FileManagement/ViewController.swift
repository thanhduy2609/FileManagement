//
//  ViewController.swift
//  FileManagement
//
//  Created by Duy Bùi on 5/17/17.
//  Copyright © 2017 Duy Bùi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var fileManagaer:FileManager?
    var documentDir:NSString?
    var filePath:NSString?

    
    @IBAction func btnCreateFileClicked(_ sender: Any) {
        //TODO
        filePath = documentDir?.appendingPathComponent("file1.txt") as NSString?
        fileManagaer?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        
        filePath = documentDir?.appendingPathComponent("file2.txt") as NSString?
        fileManagaer?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "File created successfully")
    }
    
    @IBAction func btnCreateDirectoryClicked(_ sender: Any) {
        //TODO
        filePath = documentDir?.appendingPathComponent("/folder1") as NSString?
        do {
            try fileManagaer?.createDirectory(atPath: filePath! as String, withIntermediateDirectories: false, attributes: nil)
        }
        catch let error as NSError {
            print(error)
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "Directory created successfully")
    }
    
 
    @IBAction func btnEqualityCheckClicked(_ sender: Any) {
        let filePath1 = documentDir?.appendingPathComponent("file1.txt")
        let filePath2 = documentDir?.appendingPathComponent("file2.txt")
        
        if((fileManagaer? .contentsEqual(atPath: filePath1!, andPath: filePath2!)) != nil)
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are equal.")
        }
        else
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are not equal.")
        }

    }
    
    
    @IBAction func btnWiriteFileCliked(_ sender: Any) {
        //TODO
        let content: NSString = NSString(string: "Bùi Vũ Thanh Duy")
        let fileContent: Data = content.data(using: String.Encoding.utf8.rawValue)!
        try? fileContent.write(to: URL(fileURLWithPath: documentDir!.appendingPathComponent("file1.txt")), options: [.atomic])
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content written successfully")
    }
    
    
    @IBAction func btnReadFileClicked(_ sender: Any) {
        //TODO
        filePath = documentDir?.appendingPathComponent("/file1.txt") as! String as NSString
        var fileContent: Data?
        fileContent = fileManagaer?.contents(atPath: filePath! as String)
        let str: NSString = NSString(data: fileContent!, encoding: String.Encoding.utf8.rawValue)!
        self.showSuccessAlert(titleAlert: "Success", messageAlert: ("data : \(str)" as NSString) as String)
    }
    
    
    @IBAction func btnMoveFileClicked(_ sender: Any) {
        //TODO
        let oldFilePath: String = documentDir!.appendingPathComponent("file1.txt") as! String
        let newFilePath: String = documentDir!.appendingPathComponent("/folder1/file1.txt") as String
        do {
            try fileManagaer?.moveItem(atPath: oldFilePath, toPath: newFilePath)
        }
        catch let error as NSError {
            print(error)
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "File moved successfully")
    }
    
    
    @IBAction func btnCopyFileClicked(_ sender: Any) {
        //TODO
        let originalFile=documentDir?.appendingPathComponent("file1.txt")
        var copyFile=documentDir?.appendingPathComponent("copy.txt")
        try? fileManagaer?.copyItem(atPath: originalFile!, toPath: copyFile!)
        self.showSuccessAlert(titleAlert: "Success", messageAlert:"File copied successfully")           }
    
    
    @IBAction func btnFilePermissionsClick(_ sender: Any) {
        //TODO
        filePath = documentDir?.appendingPathComponent("file1.txt") as! NSString
        var filePermissions:NSString = ""
        
        if((fileManagaer?.isWritableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions = filePermissions.appending("file is writable. ") as NSString
        }
        if((fileManagaer?.isReadableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions = filePermissions.appending("file is readable. ") as NSString
        }
        if((fileManagaer?.isExecutableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions = filePermissions.appending("file is executable.") as NSString
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "\(filePermissions)")
    }
    
    @IBAction func btnDirectoryContantsClicked(_ sender: Any) {
       
        
        var error: NSError? = nil
        do {
            let arrDirContent = try fileManagaer!.contentsOfDirectory(atPath: filePath! as String)
            self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content of directory \(arrDirContent)")
        }
        catch let error as NSError {
            
        }
        
    }
    
    
    @IBAction func btnRemoveFileClicked(_ sender: Any) {
        //TODO
        filePath = documentDir?.appendingPathComponent("file1.txt") as! NSString
        try? fileManagaer?.removeItem(atPath: filePath as! String)
        self.showSuccessAlert(titleAlert: "Message", messageAlert: "File removed successfully.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fileManagaer = FileManager.default
        let dirPaths:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        documentDir = dirPaths[0] as? NSString
        print("path : \(documentDir)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showSuccessAlert(titleAlert: String, messageAlert: String)
    {
        let alert:UIAlertController = UIAlertController(title:titleAlert, message: messageAlert as String, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
        }
        alert.addAction(okAction)
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }
    }

}

