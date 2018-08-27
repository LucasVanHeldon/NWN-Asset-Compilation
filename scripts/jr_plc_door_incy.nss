//::///////////////////////////////////////////////
//:: Generic Door Placeable (OnUse)
//:: Us_Wind3Door_SW.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Jump the player to the appropriate location.
     Also gives Door Placeable the proper Open and
     Close animations.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 20, 2003
//:: Modified By: JayAre
//:: Modified On: Sept 07, 2003
//:://////////////////////////////////////////////

void main()
{
    object oDestination = GetObjectByTag("WP_FromInnerCourtyard");  //Insert tag of where the door will lead to.
    object oPC = GetLastUsedBy();
    int bOpen = GetLocalInt(OBJECT_SELF, "bOpen");

    if (bOpen == FALSE)
    {
        //Open the door.
        PlayAnimation(ANIMATION_PLACEABLE_OPEN);
        SetLocalInt(OBJECT_SELF, "bOpen", TRUE);
        DelayCommand(6.0, PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
        DelayCommand(6.0, SetLocalInt(OBJECT_SELF, "bOpen", FALSE));
    }
    if (bOpen == TRUE)
    {
        //Jump the player to Door Placeable's Destination.
        PlayAnimation(ANIMATION_PLACEABLE_OPEN);
        DelayCommand(1.0, AssignCommand(oPC, JumpToObject(oDestination)));
        DelayCommand(2.0, PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
    }
}
