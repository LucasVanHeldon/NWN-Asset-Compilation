#include "NW_I0_GENERIC"

void main()
{
    object oAss = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,GetPCSpeaker());
    int iBuffed = TalentUseProtectionOthers(oAss);
    if (!iBuffed) iBuffed = TalentEnhanceOthers(oAss,TRUE);
    SetLocalInt(GetPCSpeaker(),"BuffedUp",iBuffed);
}
