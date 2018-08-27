#include "lutes"


int LOW_GEM = 25;
int LOW_JEWEL = 25;
int LOW_POTION = 25;
int LOW_GOLD = 60;
int LOW_AMMO = 25;
int LOW_SCROLL = 25;

int MED_GEM = 55 ;
int MED_JEWEL = 55;
int MED_POTION = 50;
int MED_GOLD    = 85;
int MED_AMMO = 50;
int MED_SCROLL = 50;

int HIGH_GEM = 75;
int HIGH_JEWEL = 75;
int HIGH_POTION = 75;
int HIGH_GOLD = 100;
int HIGH_AMMO = 75;
int HIGH_SCROLL = 75;

int IsCleric(object oTarget)
{
    int i=1;
    for(i = 1; i < 4; i++)
    {
        if(GetClassByPosition(i,oTarget) == CLASS_TYPE_CLERIC)
            return TRUE;
    }
    return FALSE;
}

void TRS_CreateGem(int n)
{
    int i;
    for(i = 0; i < n; i++)
    {
        CreateGem(OBJECT_SELF,GetLastOpener(), Random(100));
    }
}

void TRS_CreateJewel(int n)
{
    int i;
    for(i = 0; i < n; i++)
    {
        CreateJewel(OBJECT_SELF,GetLastOpener(), Random(100));
    }
}

void TRS_CreatePotion(int n)
{
    int i;
    for(i = 0; i < n; i++)
    {
        CreatePotion(OBJECT_SELF,GetLastOpener());
    }
}

void TRS_CreateGold(int iGold)
{
    int i;
    CreateItemOnObject("nw_it_gold001", OBJECT_SELF, iGold);

}

void TRS_CreateScroll(int n)
{
    int i;
    for(i = 0; i < n; i++)
    {
        int n = d2();
        if( IsCleric(OBJECT_SELF) ) n = 2;
        else n = 1;
        switch(n)
        {
        case 1: CreateArcaneScroll(OBJECT_SELF,GetLastOpener(), Random(100)); break;
        case 2: CreateDivineScroll(OBJECT_SELF,GetLastOpener(), Random(100)); break;
        }
    }
}


void TRS_GenerateLow()
{
    if(d100() <= LOW_GEM)
    {
        TRS_CreateGem(d4());
    }
    if(d100() <= LOW_JEWEL)
    {
        TRS_CreateJewel(d2());
    }
    if(d100() <= LOW_POTION)
    {
        TRS_CreatePotion(d4());
    }
    if(d100() <= LOW_GOLD)
    {
        TRS_CreateGold(d100());
    }
    if(d100() <= LOW_AMMO)
    {
        CreateAmmo(OBJECT_SELF,GetLastOpener(),d100());
    }
}

void TRS_GenerateMed()
{
    if(d100() <= MED_GEM)
    {
        TRS_CreateGem(d4());
    }
    if(d100() <= MED_JEWEL)
    {
        TRS_CreateJewel(d2());
    }
    if(d100() <= MED_POTION)
    {
        TRS_CreatePotion(d4());
    }
    if(d100() <= MED_GOLD)
    {
        TRS_CreateGold(d100(10));
    }
    if(d100() <= MED_AMMO)
    {
        CreateAmmo(OBJECT_SELF,GetLastOpener(),d100());
    }
}


void TRS_GenerateHigh()
{
    if(d100() <= HIGH_GEM)
    {
        TRS_CreateGem(d4());
    }
    if(d100() <= HIGH_JEWEL)
    {
        TRS_CreateJewel(d2());
    }
    if(d100() <= HIGH_POTION)
    {
        TRS_CreatePotion(d4());
    }
    if(d100() <= HIGH_SCROLL)
    {
        TRS_CreatePotion(d4());
    }
    if(d100() <= HIGH_GOLD)
    {
        TRS_CreateGold(d100(25));
    }
    if(d100() <= HIGH_AMMO)
    {
        CreateAmmo(OBJECT_SELF,GetLastOpener(),d100());
    }
}

