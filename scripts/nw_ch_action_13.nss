// * Joins, takes away other people's personal items, give player his personal item
#include "sr_i0_henchman"

void main()
{//DestroyAllPersonalItems(GetPCSpeaker()); DONE IN THE GIVBE ITEM FUNCTION
 // * remove previous henchman

//SpeakString("test");
 if (GetIsObjectValid(GetHenchman(GetPCSpeaker())) == TRUE)
 {  SetFormerMaster(GetPCSpeaker(), GetHenchman(GetPCSpeaker()));
    object oHench =   GetHenchman(GetPCSpeaker());
    RemoveHenchman(GetPCSpeaker(), GetHenchman(GetPCSpeaker()));
    AssignCommand(oHench, ClearAllActions());
 }

 SetWorkingForPlayer(GetPCSpeaker());
 SetBeenHired();

 ExecuteScript("NW_CH_JOIN", OBJECT_SELF);
 GivePersonalItem(GetPCSpeaker());
}
