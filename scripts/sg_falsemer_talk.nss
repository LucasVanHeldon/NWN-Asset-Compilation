#include "nw_i0_generic"
object oTarget;
/*   Script generated by
Lilac Soul's NWN Script Generator, v. 1.6

For download info, please visit:
http://www.lilacsoul.revility.com    */

//Goes OnPerceived of a creature
void main()
{

object oPC = GetLastPerceived();

if (!GetIsPC(oPC)) return;

if (!GetLastPerceptionSeen()) return;
int nInt;
nInt=GetLocalInt(oPC, "FalseMerchantPlot");

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

if (nInt == 1) //makes sure PC is qualified for "FalseMerchantPlot"
   {

   if (DoOnce==TRUE) return;

   SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

   ActionSpeakString("We must talk!");

   ActionMoveToObject(oPC);

   oTarget = OBJECT_SELF;

   ActionWait(2.0);

   AssignCommand(oTarget, ActionStartConversation(oPC, "falsemerch_plot"));

   }
else           //if not qualified for "FalseMerchantPlot", NPC attacks PC
   {
   oTarget = OBJECT_SELF;

   AdjustReputation(oPC, oTarget, -100);

   oTarget = OBJECT_SELF;

   SetIsTemporaryEnemy(oPC, oTarget);

   AssignCommand(oTarget, ActionAttack(oPC));

   AssignCommand(oTarget, DetermineCombatRound(oPC));

   }

}
