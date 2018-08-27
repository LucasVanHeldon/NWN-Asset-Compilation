void main()
{
object oPC = GetPCSpeaker();
object oHench = OBJECT_SELF;

int nMasterLevel = GetHitDice(oPC);
int nHenchLevel = GetHitDice(oHench);

if (nMasterLevel > nHenchLevel)
{
LevelUpHenchman(oPC,CLASS_TYPE_INVALID, TRUE);
}
}
