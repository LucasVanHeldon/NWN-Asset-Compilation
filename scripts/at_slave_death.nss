/*   Script generated by
Lilac Soul's NWN Script Generator, v. 1.2

For download info, please visit:
http://www.angelfire.com/space/lilacsoul    */

//Put this OnDeath
void main()
{

object oPC = GetLastKiller();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = OBJECT_SELF;

AdjustReputation(oPC, oTarget, -10);

AdjustAlignment(oPC, ALIGNMENT_EVIL, 2);

}

