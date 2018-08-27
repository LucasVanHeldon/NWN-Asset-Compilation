#include "NW_I0_GENERIC"
void main()
{
    // enter desired behaviour here
    int iEvent = GetUserDefinedEventNumber();

    if (iEvent == 1010) {
        location MyLoc = GetLocalLocation(OBJECT_SELF,"MyLocation");
        location MyLoc2 = GetLocation(GetObjectByTag("SP_2"));
        location MyLoc3 = GetLocation(GetObjectByTag("SP_3"));
        location MyLoc4 = GetLocation(GetObjectByTag("SP_4"));
        effect MyEffect = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, MyEffect, MyLoc, 0.0);
        CreateObject(OBJECT_TYPE_CREATURE,"nihilistofthariz",MyLoc,TRUE);
        CreateObject(OBJECT_TYPE_CREATURE,"nihilistofthariz",MyLoc2,TRUE);
        CreateObject(OBJECT_TYPE_CREATURE,"nihilistofthariz",MyLoc3,TRUE);
        CreateObject(OBJECT_TYPE_CREATURE,"nihilistofthariz",MyLoc4,TRUE);
        DeleteLocalLocation(OBJECT_SELF,"MyLocation");
    } // 1010

}
