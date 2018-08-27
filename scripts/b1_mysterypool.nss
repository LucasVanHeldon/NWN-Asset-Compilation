#include "nw_o2_coninclude"

void DestroySlimes()
{
    object o = GetFirstObjectInShape(SHAPE_SPHERE,30.0,
                        GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(o))
    {
        if(GetTag(o) == "ZEP_GREENSLIMEL")
        {
            DestroyObject(o,1.0);
        }
        o = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
}

void main()
{
    object oItem = GetFirstItemInInventory();
    if(GetLocalInt(OBJECT_SELF,"bPurified") == 1) return;

    while(GetIsObjectValid(oItem))
    {
        if(GetTag(oItem) == "NW_IT_MPOTION009")
        {
            SetLocalInt(OBJECT_SELF,"bPurified",1);
            DestroyObject(oItem);
            CreateItemOnObject("NW_WMGST004");
            CreateItemOnObject("rodofgreatermagi");
            int n = d10(4);
            int i;
            for(i =0 ; i < n; i++)
            {
                CreateGem(OBJECT_SELF,GetLastOpener(),2);
            }
            DestroyObject(GetObjectByTag("ZugblubtheSlimeDemon"),1.0);
            DestroyObject(GetObjectByTag("slime_light"),1.0);
            DestroySlimes();
            AddJournalQuestEntry("b1_mysterious_pool",2,GetLastOpener());
            return;
        }
        oItem = GetNextItemInInventory();
    }
    if(!GetLocalInt(OBJECT_SELF,"bPurified"))
    {
        CreateObject(OBJECT_TYPE_CREATURE,"ZEP_GREENSLIMEL",GetLocation(GetLastOpenedBy()));
    }
}
