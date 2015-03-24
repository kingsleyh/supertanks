module net.masterthought.dtanks.samples.runaway;

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

class Runaway : Brain {

  mixin BrainHelper;

  SkinColor skinColor = SkinColor.red;

   static this(){
     Brain.add(new Runaway());
   }

  float prevHealth = 0;
  bool fleeing = false;
  int fleeDuration = 0;

  override public Command tick(Sensor sensors){

    if(!fleeing) {
      if(sensors.health < prevHealth) {
        fleeing = true;
        fleeDuration = 200;
        command.heading = currentHeadingPlusDegrees(60);
        command.speed = maxSpeed;
      } else {
        // attack
        command.speed = 0;
      }
    } else if (fleeDuration-- < 0) {
      fleeing = false;
    } else {
      command.heading = currentHeadingPlusDegrees(1);
    }

    checkWall();

    prevHealth = sensors.health;

    attack();
    return command;
  }

  private void attack(){

    if(hasReflections){
       Reflection reflection = reflections.front;
       command.radarHeading = reflection.heading;
       command.turretHeading = reflection.heading;
       if(reflection.distance < 80){
         command.firePower = maxFirePower;
       } else
       {
         command.firePower = 1;
       }
      } else {
        //command.firePower = 0;
        command.radarHeading = currentRadarHeadingPlusDegrees(5);
      }
  }

  private void checkWall(){
    if(isOnWall()){
      command.heading = currentHeadingPlusDegrees(19);
    }
  }

  override public string name(){
    return "Runaway!";
  }

  override public SkinColor skin(){
    return skinColor;
  }

}
