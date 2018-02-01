//
//  RoadController.swift
//  RaceAddict
//
//  Created by Hamilton on 01/02/18.
//  Copyright © 2018 Hamilton Santos. All rights reserved.
//

import UIKit

class RoadController {

    func segment(ctx, width, lanes, x1, y1, w1, x2, y2, w2, fog, color) {
    
    var r1 = Render.rumbleWidth(w1, lanes),
    r2 = Render.rumbleWidth(w2, lanes),
    l1 = Render.laneMarkerWidth(w1, lanes),
    l2 = Render.laneMarkerWidth(w2, lanes),
    lanew1, lanew2, lanex1, lanex2, lane;
    
    ctx.fillStyle = color.grass;
    ctx.fillRect(0, y2, width, y1 - y2);
    
    Render.polygon(ctx, x1-w1-r1, y1, x1-w1, y1, x2-w2, y2, x2-w2-r2, y2, color.rumble);
    Render.polygon(ctx, x1+w1+r1, y1, x1+w1, y1, x2+w2, y2, x2+w2+r2, y2, color.rumble);
    Render.polygon(ctx, x1-w1,    y1, x1+w1, y1, x2+w2, y2, x2-w2,    y2, color.road);
    
    if (color.lane) {
    lanew1 = w1*2/lanes;
    lanew2 = w2*2/lanes;
    lanex1 = x1 - w1 + lanew1;
    lanex2 = x2 - w2 + lanew2;
    for(lane = 1 ; lane < lanes ; lanex1 += lanew1, lanex2 += lanew2, lane++)
    Render.polygon(ctx, lanex1 - l1/2, y1, lanex1 + l1/2, y1, lanex2 + l2/2, y2, lanex2 - l2/2, y2, color.lane);
    }
    
    Render.fog(ctx, 0, y1, width, y2-y1, fog);
    }
}
