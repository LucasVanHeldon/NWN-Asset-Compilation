//::///////////////////////////////////////////////
//:: FileName at_conv_attack
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////

#include "nw_i0_generic"
/*   Script generated by
Lilac Soul's NWN Script Generator, v. 1.2

For download info, please visit:
http://www.angelfire.com/space/lilacsoul    */

//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

AdjustAlignment(oPC, ALIGNMENT_EVIL, 2);

object oTarget;
oTarget = OBJECT_SELF;

SetIsTemporaryEnemy(oPC, oTarget);

AssignCommand(oTarget, ActionAttack(oPC));

AssignCommand(oTarget, DetermineCombatRound(oPC));

}

