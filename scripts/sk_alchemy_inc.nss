int GetToolLevel(object oPC)
{
    object oItem = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem)){
        string sTag = GetTag(oItem);
        if(GetStringLeft(sTag,11)=="alchemytool"){
            return StringToInt(GetStringRight(sTag,3));
        }
        oItem = GetNextItemInInventory(oPC);
    }
    return 0;
}

int GetToolLevel2(object oTool)
{
    return StringToInt(GetStringRight(GetTag(oTool),3));
}

void RemoveATools(object oPC)
{
    object oItem = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem)){
        string sTag = GetTag(oItem);
        if(GetStringLeft(sTag,11)=="alchemytool")DestroyObject(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
}

int GetCombinedLevel(object oPC)
{
    return GetLevelByPosition(1,oPC)+GetLevelByPosition(2,oPC)+GetLevelByPosition(3,oPC);
}

int GetMaxSkillLevel(object oPC)
{
    int nLevel = GetCombinedLevel(oPC);
    int classSkill = FALSE;
    if(GetLevelByClass(CLASS_TYPE_CLERIC,oPC)>0 || GetLevelByClass(CLASS_TYPE_DRUID,oPC)>0 || GetLevelByClass(CLASS_TYPE_RANGER,oPC)>0) classSkill = TRUE;
    int nMaxSkill = nLevel + 3;
    //if(classSkill==FALSE)nMaxSkill = nMaxSkill/2;

    return nMaxSkill;
}

int GetSkillCost(int nLevel)
{
    if(nLevel==1)return 25;
    nLevel--;
    return GetSkillCost(nLevel)+nLevel*25;
}
