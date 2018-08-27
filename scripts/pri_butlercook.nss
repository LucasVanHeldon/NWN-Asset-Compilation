//::///////////////////////////////////////////////
//:: Butler Cooks meat for player
//:: pri_butlercook
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 22, 2002
//:://////////////////////////////////////////////

#include "pri_inc"
#include "pri_text"

void main()
{
object oPC = GetPCSpeaker();

GetInnArea(oPC);

string sButler = GetLocalString(oPC, "RSA_Butler");
string sKitchen = GetLocalString(oPC, "RSA_ButKitchen");
string sNoMeat = GetLocalString(oPC, "RSA_ButNoMeat");
string sCook = GetLocalString(oPC, "RSA_ButCook");
string sMeatDone = GetLocalString(oPC, "RSA_ButMeatDone");

object oButler = GetObjectByTag(sButler);
object oWayPoint = GetWaypointByTag("POST_"+sButler);
object oKitchen = GetWaypointByTag(sKitchen);

int iHowManyMeat = 0;
int iPoison = GetLocalInt(oButler, "RSA_PoisonFood");

string sWhatFood = "cookedfood";

if (iPoison == 1)
{
sWhatFood = "poisonsteak";
SendMessageToAllDMs(POISONCOOK + GetName(oPC)+".");
}

object oFood = GetFirstItemInInventory(oPC);

AssignCommand(oButler, ClearAllActions());

while(GetIsObjectValid(oFood))
{
 if(GetTag(oFood) == "RawMeat")
 {
  iHowManyMeat++;
  DestroyObject(oFood);
 }
 oFood = GetNextItemInInventory(oPC);
}

if (iHowManyMeat == 0)
 {
 AssignCommand(oButler, ActionSpeakString(sNoMeat));
 return;
 }

AssignCommand(oButler, ActionSpeakString(sCook));
AssignCommand(oButler, ActionWait(2.0));
AssignCommand(oButler, ActionMoveToObject(oKitchen));
AssignCommand(oButler, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 30.0));
AssignCommand(oButler, ActionMoveToObject(oPC));
AssignCommand(oButler, ActionSpeakString(sMeatDone));

while (iHowManyMeat > 0)
{
object oFood = CreateItemOnObject(sWhatFood, oButler);
AssignCommand(oButler, ActionGiveItem(oFood, oPC));
iHowManyMeat--;
}

AssignCommand(oButler, ActionWait(2.0));
AssignCommand(oButler, ActionMoveToObject(oWayPoint));
AssignCommand(oButler, ActionDoCommand(SetFacing(GetFacing(oWayPoint))));

}
