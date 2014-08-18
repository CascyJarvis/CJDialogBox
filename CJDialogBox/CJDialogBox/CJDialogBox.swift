//
//  CJDialogBox.swift
//  CJDialogBox
//
//  Created by Jarvis on 14-8-4.
//  Copyright (c) 2014年 森哲. All rights reserved.
//

import UIKit

enum ArrowDirection : Int{
    case arrowNone = 0
    case arrowDirectionLeft
    case arrowDirectionRight
    case arrowDirectionTop
    case arrowDirectionBottom
}

struct Triangle{
    var apex = CGPointZero
    var bottom1 = CGPointZero
    var bottom2 = CGPointZero
    var height = 0.0 as CGFloat
    var direction : ArrowDirection = ArrowDirection.arrowNone
}

class CJDialogBox: UIView {
    
    var fillColor : UIColor?
    var arcRaidus : Float?
    var triangle = Triangle()
    
    convenience init(frame: CGRect , fillColor : UIColor , arcRaidus : Float){
        self.init(frame:frame)
        
        self.fillColor = fillColor
        self.arcRaidus = arcRaidus
    }
    
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        self.opaque = false
    }
    
    func setupTriangle(direction : ArrowDirection , height : Float , apexDirection : Float ,
                bottomDirection1 : Float , bottomDirection2 : Float)
    {
        
        var h = CGFloat(height)
        var a = CGFloat(apexDirection)
        var b1 = CGFloat(bottomDirection1)
        var b2 = CGFloat(bottomDirection2)
        
        triangle.height = h
        triangle.direction = direction
        
        switch direction{
            
        case .arrowDirectionLeft:
            triangle.apex = CGPointMake(0,a)
            triangle.bottom1 = CGPointMake(h, max(b1, b2))
            triangle.bottom2 = CGPointMake(h, min(b1, b2))
            
        case .arrowDirectionTop:
            triangle.apex = CGPointMake(a, 0)
            triangle.bottom1 = CGPointMake(min(b1, b2), h)
            triangle.bottom2 = CGPointMake(max(b1, b2), h)
            
        case .arrowDirectionRight:
            triangle.apex = CGPointMake(frame.width, a)
            triangle.bottom1 = CGPointMake(frame.width - h, min(b1, b2))
            triangle.bottom2 = CGPointMake(frame.width - h, max(b1, b2))
            
        case .arrowDirectionBottom:
            triangle.apex = CGPointMake(a, frame.height)
            triangle.bottom1 = CGPointMake(max(b1, b2), frame.height - h)
            triangle.bottom2 = CGPointMake(min(b1, b2), frame.height - h)
            
        default:
            break
        }
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code// Drawing code
        var context : CGContextRef = UIGraphicsGetCurrentContext()
        var raidus : CGFloat = CGFloat(arcRaidus!)
                
        CGContextClearRect(context, rect)
        
        CGContextSetFillColorWithColor(context, fillColor?.CGColor)
        
        
        if triangle.direction == .arrowNone
        {
            CGContextMoveToPoint(context, rect.midX, rect.minY)
            CGContextAddArcToPoint(context, rect.midX, rect.minY, rect.maxX, rect.minY, raidus)
            CGContextAddArcToPoint(context, rect.maxX, rect.minY, rect.maxX, rect.maxY, raidus)
            CGContextAddArcToPoint(context, rect.maxX, rect.maxY, rect.minX, rect.maxY, raidus)
            CGContextAddArcToPoint(context, rect.minX, rect.maxY, rect.minX, rect.minY, raidus)
            CGContextAddArcToPoint(context, rect.minX, rect.minY, rect.midX, rect.minY, raidus)
        }
        
        if triangle.direction == .arrowDirectionLeft
        {
            var rrect = CGRect(x: rect.origin.x + triangle.height,
                               y: rect.origin.y,
                           width: rect.size.width - triangle.height,
                          height: rect.size.height)
            
            CGContextMoveToPoint(context, triangle.bottom1.x, triangle.bottom1.y)
            CGContextAddLineToPoint(context, triangle.apex.x, triangle.apex.y)
            CGContextAddLineToPoint(context, triangle.bottom2.x, triangle.bottom2.y)
            
            CGContextAddArcToPoint(context, triangle.bottom2.x, triangle.bottom2.y, rrect.minX, rrect.minY, raidus)
            CGContextAddArcToPoint(context, rrect.minX, rrect.minY, rrect.maxX, rrect.minY, raidus)
            CGContextAddArcToPoint(context, rrect.maxX, rrect.minY, rrect.maxX, rrect.maxY, raidus)
            CGContextAddArcToPoint(context, rrect.maxX, rrect.maxY, rrect.minX, rrect.maxY, raidus)
            CGContextAddArcToPoint(context, rrect.minX, rrect.maxY, triangle.bottom1.x, triangle.bottom1.y, raidus)
            
        }
        
        if triangle.direction == .arrowDirectionTop
        {
            var rrect = CGRect(x: rect.origin.x,
                               y: rect.origin.y + triangle.height,
                           width: rect.size.width,
                          height: rect.size.height - triangle.height)
            
            CGContextMoveToPoint(context, triangle.bottom1.x, triangle.bottom1.y)
            CGContextAddLineToPoint(context, triangle.apex.x, triangle.apex.y)
            CGContextAddLineToPoint(context, triangle.bottom2.x, triangle.bottom2.y)
            
            
            CGContextAddArcToPoint(context, triangle.bottom2.x, triangle.bottom2.y, rrect.maxX, rrect.minY, raidus)
            CGContextAddArcToPoint(context, rrect.maxX, rrect.minY, rrect.maxX, rrect.maxY, raidus)
            CGContextAddArcToPoint(context, rrect.maxX, rrect.maxY, rrect.minX, rrect.maxY, raidus)
            CGContextAddArcToPoint(context, rrect.minX, rrect.maxY, rrect.minX, rrect.minY, raidus)
            CGContextAddArcToPoint(context, rrect.minX, rrect.minY, triangle.bottom1.x, triangle.bottom1.y, raidus)
        }
        
        if triangle.direction == .arrowDirectionRight
        {
            var rrect = CGRect(x: rect.origin.x,
                y: rect.origin.y,
                width: rect.size.width - triangle.height,
                height: rect.size.height)
            
            CGContextMoveToPoint(context, triangle.bottom1.x, triangle.bottom1.y)
            CGContextAddLineToPoint(context, triangle.apex.x, triangle.apex.y)
            CGContextAddLineToPoint(context, triangle.bottom2.x, triangle.bottom2.y)
            
            CGContextAddArcToPoint(context, triangle.bottom2.x, triangle.bottom2.y, rrect.maxX, rrect.maxY, raidus)
            CGContextAddArcToPoint(context, rrect.maxX, rrect.maxY, rrect.minX, rrect.maxY, raidus)
            CGContextAddArcToPoint(context, rrect.minX, rrect.maxY, rrect.minX, rrect.minY, raidus)
            CGContextAddArcToPoint(context, rrect.minX, rrect.minY, rrect.maxX, rrect.minY, raidus)
            CGContextAddArcToPoint(context, rrect.maxX, rrect.minY, triangle.bottom2.x, triangle.bottom2.y, raidus)
        }
        
        if triangle.direction == .arrowDirectionBottom
        {
            var rrect = CGRect(x: rect.origin.x,
                y: rect.origin.y,
                width: rect.size.width,
                height: rect.size.height - triangle.height)
            
            CGContextMoveToPoint(context, triangle.bottom1.x, triangle.bottom1.y)
            CGContextAddLineToPoint(context, triangle.apex.x, triangle.apex.y)
            CGContextAddLineToPoint(context, triangle.bottom2.x, triangle.bottom2.y)
            
            CGContextAddArcToPoint(context, triangle.bottom2.x, triangle.bottom2.y, rrect.minX, rrect.maxY, raidus)
            CGContextAddArcToPoint(context, rrect.minX, rrect.maxY, rrect.minX, rrect.minY, raidus)
            CGContextAddArcToPoint(context, rrect.minX, rrect.minY, rrect.maxX, rrect.minY, raidus)
            CGContextAddArcToPoint(context, rrect.maxX, rrect.minY, rrect.maxX, rrect.maxY, raidus)
            CGContextAddArcToPoint(context, rrect.maxX, rrect.maxY, triangle.bottom2.x, triangle.bottom2.y,raidus)
        }
        
        CGContextClosePath(context)
        CGContextFillPath(context)
        
    }

}

extension CGContextRef
{
    
}

