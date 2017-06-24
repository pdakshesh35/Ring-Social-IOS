//
//  CameraViewController.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/17/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
/*
 *CameraDelegate Protocol helps to pass the selected image to previous controller
 *two view -> camera view and imageview
 *camera view runs the camera
 *image view captures the image
 *decide camera position - back or front
 *create camera view
 *one tap and imageview pops up with image
 *another tap and imageview gets hide
 *camera button -> decides front or back camera position
 *implemented focus feature so now whenever you touch on the screen it will focus that area
 *create collectionview of filters
 */


//helps to pass the selcted image to previous controller


class Camera: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //initialize the CameraDelegate
    static var delegate : CameraDelegate!
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    
    //filter names in array
    var CIFilternames = ["CIPhotoEffectChrome",
                         "CIPhotoEffectFade",
                         "CIPhotoEffectInstant",
                         "CIPhotoEffectNoir",
                         "CIPhotoEffectProcess",
                         "CIPhotoEffectTonal",
                         "CIPhotoEffectTransfer",
                         "CISepiaTone"
    ]
    
    
    //capture button outlet for design
    @IBOutlet weak var captureBtnView: UIButton!
    
    
    //create cameraview with the help of these given variables
    var captureSession : AVCaptureSession?
    var stillImageOutput : AVCaptureStillImageOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?
    var lock = false
    
    //decide camera options is it back or front
    var backCamera : AVCaptureDevice!
    
    
    //imageview
    @IBOutlet weak var tempImageView: UIImageView!
    
    //cameraview
    @IBOutlet weak var cameraView: UIView!
    
    //boolean
    var isFlashOn = false
    
    
    //flip camera
    @IBOutlet weak var flipcamera: UIButton!
    @IBOutlet weak var closeview: UIButton!
    @IBOutlet weak var flashView: UIButton!
    @IBOutlet weak var cameraFetures: UIView!
    
    
    //number count for flip camera
    //if count is odd then camera should point to front
    //else count is even then camera should point to back
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get device position
        //         backCamera = getDevice(position: .back)!
        //        intializeCameraView(backCamera: backCamera)
        
        //capture button give a radius
        captureBtnView.circularControl(cornerRadius: 25)
        
        
        //filtercollection view initialization
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.isHidden = true
        self.filterCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: IDENTIFIERS_FILTER_CELL)
        filterCollectionView.backgroundColor = UIColor.clear
        //filter view
        
        
        //circularviews
        closeview.circularControl(cornerRadius: 15)
        cameraFetures.circularControl(cornerRadius: 10)
        
        
    }
    
    func filterButtonTapped(sender: UIButton) {
        let button = sender as UIButton
        
        tempImageView.image = button.backgroundImage(for: .normal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //camera position -> is it back or front
    
    func getDevice(position: AVCaptureDevicePosition) -> AVCaptureDevice? {
        let devices: NSArray = AVCaptureDevice.devices()! as NSArray;
        for de in devices {
            let deviceConverted = de as! AVCaptureDevice
            if(deviceConverted.position == position){
                return deviceConverted
            }
        }
        return nil
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor.red
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        backCamera = getDevice(position: .back)
        intializeCameraView(backCamera: backCamera)
        // flashOff(device: backCamera)
        
    }
    
    
    //camera view create
    func intializeCameraView(backCamera : AVCaptureDevice) {
        captureSession = AVCaptureSession()
        
        if (backCamera.position == AVCaptureDevicePosition.front) {
            captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        } else {
            captureSession?.sessionPreset = AVCaptureSessionPresetHigh
        }
        
        //        if(isFlashOn) {
        //            flashOn(device: backCamera)
        //
        //        } else {
        //            flashOff(device: backCamera)
        //        }
        
        var error : NSError?
        var input = AVCaptureDeviceInput()
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
            if ( captureSession?.canAddInput(input) != nil)
            {
                captureSession?.addInput(input)
                stillImageOutput = AVCaptureStillImageOutput()
                stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
                
                if (captureSession?.canAddOutput(stillImageOutput))! {
                    captureSession?.addOutput(stillImageOutput)
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                    previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                    previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                    cameraView.layer.addSublayer(previewLayer!)
                    captureSession?.startRunning()
                    self.previewLayer?.frame = self.cameraView.bounds
                }
            }
            
        } catch let error1 as NSError {
            //error
            error = error1
            AlertMessage(title: "Camera View", message: (error?.localizedDescription)!, viewController: self)
        }
        
    }
    
    
    //one tap take a photo
    func didPressTakePhoto() {
        if let videoConnection = stillImageOutput?.connection(withMediaType: AVMediaTypeVideo) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.portrait
            
            
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (sampleBufffer, error) in
                if sampleBufffer != nil {
                    
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBufffer)
                    let dataProvider = CGDataProvider(data: imageData! as CFData)
                    let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
                    let image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                    self.tempImageView.image = image
                    // CameraViewController.delegate.returnImage(image: image)
                    self.lock = true
                    self.tempImageView.isHidden = false
                    
                    
                    //filter's image
                    //filter1 : CISepiaTone
                    //filter2 : CIExposureAdjust
                    //filters array : CFFilternames
                    //with the for loop create and everyfilter imageview via collection or scrollview
                    
                    self.filterCollectionView.reloadData()
                    
                    
                    
                }
            })
        }
    }
    
    
    //orientation lock
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    //if photo is captured or not
    var didTakePhoto = Bool()
    
    
    //after taking photo if user taps then again camera view continues
    //Nuteral zone where we have to choose which button should appear before-after capture button was clicked
    func didPressBefore_After() {
        if didTakePhoto == true {
            //normal view while image is not taken
            var color = UIColor.white
            captureBtnView.layer.borderWidth = 2.0
            captureBtnView.layer.borderColor = color.cgColor
            lock = false
            tempImageView.isHidden = true
            filterCollectionView.isHidden = true
            cameraFetures.isHidden = false
            didTakePhoto = false
        }else {
            //view after image has taken
            var color = UIColor.orange
            captureBtnView.layer.borderWidth = 2.0
            captureBtnView.layer.borderColor = color.cgColor
            captureSession?.startRunning()
            didTakePhoto = true
            filterCollectionView.isHidden = false
            cameraFetures.isHidden = true
            didPressTakePhoto()
        }
        
    }
    
    
    
    
    
    //if screen has been touched or not
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        let screenSize = previewLayer?.bounds.size
        if let touchPoint = touches.first {
            let x = touchPoint.location(in: cameraView).y / (screenSize?.height)!
            let y = 1.0 - touchPoint.location(in: cameraView).x / (screenSize?.width)!
            let focusPoint = CGPoint(x: x, y: y)
            
            if let device = backCamera {
                do {
                    try device.lockForConfiguration()
                    
                    device.focusPointOfInterest = focusPoint
                    //device.focusMode = .continuousAutoFocus
                    device.focusMode = .autoFocus
                    //device.focusMode = .locked
                    device.exposurePointOfInterest = focusPoint
                    device.exposureMode = AVCaptureExposureMode.continuousAutoExposure
                    device.unlockForConfiguration()
                }
                catch {
                    // just ignore
                }
            }
        }
        
    }
    
    
    //switch camera features flip camera between front and back
    func switchCamera() {
        
        if (backCamera.position == AVCaptureDevicePosition.front) {
            
            backCamera = getDevice(position: .back)!
            intializeCameraView(backCamera: backCamera)
        } else if (backCamera.position == AVCaptureDevicePosition.back) {
            
            backCamera = getDevice(position: .front)!
            intializeCameraView(backCamera: backCamera)
            
        } else {
            
            backCamera = getDevice(position: .back)!
            intializeCameraView(backCamera: backCamera)
        }
        
    }
    
    //camera button to switch is being clicked
    @IBAction func camera(_ sender: Any) {
        switchCamera()
    }
    
    
    
    //filter the image
    func getFilteredImage(imageView : UIImageView, filter1 : String) -> UIImage{
        guard let image = imageView.image, let cgimg = image.cgImage else {
            print("imageView doesn't have an image!")
            return UIImage()
        }
        
        let ciContext = CIContext(options: nil)
        let coreImage = CIImage(image: imageView.image!)
        let filter = CIFilter(name: filter1 )
        filter!.setDefaults()
        filter!.setValue(coreImage, forKey: kCIInputImageKey)
        let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
        let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
        let result = UIImage(cgImage: filteredImageRef!, scale: (imageView.image?.scale)!, orientation: (imageView.image?.imageOrientation)!)
        return result
        
        
    }
    
    func filterTheImage(imageView : UIImageView, filter1 : String) {
        guard let image = imageView.image, let cgimg = image.cgImage else {
            print("imageView doesn't have an image!")
            return
        }
        
        let ciContext = CIContext(options: nil)
        let coreImage = CIImage(image: imageView.image!)
        let filter = CIFilter(name: filter1 )
        filter!.setDefaults()
        filter!.setValue(coreImage, forKey: kCIInputImageKey)
        let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
        let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
        let result = UIImage(cgImage: filteredImageRef!, scale: (imageView.image?.scale)!, orientation: (imageView.image?.imageOrientation)!)
        imageView.image = result
        
        
    }
    
    //flash on
    private func flashOn(device:AVCaptureDevice)
    {
        do{
            if (device.hasTorch)
            {
                try device.lockForConfiguration()
                device.torchMode = .on
                device.flashMode = .on
                device.unlockForConfiguration()
            }
        }catch{
            //DISABEL FLASH BUTTON HERE IF ERROR
            print("Device tourch Flash Error ");
        }
    }
    
    //flash off
    private func flashOff(device:AVCaptureDevice)
    {
        do{
            if (device.hasTorch){
                try device.lockForConfiguration()
                device.torchMode = .off
                device.flashMode = .off
                device.unlockForConfiguration()
            }
        }catch{
            //DISABEL FLASH BUTTON HERE IF ERROR
            print("Device tourch Flash Error ");
        }
    }
    
    //flash button clicked and change the isFlashon value with image
    @IBAction func flash(_ sender: Any) {
        if(!isFlashOn) {
            isFlashOn = true
            flashView.setBackgroundImage(#imageLiteral(resourceName: "flash"), for: .normal)
        } else {
            isFlashOn = false
            flashView.setBackgroundImage(#imageLiteral(resourceName: "nontflash"), for: .normal)
        }
    }
    
    
    //fire the flash
    func toggleFlash() {
        var device : AVCaptureDevice!
        
        if #available(iOS 10.0, *) {
            let videoDeviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInDuoCamera], mediaType: AVMediaTypeVideo, position: .unspecified)!
            let devices = videoDeviceDiscoverySession.devices!
            device = devices.first!
            
        } else {
            // Fallback on earlier versions
            device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        }
        
        if ((device as AnyObject).hasMediaType(AVMediaTypeVideo))
        {
            if (device.hasTorch)
            {
                self.captureSession?.beginConfiguration()
                //self.objOverlayView.disableCenterCameraBtn();
                if device.isTorchActive == false {
                    self.flashOn(device: device)
                } else {
                    self.flashOff(device: device);
                }
                //self.objOverlayView.enableCenterCameraBtn();
                self.captureSession?.commitConfiguration()
            }
        }
    }
    
    //capture image
    //if isflashon then fire the flash while taking the image
    @IBAction func captureBtnAction(_ sender: Any) {
        didPressBefore_After()
        
        //        if(isFlashOn) {
        //            toggleFlash()
        //            didPressBefore_After()
        //        } else {
        //
        //            didPressBefore_After()
        //        }
        
        
    }
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CIFilternames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: IDENTIFIERS_FILTER_CELL, for: indexPath) as! FilterCollectionViewCell
        if(self.tempImageView.image != nil) {
            cell.imageView.image = self.getFilteredImage(imageView: self.tempImageView, filter1: CIFilternames[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = filterCollectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
        self.tempImageView.image = self.getFilteredImage(imageView: cell.imageView, filter1: CIFilternames[indexPath.row])
        
        // CameraViewController.delegate.returnImage(image: self.tempImageView.image!)
        
        
    }
    
    //Filter collection view
    
    
    
}
