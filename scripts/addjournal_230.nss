/*   Script generated by
Lilac Soul's NWN Script Generator, v. 1.2

For download info, please visit:
http://www.angelfire.com/space/lilacsoul    */

//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

AssignCommand(oPC, ClearAllActions());

object oTarget;
oTarget = GetWaypointByTag("DST_TrapDoor2Sewers2");

AssignCommand(oPC, ActionJumpToObject(oTarget));

int nInt;
nInt=GetLocalInt(oPC, "journal230");

if (nInt == 0)
   {
   AddJournalQuestEntry("DameGold", 110, oPC, TRUE, FALSE);

   AddJournalQuestEntry("A1_DefeatSlaveLord", 230, oPC, TRUE, FALSE);

   SetLocalInt(oPC, "journal230", 1);

   }
}

