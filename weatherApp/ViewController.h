//
//  ViewController.h
//  weatherApp
//
//  Created by apple on 11/03/18.
//  Copyright © 2018 Siddhesh Harsole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *clmanager ;
}
@property (strong, nonatomic) IBOutlet MKMapView *mkview;
@property (strong, nonatomic) IBOutlet UILabel *topdeglbl;
@property (strong, nonatomic) IBOutlet UILabel *minlbl;
@property (strong, nonatomic) IBOutlet UILabel *maxlbl;
@property (strong, nonatomic) IBOutlet UILabel *topdloclbl;
@property (strong, nonatomic) IBOutlet UILabel *mindeg;
@property (strong, nonatomic) IBOutlet UILabel *maxdeg;
@property (strong, nonatomic) IBOutlet UILabel *dslbl;







@end

