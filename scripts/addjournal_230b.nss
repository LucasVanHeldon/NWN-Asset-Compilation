/*   Script generated by
Lilac Soul's NWN Script Generator, v. 1.3

For download info, please visit:
http://www.lilacsoul.revility.com    */

//Put this OnEnter
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "journal230");

if (nInt == 0)
   {
   AddJournalQuestEntry("DameGold", 110, oPC, TRUE, FALSE);

   AddJournalQuestEntry("A1_DefeatSlaveLord", 230, oPC, TRUE, FALSE);

   SetLocalInt(oPC, "journal230", 1);

   }
}


