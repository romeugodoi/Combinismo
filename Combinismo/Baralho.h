//
//  Baralho.h
//  Combinismo
//
//  Created by Romeu Godoi on 11/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Carta.h"

@interface Baralho : NSObject

- (void)adicionarCarta:(Carta *)carta emCima:(BOOL)emCima;
- (Carta *)tirarCartaAleatoria;

@end
