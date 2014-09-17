//
//  JogoDeCartasViewController.m
//  Combinismo
//
//  Created by Romeu Godoi on 11/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import "JogoDeCartasViewController.h"
#import "JogoDeCombinacaoDeCartas.h"
#import "BaralhoDeJogo.h"

@interface JogoDeCartasViewController ()

// Model
@property (strong, nonatomic) JogoDeCombinacaoDeCartas *jogo;

// View
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cartasButton;
@property (weak, nonatomic) IBOutlet UILabel *pontuacaoLabel;

@end

@implementation JogoDeCartasViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    self.jogo = [[JogoDeCombinacaoDeCartas alloc] initComContagemDeCartas:self.cartasButton.count usandoBaralho:[BaralhoDeJogo new]];
    
    return self;
}

- (JogoDeCombinacaoDeCartas *)jogo
{
    if (!_jogo) _jogo = [[JogoDeCombinacaoDeCartas alloc] initComContagemDeCartas:self.cartasButton.count usandoBaralho:[BaralhoDeJogo new]];
    
    return _jogo;
}

- (IBAction)virarCarta:(UIButton *)cartaButton
{
    NSUInteger index = [self.cartasButton indexOfObject:cartaButton];
    
    [self.jogo escolherCartaNoIndex:index];
    
    [self atualizarUI];
}

- (void)atualizarUI
{
    for (NSUInteger i=0; i < self.cartasButton.count; i++) {
        
        Carta *carta = [self.jogo cartaNoIndex:i];
//        UIButton *cartaButton = self.cartasButton[i];
        
        if (carta.isEscolhida) {
            
            [self.cartasButton[i] setBackgroundImage:[UIImage imageNamed:@"cartaFrente"] forState:UIControlStateNormal];
            [self.cartasButton[i] setTitle:carta.conteudo forState:UIControlStateNormal];
        }
        else {
            [self.cartasButton[i] setBackgroundImage:[UIImage imageNamed:@"cartaVerso"] forState:UIControlStateNormal];
            [self.cartasButton[i] setTitle:@"" forState:UIControlStateNormal];
        }
        
    }
}

@end
