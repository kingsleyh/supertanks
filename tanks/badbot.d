module net.masterthought.dtanks.samples.staticbot;

import net.masterthought.dtanks.brainhelper;
import net.masterthought.dtanks.bot.brain;
import net.masterthought.dtanks.arena;
import net.masterthought.dtanks.bot.sensor;
import net.masterthought.dtanks.bot.command;
import net.masterthought.dtanks.heading;
import net.masterthought.dtanks.skincolor;
import net.masterthought.dtanks.bot.radar;
import dsfml.graphics;

import std.random;
import std.stdio;
import std.range;

class StaticBot : Brain {

  mixin BrainHelper;

   static this(){
     Brain.add(new StaticBot());
   }

  override public Command tick(Sensor sensors){
    command.speed=3;
    float x = sensors.position.x;
    float y = sensors.position.y;
    if( x>= 1200 || y>=650 || x<=0 || y<=0 ){
      auto i = uniform(0, 180);
      command.heading = currentHeadingPlusDegrees(i);
    }

    if(hasReflections){
      Reflection reflection = reflections.front;
      float zero = sensors.heading.radians * Heading.ONE_DEGREE;
      float enemyDegrees = (reflection.heading.radians * Heading.ONE_DEGREE) + zero;
      int offset=20;
      if( enemyDegrees >=0 && enemyDegrees<180 ){
        command.turretHeading=currentRadarHeadingPlusDegrees(offset);  
      }
      else if(enemyDegrees >= 181 && enemyDegrees<360 ){
        command.turretHeading=currentRadarHeadingPlusDegrees(-offset);  
      } else {
        command.turretHeading=currentRadarHeadingPlusDegrees(0);          
      }
    }
    command.radarHeading=currentRadarHeadingPlusDegrees(39);

    
    command.firePower = 1;

    return command;
  }

  override public string name(){
    return "Cataclysmic Pulse Ripper";
  }

  override public SkinColor skin(){
    return SkinColor.pink;
  }

}
