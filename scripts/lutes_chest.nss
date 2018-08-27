#include "lutes"

void main()
{
    object oLastOpener = GetLastOpener();

    int iC1 = GetClassByPosition(1,oLastOpener);
    int iC2 = GetClassByPosition(2,oLastOpener);
    int iC3 = GetClassByPosition(3,oLastOpener);

    if(iC1 == CLASS_TYPE_FIGHTER ||
       iC2 == CLASS_TYPE_FIGHTER ||
       iC3 == CLASS_TYPE_FIGHTER) bFighter = TRUE;
    if(iC1 == CLASS_TYPE_PALADIN ||
       iC2 == CLASS_TYPE_PALADIN ||
       iC3 == CLASS_TYPE_PALADIN) bPaladin = TRUE;
    if(iC1 == CLASS_TYPE_RANGER ||
       iC2 == CLASS_TYPE_RANGER ||
       iC3 == CLASS_TYPE_RANGER) bRanger = TRUE;
    if(iC1 == CLASS_TYPE_MONK ||
       iC2 == CLASS_TYPE_MONK ||
       iC3 == CLASS_TYPE_MONK)
       {
            bMonk = TRUE;
            bRogue = TRUE;
            bFighter = TRUE;
        }


    if(iC1 == CLASS_TYPE_WIZARD || iC1 == CLASS_TYPE_SORCERER ||
        iC2 == CLASS_TYPE_WIZARD || iC2 == CLASS_TYPE_SORCERER ||
        iC3 == CLASS_TYPE_WIZARD || iC3 == CLASS_TYPE_SORCERER)
            bWizard = TRUE;
    if(iC1 == CLASS_TYPE_CLERIC ||
        iC2 == CLASS_TYPE_CLERIC ||
        iC3 == CLASS_TYPE_CLERIC) bCleric = TRUE;
    if(iC1 == CLASS_TYPE_DRUID ||
        iC2 == CLASS_TYPE_DRUID ||
        iC3 == CLASS_TYPE_DRUID) bDruid = TRUE;
    if(iC1 == CLASS_TYPE_ROGUE ||
        iC2 == CLASS_TYPE_ROGUE ||
        iC3 == CLASS_TYPE_ROGUE) bRogue = TRUE;
    if(iC1 == CLASS_TYPE_ASSASSIN ||
        iC2 == CLASS_TYPE_ASSASSIN ||
        iC3 == CLASS_TYPE_ASSASSIN) bAssassin = TRUE;


    iChestLevel = GetCharacterLevel(oLastOpener);
    Lutes(OBJECT_SELF);
}

