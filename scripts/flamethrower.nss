/*   Script generated by
Lilac Soul's NWN Script Generator, v. 1.2

For download info, please visit:
http://www.angelfire.com/space/lilacsoul    */

//Goes OnPerceived of a creature
void main()
{

object oPC = GetLastPerceived();

if (!GetIsPC(oPC)) return; //check to make sure it sees a PC

if (!GetLastPerceptionSeen()) return;

int nFalseMerchantPlot;
nFalseMerchantPlot = GetLocalInt (oPC, "FalseMerchantPlot");

//checks to see if the PC is qualified for the "FalseMerchantPlot" plot; if so, script should stop here and not do anything else
if (!(nFalseMerchantPlot == 0))
   return;

int nInt;
nInt=GetLocalInt(oPC, "flame_thrower");

if (!(nInt <= 2))
   return;

nInt = GetLocalInt(oPC, "flame_thrower");

nInt = 1;

SetLocalInt(oPC, "flame_thrower", nInt);

ClearAllActions();

object oTarget;
oTarget = GetObjectByTag("FlameThrower");

AssignCommand(oTarget, ClearAllActions());

oTarget = GetObjectByTag("FlameThrower");

AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 3.0f));

object oCaster;
oCaster = GetObjectByTag("FlameThrowerDevice");

oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_FIREBALL, oTarget, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oTarget = GetObjectByTag("FlameThrower");

AssignCommand(oTarget, ActionWait(4.0f));

nInt=GetLocalInt(oPC, "flame_thrower");

if (!(nInt <= 2))
   return;

nInt = GetLocalInt(oPC, "flame_thrower");

nInt += 1;

SetLocalInt(oPC, "flame_thrower", nInt);

ClearAllActions();

oTarget = GetObjectByTag("FlameThrower");

AssignCommand(oTarget, ClearAllActions());

AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 3.0f));

oCaster = GetObjectByTag("FlameThrowerDevice");

oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_FIREBALL, oTarget, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oTarget = GetObjectByTag("FlameThrower");

AssignCommand(oTarget, ActionWait(4.0f));

nInt=GetLocalInt(oPC, "flame_thrower");

if (!(nInt <= 2))
   return;

nInt = GetLocalInt(oPC, "flame_thrower");

nInt += 1;

SetLocalInt(oPC, "flame_thrower", nInt);

ClearAllActions();

oTarget = GetObjectByTag("FlameThrower");

AssignCommand(oTarget, ClearAllActions());

AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 3.0f));

oCaster = GetObjectByTag("FlameThrowerDevice");

oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_FIREBALL, oTarget, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oTarget = GetObjectByTag("FlameThrower");

AssignCommand(oTarget, ActionWait(4.0f));

AssignCommand(oTarget, ActionEquipMostDamagingMelee());

oTarget = GetObjectByTag("FlameThrower");

AssignCommand(oTarget, ActionWait(2.0f));

SetIsTemporaryEnemy(oPC, oTarget);

AssignCommand(oTarget, ActionAttack(oPC));

}

