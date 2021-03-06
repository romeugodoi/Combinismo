//
//  JogoDeCartasViewController.h
//  Combinismo
//
//  Created by Romeu Godoi on 11/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartaView.h"

@interface JogoDeCartasViewController : UIViewController

- (void)derrubarCarta:(CartaView *)cartaView;
- (void)restaurarCartasDerrubadas;
- (void)atualizarUI;

@end
