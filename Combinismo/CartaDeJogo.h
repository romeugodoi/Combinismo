//
//  CartaDeJogo.h
//  Combinismo
//
//  Created by Romeu Godoi on 11/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Carta.h"

@interface CartaDeJogo : Carta

@property (strong, nonatomic) NSString *naipe;
@property (nonatomic) NSUInteger numero;

+ (NSArray *)naipesValidos;
+ (NSUInteger)numeroMaximo;

@end
