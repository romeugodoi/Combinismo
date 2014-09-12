//
//  CartaDeJogo.m
//  Combinismo
//
//  Created by Romeu Godoi on 11/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import "CartaDeJogo.h"

@implementation CartaDeJogo

- (NSString *)conteudo
{
    NSArray *numerosStrings = [CartaDeJogo numerosString];

    return [numerosStrings[self.numero] stringByAppendingString:self.naipe];
}

@synthesize naipe = _naipe;

- (void)setNaipe:(NSString *)naipe
{
    if ([[CartaDeJogo naipesValidos] containsObject:naipe]) {
        _naipe = naipe;
    }
}

- (NSString *)naipe
{
    return _naipe ? _naipe : @"?";
}

+ (NSArray *)naipesValidos
{
    return @[@"♥️", @"♦️", @"♠️", @"♣️"];
}

+ (NSArray *)numerosString
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)numeroMaximo
{
    return [CartaDeJogo numerosString].count - 1;
}

- (void)setNunmero:(NSUInteger)numero
{
    if (numero <= [CartaDeJogo numeroMaximo]) {
        _numero = numero;
    }
}

@end
