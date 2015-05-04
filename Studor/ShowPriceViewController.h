//
//  ShowPriceViewController.h
//  Studor
//
//  Created by Marton Pono on 5/4/15.
//  Copyright (c) 2015 Omid Keypour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPriceViewController : UIViewController

@property (retain, strong) NSNumber *price;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
