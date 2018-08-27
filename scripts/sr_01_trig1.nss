// this is the on enter script if a trigger that encompasses the NPC who will be
//initiating dialouge. Make sure to replace the value of sTag with the tag of
//the NPC in question.
void main()
{
    string sTag = "Laurl";
    string SRTag = "SR_" + sTag;
    object oNPC = GetObjectByTag(sTag);
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) &&
       GetLocalInt(oPC,SRTag) == 0 &&
       IsInConversation(oNPC) == FALSE)
    {
        SetLocalInt(oPC,SRTag, 1);
        AssignCommand(oPC,ClearAllActions());
        AssignCommand(oNPC,ClearAllActions());
//        AssignCommand(oNPC,ActionMoveToObject(oPC));
        AssignCommand(oNPC,ActionStartConversation(oPC));
    }
}
