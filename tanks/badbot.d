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
    if( x>= 1000 || y>=500 || x<=100 || y<=100 ){
      auto i = uniform(0, 180);
      command.heading = currentHeadingPlusDegrees(i);
    }

    if(hasReflections){
      Reflection reflection = reflections.front;
      float zero = sensors.heading.radians * Heading.ONE_DEGREE;
      float enemyDegrees = (reflection.heading.radians * Heading.ONE_DEGREE) + zero;
      int turretOffset=20;
      int radarOffset=0;
      if( enemyDegrees >=0 && enemyDegrees<180 ){
        command.turretHeading=currentRadarHeadingPlusDegrees(turretOffset);  
      }
      else if(enemyDegrees >= 181 && enemyDegrees<360 ){
        command.turretHeading=currentRadarHeadingPlusDegrees(-turretOffset);  
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
