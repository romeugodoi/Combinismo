//
//  CartaView.m
//  Combinismo
//
//  Created by Romeu Godoi on 24/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import "CartaView.h"

@implementation CartaView

- (void)setNaipe:(NSString *)naipe
{
    _naipe = naipe;
    
    [self setNeedsDisplay];
}

- (void)setNumero:(NSString *)numero
{
    _numero = numero;
    
    [self setNeedsDisplay];
}

- (void)setAtiva:(BOOL)ativa
{
    _ativa = ativa;
    
    [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGRect frameGlobal = self.bounds;
    self.alpha = 1.0;
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Carta Drawing Frente (branca e com naipe e números)
    if (self.isAtiva) {
        UIBezierPath* cartaPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frameGlobal), CGRectGetMinY(frameGlobal), CGRectGetWidth(frameGlobal), CGRectGetHeight(frameGlobal)) cornerRadius: 7];
        [UIColor.whiteColor setFill];
        [cartaPath fill];
        
        //// retanguloInterno Drawing
        UIBezierPath* retanguloInternoPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frameGlobal) + floor(CGRectGetWidth(frameGlobal) * 0.06195 + 0.1) + 0.4, CGRectGetMinY(frameGlobal) + floor(CGRectGetHeight(frameGlobal) * 0.04291 + 0.32) + 0.18, floor(CGRectGetWidth(frameGlobal) * 0.94418 + 0.46) - floor(CGRectGetWidth(frameGlobal) * 0.06195 + 0.1) - 0.36, floor(CGRectGetHeight(frameGlobal) * 0.95824 - 0.21) - floor(CGRectGetHeight(frameGlobal) * 0.04291 + 0.32) + 0.53) cornerRadius: 2];
        [UIColor.lightGrayColor setStroke];
        retanguloInternoPath.lineWidth = 1;
        [retanguloInternoPath stroke];
        
        
        //// Naipe Superior Drawing
        CGRect naipeSuperiorRect = CGRectMake(CGRectGetMinX(frameGlobal) + 6, CGRectGetMinY(frameGlobal) + 6, 14, 15);
        {
            NSString* textContent = self.numero;
            NSMutableParagraphStyle* naipeSuperiorStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
            naipeSuperiorStyle.alignment = NSTextAlignmentCenter;
            
            NSDictionary* naipeSuperiorFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 12], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: naipeSuperiorStyle};
            
            [textContent drawInRect: CGRectOffset(naipeSuperiorRect, 0, (CGRectGetHeight(naipeSuperiorRect) - [textContent boundingRectWithSize: naipeSuperiorRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: naipeSuperiorFontAttributes context: nil].size.height) / 2) withAttributes: naipeSuperiorFontAttributes];
        }
        
        //// Naipe Inferior Drawing
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, CGRectGetMaxX(frameGlobal) - 13, CGRectGetMaxY(frameGlobal) - 13.5);
        CGContextRotateCTM(context, 180 * M_PI / 180);
        
        CGRect naipeInferiorRect = CGRectMake(-7, -7.5, 14, 15);
        {
            NSString* textContent = self.numero;
            NSMutableParagraphStyle* naipeInferiorStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
            naipeInferiorStyle.alignment = NSTextAlignmentCenter;
            
            NSDictionary* naipeInferiorFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 12], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: naipeInferiorStyle};
            
            [textContent drawInRect: CGRectOffset(naipeInferiorRect, 0, (CGRectGetHeight(naipeInferiorRect) - [textContent boundingRectWithSize: naipeInferiorRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: naipeInferiorFontAttributes context: nil].size.height) / 2) withAttributes: naipeInferiorFontAttributes];
        }
        
        CGContextRestoreGState(context);
        
        
        //// Texto Drawing
        CGRect textoRect = CGRectMake(CGRectGetMinX(frameGlobal) + 6, CGRectGetMinY(frameGlobal) + 35, CGRectGetWidth(frameGlobal) - 12, 29);
        {
            NSString* textContent = self.naipe;
            NSMutableParagraphStyle* textoStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
            textoStyle.alignment = NSTextAlignmentCenter;
            
            NSDictionary* textoFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica-Bold" size: 22], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: textoStyle};
            
            [textContent drawInRect: CGRectOffset(textoRect, 0, (CGRectGetHeight(textoRect) - [textContent boundingRectWithSize: textoRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: textoFontAttributes context: nil].size.height) / 2) withAttributes: textoFontAttributes];
        }
    }
    else {
        //// Carta Drawing Verso (com a imagem)
        UIImage* verso = [UIImage imageNamed: @"cartaVerso"];
        UIBezierPath* cartaPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frameGlobal), CGRectGetMinY(frameGlobal), CGRectGetWidth(frameGlobal), CGRectGetHeight(frameGlobal)) cornerRadius: 7];
        CGContextSaveGState(context);
        CGContextSetPatternPhase(context, CGSizeMake(0, 0));
        [[UIColor colorWithPatternImage: verso] setFill];
        [cartaPath fill];
        CGContextRestoreGState(context);
    }
    
    if (!self.enabled) {
        self.alpha = 0.6;
    }
}


@end
