////////////////////////////////////////////////////////////////////////////////
// Loktar Fruit Script                                                        //
// by Arikel Tolifen                                                          //
// Grants immunity to fear for Half Orcs and Orcs, but those who are not and  //
// use it must make a DC(18) Saving Throw or become sick.                     //
////////////////////////////////////////////////////////////////////////////////
effect eEffect;
object oTarget;

void main()
{
object oPC;

    if ((GetRacialType(oPC)==RACIAL_TYPE_HALFORC))
    {
    oPC = GetItemActivator();

    oTarget = oPC;

    eEffect = EffectImmunity(IMMUNITY_TYPE_FEAR);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 60.0f);

    }
        else if (FortitudeSave(oPC, 18))
        {
        oTarget = oPC;

        eEffect = EffectImmunity(IMMUNITY_TYPE_FEAR);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 60.0f);

        }
    else
    {
    oTarget = oPC;

    eEffect = EffectDazed();

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 60.0f);

    eEffect = EffectPoison(POISON_BLOODROOT);

   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 60.0f);

    }

}

