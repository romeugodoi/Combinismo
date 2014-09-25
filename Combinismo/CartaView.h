//
//  CartaView.h
//  Combinismo
//
//  Created by Romeu Godoi on 24/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CartaView : UIControl

@property (strong, nonatomic) IBInspectable NSString *naipe;
@property (strong, nonatomic) IBInspectable NSString *numero;
@property (nonatomic, getter=isAtiva) IBInspectable BOOL ativa;

@end
