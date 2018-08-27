#include "NW_I0_Plot"
void main()
{
    object oItem = GetInventoryDisturbItem();
    int nItemBase = GetBaseItemType(oItem);
    int nNumGems = GetLocalInt(OBJECT_SELF, "NumGems");
    if(GetLocalInt(OBJECT_SELF,"coc_i_statue") == FALSE &&
       GetTag(oItem) == "catseyegem")
     {
        DestroyObject(oItem);
        FloatingTextStringOnCreature("The gem locks into place in an eye-socket.", GetLastUsedBy());
        if (nNumGems > 0) {
            SetLocalInt(OBJECT_SELF,"coc_i_statue",TRUE);
            RewardXP("m1q1_Never",100,GetLastUsedBy());
            // Appearance of the lost god +
            location lStatue = GetLocation(OBJECT_SELF);
            DestroyObject(OBJECT_SELF);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), lStatue);
            CreateObject(OBJECT_TYPE_CREATURE, "misshapenaberrat", lStatue, TRUE);
        }
        nNumGems++;
        SetLocalInt(OBJECT_SELF, "NumGems", nNumGems);
    }
}
