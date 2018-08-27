void MMPMRBD_Darkness(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DARKNESS,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_HoldPerson(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_HOLD_PERSON,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}


void MMPMRBD_HoldMonster(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_HOLD_MONSTER,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_Contagion(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_CONTAGION,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}


void MMPMRBD_Bane(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_BANE,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_BestowCurse(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_BESTOW_CURSE,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_DispelMagic(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DISPEL_MAGIC,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_Doom(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DOOM,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_EnergyDrain(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ENERGY_DRAIN,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_EvilBlight(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_EVIL_BLIGHT,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_GhoulTouch(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_GHOUL_TOUCH,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_HorridWilting(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_HORRID_WILTING,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_InfestationOfMaggots(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_INFESTATION_OF_MAGGOTS,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_NegativeEnergyBurst(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_BESTOW_CURSE,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_PhantasmalKiller(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_BESTOW_CURSE,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_VampiricTouch(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_WailOfTheBanshee(object oSkin)
{
    itemproperty ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_BESTOW_CURSE,GetHitDice(OBJECT_SELF));
    IPSafeAddItemProperty(oSkin,ip);

}

void MMPMRBD_PulseDrainCHA(object oSkin, int num=1)
{
    SetLocalInt(OBJECT_SELF,"bPDCHA",num);
}

void MMPMRBD_PulseDrainINT(object oSkin, int num=1)
{
    SetLocalInt(OBJECT_SELF,"bPDINT",num);
}

void MMPMRBD_PulseDrainWIS(object oSkin, int num=1)
{
    SetLocalInt(OBJECT_SELF,"bPDWIS",num);
}

void MMPMRBD_PulseDrainCON(object oSkin, int num=1)
{
    SetLocalInt(OBJECT_SELF,"bPDCON",num);
}

void MMPMRBD_PulseDrainDEX(object oSkin, int num=1)
{
    SetLocalInt(OBJECT_SELF,"bPDDEX",num);
}

void MMPMRBD_PulseDrainSTR(object oSkin, int num=1)
{
    SetLocalInt(OBJECT_SELF,"bPDSTR",num);
}

void MMPMRBD_PulseLevelDrain(object oSkin, int num=1)
{
    SetLocalInt(OBJECT_SELF,"bPDLVL",num);
}

void MMPMRBD_PulseNegative(object oSkin, int num=1)
{
    SetLocalInt(OBJECT_SELF,"bPNEG",num);
}

void MMP_MorbidTemplate(object oSkin)
{
    int die = Die(25);
    int nEffect;

    switch(die)
    {
    case 1:
        MMPMRBD_PulseDrainDEX(oSkin,d6());
        break;
    case 2:
        MMPMRBD_Contagion(oSkin);
        break;
    case 3:
        MMPMRBD_HoldPerson(oSkin);
        break;
    case 4:
        MMPMRBD_HoldMonster(oSkin);
        break;
    case 5:
        MMPMRBD_PulseDrainCHA(oSkin,d6());
        break;
    case 6:
        MMPMRBD_PulseDrainINT(oSkin,d6());
        break;
    case 7:
        MMPMRBD_PulseDrainWIS(oSkin,d6());
        break;
    case 8:
        MMPMRBD_PulseDrainCON(oSkin,d6());
        break;
    case 9:
        MMPMRBD_PulseLevelDrain(oSkin,d6());
        break;
    case 10:
        MMPMRBD_Darkness(oSkin);
        break;
    case 11:
        MMPMRBD_Bane(oSkin);
        break;
    case 12:
        MMPMRBD_BestowCurse(oSkin);
        break;
    case 13:
        MMPMRBD_DispelMagic(oSkin);
        break;
     case 14:
        MMPMRBD_Doom(oSkin);
        break;
    case 15:
        MMPMRBD_EnergyDrain(oSkin);
        break;
    case 16:
        MMPMRBD_EvilBlight(oSkin);
        break;
    case 17:
        MMPMRBD_GhoulTouch(oSkin);
        break;
    case 18:
        MMPMRBD_HorridWilting(oSkin);
        break;
    case 19:
        MMPMRBD_InfestationOfMaggots(oSkin);
        break;
    case 20:
        MMPMRBD_NegativeEnergyBurst(oSkin);
        break;
    case 21:
        MMPMRBD_PhantasmalKiller(oSkin);
        break;
    case 22:
        MMPMRBD_VampiricTouch(oSkin);
        break;
    case 23:
        MMPMRBD_PulseNegative(oSkin);
        break;
    default:
        MMPMRBD_PulseDrainSTR(oSkin,d6());
        break;
    }
}

