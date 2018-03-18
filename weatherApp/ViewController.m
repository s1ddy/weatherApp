//
//  ViewController.m
//  weatherApp
//
//  Created by apple on 11/03/18.
//  Copyright © 2018 Siddhesh Harsole. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCurrentLocation];
    self.title = @"Current Location";
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
-(void)getCurrentLocation{
    clmanager = [[CLLocationManager alloc]init];
    clmanager.desiredAccuracy = kCLLocationAccuracyBest;
    clmanager.distanceFilter = kCLDistanceFilterNone;
    [clmanager requestAlwaysAuthorization];
    [clmanager requestWhenInUseAuthorization];
    [clmanager startUpdatingLocation];
    
    
    
    
    NSLog(@"Lat%f--Long:-%f",clmanager.location.coordinate.latitude,clmanager.location.coordinate.longitude);
    [self mapView];
}

-(void)mapView{
    [self.mkview setRegion:MKCoordinateRegionMakeWithDistance(clmanager.location.coordinate,500,500)];
    
    MKPointAnnotation *pinA = [[MKPointAnnotation alloc]init];
    pinA.title = @"My Location";
    pinA.subtitle = @"Viman Nagar";
    pinA.coordinate = clmanager.location.coordinate;
    [self.mkview addAnnotation:pinA];
    
    [self getWeatherAPI];
    
    
}

-(void)getWeatherAPI{
    
    NSString *strUrl = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=45f7e5654874f0df08ab6f0aca67b538",clmanager.location.coordinate.latitude,clmanager.location.coordinate.longitude];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *datatask= [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error!=nil) {
            NSLog(@"%@",error.localizedDescription);
        }else{
            NSError *jsonError;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if (jsonError) {
                NSLog(@"%@",jsonError.localizedDescription);
            }else{
                NSDictionary *dicMain = [dict valueForKey:@"main"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    float temp = [[dicMain valueForKey:@"temp"]floatValue];

                    self.topdeglbl.text = [NSString stringWithFormat:@"%0.2f",temp/10];
                    
                    
                    float temp_min = [[dicMain valueForKey:@"temp_min"]floatValue];
                    self.mindeg.text  = [NSString stringWithFormat:@"%0.2f",temp_min/10];
                    
                    float temp_max = [[dicMain valueForKey:@"temp_max"]floatValue];
                    self.maxdeg.text = [NSString stringWithFormat:@"%0.2f",temp_max/10];
                    
                    NSString *strName = [dict valueForKey:@"name"];
                    self.topdloclbl.text = strName;
                    
                    NSArray *weather = [dict valueForKey:@"weather"];
                    NSDictionary *dictweather = [weather objectAtIndex:0];
                    
                    NSString *desc = [dictweather valueForKey:@"description"];
                    self.dslbl.text = desc;
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                });
                
                
                
            }
            }
        
        
    }];
    [datatask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
