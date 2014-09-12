//
//  JogoDeCartasViewController.m
//  Combinismo
//
//  Created by Romeu Godoi on 11/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import "JogoDeCartasViewController.h"
#import "BaralhoDeJogo.h"

@interface JogoDeCartasViewController ()

// Model
@property (nonatomic) NSUInteger tentativas;
@property (strong, nonatomic) BaralhoDeJogo *baralhoJogo;

// View
@property (weak, nonatomic) IBOutlet UIButton *cartaButton;
@property (weak, nonatomic) IBOutlet UILabel *tentativasLabel;

@end

@implementation JogoDeCartasViewController

- (BaralhoDeJogo *)baralhoJogo
{
    if (!_baralhoJogo) _baralhoJogo = [BaralhoDeJogo new];
    
    return _baralhoJogo;
}

- (void)incrementaTentativasLabel:(UILabel *)label
{
    self.tentativas++;
    label.text = [NSString stringWithFormat:@"Tentativas: %lu", self.tentativas];
}

- (IBAction)virarCarta:(UIButton *)carta
{
    [carta setSelected: ![carta isSelected]];
    
    if ([carta isSelected]) {
        
        // Incrementa as tentativas
        [self incrementaTentativasLabel:self.tentativasLabel];
        
        // Seleciona carta
        Carta *cartaSelecionada = [self.baralhoJogo tirarCartaAleatoria];
        
        // Vira a carta
        [carta setTitle:cartaSelecionada.conteudo forState:UIControlStateSelected];
    }
}

@end
