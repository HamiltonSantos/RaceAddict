//
//  RoadController.swift
//  RaceAddict
//
//  Created by Hamilton on 01/02/18.
//  Copyright © 2018 Hamilton Santos. All rights reserved.
//

import UIKit

class RoadController: NSObject {
    
    func rumbleWidth(projectedRoadWidth: Int, lanes: Int) -> Int {
        return projectedRoadWidth/max(6,  2*lanes)
    }
    
    func laneMarkerWidth(projectedRoadWidth:Int , lanes: Int) -> Int {
        return projectedRoadWidth/max(32, 8*lanes)
    }

    func segment(context: CGSize, width: Int, lanes: Int, x1: Int, y1: Int, w1: Int, x2: Int, y2: Int, w2: Int, fog: Float, color: GameColor) {
    
        var r1 = rumbleWidth(projectedRoadWidth: w1, lanes: lanes),
    r2 = rumbleWidth(projectedRoadWidth: w2, lanes: lanes),
    l1 = laneMarkerWidth(projectedRoadWidth: w1, lanes: lanes),
    l2 = laneMarkerWidth(projectedRoadWidth: w2, lanes: lanes)
    
    
    polygon(context, x1-w1-r1, y1, x1-w1, y1, x2-w2, y2, x2-w2-r2, y2, color.rumbleRed)
    polygon(context, x1+w1+r1, y1, x1+w1, y1, x2+w2, y2, x2+w2+r2, y2, color.rumbleWhite)
    polygon(context, x1-w1,    y1, x1+w1, y1, x2+w2, y2, x2-w2,    y2, color.asphaltDark)
    
    if (color.lane) {
    var lanew1 = w1*2/lanes;
    var lanew2 = w2*2/lanes;
    var lanex1 = x1 - w1 + lanew1;
    var lanex2 = x2 - w2 + lanew2;
    for(lane = 1 ; lane < lanes ; lanex1 += lanew1, lanex2 += lanew2, lane++)
    Render.polygon(ctx, lanex1 - l1/2, y1, lanex1 + l1/2, y1, lanex2 + l2/2, y2, lanex2 - l2/2, y2, color.lane);
    }
    
    Render.fog(ctx, 0, y1, width, y2-y1, fog);
    }
    
    func polygon(context: CGSize, x1, y1, x2, y2, x3, y3, x4, y4, color) {
    ctx.fillStyle = color;
    ctx.beginPath();
    ctx.moveTo(x1, y1);
    ctx.lineTo(x2, y2);
    ctx.lineTo(x3, y3);
    ctx.lineTo(x4, y4);
    ctx.closePath();
    ctx.fill();
    }
    
    func fog(context, x, y, width, height, fog) {
    if (fog < 1) {
    ctx.globalAlpha = (1-fog)
    ctx.fillStyle = COLORS.FOG;
    ctx.fillRect(x, y, width, height);
    ctx.globalAlpha = 1;
    }
    }
}
