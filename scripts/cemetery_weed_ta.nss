/*   Script generated by
Lilac Soul's NWN Script Generator, v. 1.2

For download info, please visit:
http://www.angelfire.com/space/lilacsoul    */

//Put this OnEnter
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = oPC;

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectMovementSpeedDecrease(75), oTarget, 60.0f);
SendMessageToPC(oPC,"As you walk amongst the overgrown weeds, the weeds seem to come alive and entwine around your legs, effectively slowing your movement.");

}

